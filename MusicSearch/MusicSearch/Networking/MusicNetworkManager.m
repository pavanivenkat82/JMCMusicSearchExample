//
//  MusicNetworkManager.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicNetworkManager.h"
#import "NSString+Encoding.h"
#import "MusicSearchAppUtil.h"
#import "MusicSearchJSONUntil.h"



@interface MusicNetworkManager()<NSURLSessionDelegate,NSURLSessionDataDelegate>
@property (nonatomic) NSMutableData* responseData;
@property (nonatomic) MusicRequestData* reqData;
@end
@implementation MusicNetworkManager
-(void) setPostParametersForRequest:(NSMutableURLRequest*)request requestData:(MusicRequestData*) reqData
{
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if(!reqData.inputParams || [reqData.inputParams count] == 0)
    {
        return;
        
    }
    
    
    NSMutableString* paramString = [NSMutableString stringWithString:@""];
    
    [reqData.inputParams enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop)
     {
         
         if(key.description.length == 0)
             return ;
         if(obj.description.length == 0)
         {
             obj = @"";
         }
         
         if(paramString.length)
             [paramString appendFormat:@"&%@=%@",[key.description urlEncodedString],[obj.description urlEncodedString]];
         else
             [paramString appendFormat:@"%@=%@",[key.description urlEncodedString],[obj.description urlEncodedString]];
     }];
    //    [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    reqData.url = [NSString stringWithFormat:@"%@",reqData.url];
    //application/zip
    //    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/zip; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    DLog(@"paramString %@",paramString);
    if(reqData.networkRequestType == MusicNetworkRequestTypePOST)
    {
        DLog(@"Setting Post data");
        [request setHTTPMethod:@"POST"];
        [request setURL:[NSURL URLWithString: reqData.url]];
        [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        reqData.url = [NSString stringWithFormat:@"%@?%@",reqData.url,paramString];
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString: reqData.url]];
        DLog(@"paramString %@",reqData.url);
    }
}


+(NSOperationQueue*) networkQueue
{
    static NSOperationQueue *networkOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkOperationQueue = [[NSOperationQueue alloc] init];
    });
    return networkOperationQueue;
}

-(void) sendAsynchronousRequestWithCustomDelegate:(MusicRequestData*) requestData
{
    
    _reqData = requestData;
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.timeoutIntervalForRequest = requestData.timeOutForRequest;
    configuration.timeoutIntervalForResource = requestData.timeOutForResource;
    //    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[MusicNetworkManager networkQueue]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    //    [self setHeadersForRequest:request requestData:requestData];
    [self setPostParametersForRequest:request requestData:requestData];
    //    [self setHeadersForRequest:request requestData:requestData];
    DLog(@"Request URL: %@",request.URL);
    
    NSURLSessionDataTask* datatask = [session dataTaskWithRequest:request];
    [datatask resume];
}

-(void) sendAsynchronousRequest:(MusicRequestData*) requestData
{
    NSDate* startDate = [NSDate date];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    //    [self setHeadersForRequest:request requestData:requestData];
    [self setPostParametersForRequest:request requestData:requestData];
    //    [self setHeadersForRequest:request requestData:requestData];
    DLog(@"Request URL: %@",[request.URL absoluteString]);
    
    
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    configuration.timeoutIntervalForRequest = requestData.timeOutForRequest;
    configuration.timeoutIntervalForResource = requestData.timeOutForResource;
    //    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                                      DLog(@"sttaus code %li", (long)httpResp.statusCode);
                                      NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      DLog(@"Response Data %@",responseString);
                                      
                                      if(requestData.serviceType == MusicSearchServiceTypeLyricsInfo)
                                      {
                                          if([responseString hasPrefix:@"song = "])
                                          {
                                              NSRange rOriginal = [responseString rangeOfString: @"song = "];
                                              if (NSNotFound != rOriginal.location)
                                              {
                                                  responseString = [responseString stringByReplacingCharactersInRange: rOriginal  withString: @""];
                                              }
                                              responseString = [responseString stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
                                              data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                              
                                              DLog(@" formatted string %@",responseString);
                                          }
                                      }
                                      NSDictionary* responseDict = [MusicSearchJSONUntil convertJSONDataToDictionary:data];
                                      
                                      MusicResponseData* responseData = [[MusicResponseData alloc] initWithDictionary:responseDict serviceType:requestData.serviceType];
                                      double timeTaken = [startDate timeIntervalSinceNow];
                                      
                                      DLog(@"%f Seconds for the request %@", timeTaken, [request.URL absoluteString]);
                                      DLog(@"===================================");
                                      
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          //TODO check
                                          [self.networkResponseDelegate sendResponseData:responseData];
                                      });
                                  }];
    
    [task resume];
}

#pragma mark - NSURLSession delegate
-(void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    NSMutableURLRequest *newRequest = [request mutableCopy];
    NSLog(@"New URL is %@, Code %lu",[newRequest.URL absoluteString],response.statusCode);
    
    //    newRequest.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&j=1",[newRequest.URL absoluteString]]];
    NSLog(@"URL is %@",[newRequest.URL absoluteString]);
    completionHandler(newRequest);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    _responseData = [[NSMutableData alloc] init];
    NSLog(@"didReceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
    NSLog(@"didReceiveData");
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"totalBytesExpectedToSend %lld",totalBytesExpectedToSend);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error)
    {
        NSLog(@"Got error %@",error);
    }
    else
    {
        NSLog(@"GOt the full response");
        NSString* str = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Response %@",str);
        NSDictionary* responseDict = [MusicSearchJSONUntil convertJSONDataToDictionary:_responseData];
        
        MusicResponseData* responseData = [[MusicResponseData alloc] initWithDictionary:responseDict serviceType:_reqData.serviceType];
        if(responseData)
            DLog(@"Got responseData");
        else
            DLog(@" DID not get responseData");
        dispatch_async(dispatch_get_main_queue(), ^{
            //TODO check
            DLog(@"making network call");
            [self.networkResponseDelegate sendResponseData:responseData];
        });
    }
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    NSLog(@"didBecomeInvalidWithError %@",error);
    
}
@end
