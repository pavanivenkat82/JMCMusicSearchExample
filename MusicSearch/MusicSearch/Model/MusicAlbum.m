//
//  MusicAlbum.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicAlbum.h"
@import UIKit;

@implementation MusicAlbum

//Creating MusicAlbum based upon the dictionary provided. And getting the information which is needed based upon the requirement
-(instancetype) initWithDictionary:(NSDictionary*) dictAlbum
{

    self = [super init];
    
    if(self)
    {
        _albumName = dictAlbum[kJSONCollectionName];
        _artistName = dictAlbum[kJSONArtistName];
        _trackName = dictAlbum[kJSONtrackName];
        
        _imageUrl = dictAlbum[kJSONArtworkUrl60];
        _mainImageUrl = dictAlbum[kJSONArtworkUrl100];
        
    }
    return self;
}
@end
