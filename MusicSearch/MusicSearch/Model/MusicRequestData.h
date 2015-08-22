//
//  MusicRequestData.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

@import Foundation;

//Created Enum for MusicNetworkRequestType
typedef NS_ENUM(NSInteger, MusicNetworkRequestType) {
    MusicNetworkRequestTypeGET,
    MusicNetworkRequestTypePOST
};

typedef NS_ENUM(NSInteger, MusicSearchServiceType)
{
    MusicSearchServiceTypeGetLyricsList,
    MusicSearchServiceTypeLyricsInfo
};

@interface MusicRequestData : NSObject
@property (nonatomic) NSString* url;
@property (nonatomic) MusicNetworkRequestType networkRequestType;
@property (nonatomic) MusicSearchServiceType serviceType;
@property (nonatomic) NSDictionary* inputParams;
@property (nonatomic) int timeOutForRequest;
@property (nonatomic) int timeOutForResource;

@property (nonatomic) BOOL isPostData;

-(instancetype) initWithURL:(NSString*) reqUrl networkRequestType:(MusicNetworkRequestType) nReqType serviceType:(MusicSearchServiceType) reqServiceType inputPrameters:(NSDictionary*) inputParameter;

@end

