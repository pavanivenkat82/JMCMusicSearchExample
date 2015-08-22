//
//  MusicListViewController.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicNetworkManager.h"
#import "MusicSearchResults.h"
#import "AlbumTableViewCell.h"
#import "AlbumDetailViewController.h"

@interface MusicListViewController ()<MusicNetworkManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtSearchTerm;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;

@property (nonatomic) MusicSearchResults* searchResults;


@end

@implementation MusicListViewController

#pragma mark - View Coltroller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnGo.backgroundColor = [UIColor lightGrayColor];
    [[self.btnGo layer] setBorderWidth:1.0f];
    [[self.btnGo layer] setBorderColor:[UIColor redColor].CGColor];
    self.btnGo.layer.cornerRadius = 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - User Actions
- (IBAction)searchResults:(id)sender
{
    [self.txtSearchTerm resignFirstResponder];
    NSString* searchTerm = self.txtSearchTerm.text;
    [self makeSearchNetworkCall: searchTerm];
}

- (IBAction)editingChanged:(id)sender
{
    NSString* inputData = self.txtSearchTerm.text;
    //If it is valid number enable button and change the back ground color
    if(inputData && inputData.length > 3)
    {
        //Enable button
        self.btnGo.enabled = YES;
        self.btnGo.backgroundColor = [UIColor darkGrayColor];
        [[self.btnGo layer] setBorderWidth:1.0f];
        [[self.btnGo layer] setBorderColor:[UIColor greenColor].CGColor];
    }
    else
    {
        //Disable button
        self.btnGo.enabled = NO;
        self.btnGo.backgroundColor = [UIColor lightGrayColor];
        [[self.btnGo layer] setBorderWidth:1.0f];
        [[self.btnGo layer] setBorderColor:[UIColor redColor].CGColor];
    }
}

#pragma mark - Networking

-(void) makeSearchNetworkCall :(NSString*) searchTerm
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSMutableDictionary* inputParams = [NSMutableDictionary dictionary];
    [inputParams setValue:searchTerm	forKey:kJSONTerm];
    MusicRequestData* reqData = [[MusicRequestData alloc] initWithURL:kNetworkURLSearchMusicList networkRequestType:MusicNetworkRequestTypeGET serviceType:MusicSearchServiceTypeGetLyricsList inputPrameters:inputParams] ;
    
    MusicNetworkManager* manager = [[MusicNetworkManager alloc] init];
    manager.networkResponseDelegate = self;
    [manager sendAsynchronousRequest:reqData];
}


-(void) sendResponseData:(MusicResponseData*) responseData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(responseData.serviceType == MusicSearchServiceTypeGetLyricsList)
    {
        MusicMobileObject* mobileData = responseData.mobileData;
        if(mobileData.error)
        {
            //Display error
            _searchResults = [[MusicSearchResults alloc] init];
            [self.tableView reloadData];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No results" message:@"No results found. Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            MusicSearchResults* results = (MusicSearchResults*)responseData.mobileData;
            _searchResults = results;
            if(!_searchResults || !_searchResults.arrSearchResults || _searchResults.arrSearchResults.count == 0)
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No results" message:@"No results found. Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            [self.tableView reloadData];
        }
        
    }
}

#pragma mark - Table View Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_searchResults)
        return _searchResults.arrSearchResults.count;
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTableViewCell* albumCell = [tableView dequeueReusableCellWithIdentifier:@"MUSICCELL" forIndexPath:indexPath];
    MusicAlbum* albumData = self.searchResults.arrSearchResults[indexPath.row];
    albumCell.lblAlbum.text = albumData.albumName;
    albumCell.lblArtist.text = albumData.artistName;
    albumCell.lblTrack.text = albumData.trackName;
    
    // Load the image with an GCD block executed in another thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:albumData.imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *offersImage = [UIImage imageWithData:data];
            
            albumCell.imgAlbum.image = offersImage;
        });
    });
    
    return albumCell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"prepareForSegue %@ ",selectedIndexPath);
    AlbumDetailViewController* albumDetailVC = segue.destinationViewController;
    albumDetailVC.selectedAlbum = self.searchResults.arrSearchResults[selectedIndexPath.row];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
