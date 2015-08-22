//
//  AlbumTableViewCell.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import <UIKit/UIKit.h>

//Creating custom cell
@interface AlbumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lblTrack;
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbum;

@end
