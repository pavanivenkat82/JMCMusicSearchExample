//
//  MusicMobileObject.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani. All rights reserved.
//

#import "MusicMobileObject.h"

@implementation MusicMobileObject

-(instancetype) initWithErrorCode:(int) code message:(NSString*) message
{
    self = [super init];
    
    if(self)
    {
        _error = [[MusicError alloc] initWithErrorCode:code message:message];
    }
    
    return self;
}
@end
