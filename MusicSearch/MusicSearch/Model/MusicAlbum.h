//
//  MusicAlbum.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicMobileObject.h"

@interface MusicAlbum : MusicMobileObject

@property (nonatomic,readonly) NSString* artistName;
@property (nonatomic,readonly) NSString* trackName;
@property (nonatomic,readonly) NSString* albumName;
@property (nonatomic,readonly) NSString* imageUrl;
@property (nonatomic,readonly) NSString* mainImageUrl;

-(instancetype) initWithDictionary:(NSDictionary*) dictAlbum;
@end
