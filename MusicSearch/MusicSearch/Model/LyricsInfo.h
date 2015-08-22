//
//  LyricsInfo.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/22/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicMobileObject.h"

@interface LyricsInfo : MusicMobileObject

@property (nonatomic, readonly) NSString* lyrics;
-(instancetype) initWithDictionary:(NSDictionary*) dictLyrics;
@end
