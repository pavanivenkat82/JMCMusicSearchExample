//
//  LyricsDetailViewController.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "MusicNetworkManager.h"

@interface AlbumDetailViewController ()<MusicNetworkManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lblTrack;
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbum;

@property (weak, nonatomic) IBOutlet UITextView *txtDesctiption;

@end

@implementation AlbumDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Album Details";
    [self makeLyricsNetworkCall];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Search";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    DLog(@"Album Name %@",self.selectedAlbum.albumName);
    [self loadImageView];
    [self updateLabels];

}

-(void) loadImageView
{
    // Load the image with an GCD block executed in another thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.selectedAlbum.mainImageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage* image = [UIImage imageWithData:data];
            
            _imgAlbum.image = image;
        });
    });
}

-(void) updateLabels
{
    _lblAlbum.text = _selectedAlbum.albumName;
    _lblAlbum.numberOfLines = 0;
    [_lblAlbum sizeToFit];
    _lblArtist.text = _selectedAlbum.artistName;
    _lblTrack.text = _selectedAlbum.trackName;
    
   
}



//-(void) updateTextFieldLookAndFeel
//{
//    _lblHeader.textColor = [self colorFromHexString:kHeaderTextColor];
//    _lblEnterYourPwd.textColor = _lblTokenCode.textColor = _lblPasscode.textColor = _lblYourPasscode.textColor  = [self colorFromHexString:kLabelTextColor];
//    _lblYourPasscode.numberOfLines = 0;
//    [_lblYourPasscode sizeToFit];
//    _lblTokenCode.numberOfLines = 0;
//    [_lblTokenCode sizeToFit];
//    [[_txtTokenCode layer] setBorderWidth:1.0f];
//    [[_txtTokenCode layer] setBorderColor:[self colorFromHexString:kTextfiledBorderColor].CGColor];
//}
//
//-(void) updateButtons
//{
//    [[_btnContinue layer] setBorderWidth:1.0f];
//    [[_btnContinue layer] setBorderColor:[self colorFromHexString:kPositiveButtonBorderColor].CGColor];
//    [[_btnCancel layer] setBorderWidth:1.0f];
//    [[_btnCancel layer] setBorderColor:[self colorFromHexString:kNagativeButtonBorderColor].CGColor];
//    _btnContinue.layer.cornerRadius = 5;
//    _btnCancel.layer.cornerRadius = 5;
//    _btnCancel.backgroundColor = [self colorFromHexString:kNagativeButtonBackgroundColor];
//    _btnContinue.backgroundColor = [self colorFromHexString:kPositiveButtonBackgroundColor];
//    
//}
#pragma mark - Networking

-(void) makeLyricsNetworkCall
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSMutableDictionary* inputParams = [NSMutableDictionary dictionary];
    [inputParams setValue:kJSONFunctionGetSong	forKey:kJSONFunction];
    [inputParams setValue:_selectedAlbum.artistName	forKey:kJSONArtist];
    [inputParams setValue:_selectedAlbum.trackName	forKey:kJSONSong];
    [inputParams setValue:kJSONFormatJSON	forKey:kJSONFormat];
    //func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json
    MusicRequestData* reqData = [[MusicRequestData alloc] initWithURL:kNetworkURLLyricsWIKI networkRequestType:MusicNetworkRequestTypeGET serviceType:MusicSearchServiceTypeLyricsInfo inputPrameters:inputParams] ;
    
    MusicNetworkManager* manager = [[MusicNetworkManager alloc] init];
    manager.networkResponseDelegate = self;
    [manager sendAsynchronousRequest:reqData];
}


-(void) sendResponseData:(MusicResponseData*) responseData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(responseData.serviceType == MusicSearchServiceTypeLyricsInfo)
    {
        MusicMobileObject* mobileData = responseData.mobileData;
        if(mobileData.error)
        {
            //Display error
            _txtDesctiption.text = @"";
        }
        else
        {
            LyricsInfo* lyricsInfo = (LyricsInfo*) mobileData;
            _txtDesctiption.text = lyricsInfo.lyrics;
        }
        
    }
}
@end
