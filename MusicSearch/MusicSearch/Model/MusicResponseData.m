//
//  MusicResponseData

//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicResponseData.h"


@implementation MusicResponseData

// Network deletgate always pass back the Response object which have the parent object MusicMobileObject always.

-(instancetype) initWithDictionary:(NSDictionary*) jsonDictionary serviceType:(MusicSearchServiceType) serviceType
{
    self = [super init];
    if(self)
    {
        _serviceType = serviceType;
        
        if(!jsonDictionary || [jsonDictionary count] == 0)
        {
            _mobileData = [[MusicMobileObject alloc] initWithErrorCode:1000 message:@"There is some issue"];
        }
        else if (serviceType == MusicSearchServiceTypeGetLyricsList)
        {
            _mobileData = [[MusicSearchResults alloc] initWithDictionary:jsonDictionary];
        }
        else if (serviceType == MusicSearchServiceTypeLyricsInfo)
        {
            _mobileData = [[LyricsInfo alloc] initWithDictionary:jsonDictionary];
        }
       
    }
    
    return self;
}


@end
