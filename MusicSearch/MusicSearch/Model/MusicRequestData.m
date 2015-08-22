//
//  MusicRequestData.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicRequestData.h"
#import "MusicSearchAppUtil.h"

@implementation MusicRequestData


-(instancetype) initWithURL:(NSString*) reqUrl networkRequestType:(MusicNetworkRequestType) nReqType serviceType:(MusicSearchServiceType) reqServiceType inputPrameters:(NSDictionary*) inputParameter
{
    self = [super init];
    
    if(self)
    {
        _url = reqUrl;
        _networkRequestType = nReqType;
        _serviceType = reqServiceType;
        _inputParams  = inputParameter;
        _timeOutForRequest = 30;
        _timeOutForResource = 300;
        _isPostData = NO;
    }
    
    return self;
}


@end