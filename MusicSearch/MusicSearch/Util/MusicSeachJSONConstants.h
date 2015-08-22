//
//  MusicSeachJSONConstants.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/22/15.
//  Copyright (c) 2015 Pavani Repalle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicSeachJSONConstants : NSObject
//Request
#define kJSONTerm               @"term"
#define kJSONFunction           @"func"
#define kJSONArtist             @"artist"
#define kJSONSong               @"song"
#define kJSONFormat             @"fmt"



//Values
#define kJSONFunctionGetSong    @"getSong"
#define kJSONFormatJSON         @"json"

//func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json
//Response parameters
#define kJSONResultCount        @"resultCount"
#define kJSONResults            @"results"
#define kJSONArtistName         @"artistName"
#define kJSONCollectionName     @"collectionName"
#define kJSONtrackName          @"trackName"
#define kJSONArtworkUrl30       @"artworkUrl30"
#define kJSONArtworkUrl60       @"artworkUrl60"
#define kJSONArtworkUrl100      @"artworkUrl100"
#define kJSONLyrics              @"lyrics"

//Network URLs
#define kNetworkURLSearchMusicList  @"https://itunes.apple.com/search"
#define kNetworkURLLyricsWIKI       @"http://lyrics.wikia.com/api.php"
@end
