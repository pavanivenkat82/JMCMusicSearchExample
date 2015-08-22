//
//  MusicResponseData.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

@import Foundation;
#import "MusicRequestData.h"
#import "MusicMobileObject.h"
#import "MusicSearchResults.h"
#import "LyricsInfo.h"


@interface MusicResponseData : NSObject
@property (nonatomic) MusicSearchServiceType serviceType;
@property (nonatomic) MusicMobileObject* mobileData;
@property (nonatomic) int responseCode;

-(instancetype) initWithDictionary:(NSDictionary*) jsonDictionary serviceType:(MusicSearchServiceType) serviceType;

@end
