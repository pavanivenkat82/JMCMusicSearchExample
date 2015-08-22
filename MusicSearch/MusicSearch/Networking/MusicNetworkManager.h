//
//  MusicNetworkManager.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicRequestData.h"
#import "MusicResponseData.h"
#import "MusicSeachJSONConstants.h"

@protocol MusicNetworkManagerDelegate <NSObject>

-(void) sendResponseData:(MusicResponseData*) responseData;

@end

@interface MusicNetworkManager : NSObject

@property (nonatomic,weak) id<MusicNetworkManagerDelegate> networkResponseDelegate;

-(void) sendAsynchronousRequest:(MusicRequestData*) requestData;
-(void) sendAsynchronousRequestWithCustomDelegate:(MusicRequestData*) requestData;
@end