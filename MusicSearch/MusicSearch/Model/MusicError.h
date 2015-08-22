//
//  MusicError.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 6/9/15.
//  Copyright (c) 2015 Pavani Repalle. All rights reserved.
//

//#import <Foundation/Foundation.h>
@import Foundation;

@interface MusicError : NSObject

@property (nonatomic) int code;
@property (nonatomic) NSString* message;

-(instancetype) initWithErrorCode:(int) errorCode message:(NSString*) message;
@end
