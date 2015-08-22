//
//  MusicSearchResults.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 8/21/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicSearchResults.h"


@implementation MusicSearchResults

//Creating MusicSearchResults based upon the dictionary provided. Sorted results based upon track name.
-(instancetype) initWithDictionary:(NSDictionary*) dictResults
{
    self = [super init];
    
    if(self)
    {
        NSInteger resultsCount = [dictResults[kJSONResultCount] integerValue];
        //Check the results count and create Results only of there is atleast one result
        if(resultsCount > 0)
        {
            NSArray* arrTempResults = dictResults[kJSONResults];
            NSMutableArray* arrResults = [[NSMutableArray alloc] initWithCapacity:resultsCount];
            for (NSDictionary* dictAlbum in arrTempResults)
            {
                [arrResults addObject:[[MusicAlbum alloc] initWithDictionary:dictAlbum]];
            }
            //Sorting based upon track name
            
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"trackName" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            
            [arrResults sortUsingDescriptors:sortDescriptors];
            _arrSearchResults = arrResults;
        }
    }
    return self;
}
@end
