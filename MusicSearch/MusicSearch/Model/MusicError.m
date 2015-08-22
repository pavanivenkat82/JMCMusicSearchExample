//
//  MusicError.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 6/9/15.
//  Copyright (c) 2015 Pavani Repalle. All rights reserved.
//

#import "MusicError.h"

@implementation MusicError

-(instancetype) initWithErrorCode:(int) errorCode message:(NSString*) message
{
    self = [super init];
    
    if(self)
    {
        _code = errorCode;
        _message = message;
    }
    
    return self;
}
@end
