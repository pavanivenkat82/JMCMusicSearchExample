//
//  LyricsDetailViewController.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicAlbum.h"
//Make network call using MusicNetworkManager and get the response as delete call back. Based upon response, displaying the Lyrics information. If it is error then setting lyrics info to empty. Also WIKI url is not giving the proper JSON response. Once I get the response for the WIKI URL, I am doing some maniplation to get valid JSON. If we are the service provide we can do these kind of changes on the service level.
@interface AlbumDetailViewController : UIViewController
@property (nonatomic) MusicAlbum* selectedAlbum;
@end
