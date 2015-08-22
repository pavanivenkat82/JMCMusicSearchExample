//
//  MusicMobileObject.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicError.h"
#import "MusicSeachJSONConstants.h"
#import "MusicSearchAppUtil.h"



@interface MusicMobileObject : NSObject

@property (nonatomic) MusicError* error;

-(instancetype) initWithErrorCode:(int) code message:(NSString*) message;

@end
