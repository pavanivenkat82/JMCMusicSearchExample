//
//  MusicSearchResults.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicMobileObject.h"
#import "MusicAlbum.h"

@interface MusicSearchResults : MusicMobileObject

@property (nonatomic,readonly) NSArray* arrSearchResults;

-(instancetype) initWithDictionary:(NSDictionary*) dictResults;

@end
