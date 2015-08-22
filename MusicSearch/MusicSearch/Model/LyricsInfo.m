//
//  LyricsInfo.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/22/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "LyricsInfo.h"

@implementation LyricsInfo

//Creating LyricsInfo based upon the dictionary provided. And getting the information which is needed based upon the requirement
-(instancetype) initWithDictionary:(NSDictionary*) dictLyrics
{
    self = [super init];
    
    if(self)
    {
        _lyrics = dictLyrics[kJSONLyrics];
    }
    
    return self;
}
@end
