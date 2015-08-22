//
//  MusicSearchJSONUntil.m
//  MusicSearch
//
//  Created by Pavani Repalle. on 6/9/15.
//  Copyright (c) 2015 Pavani Repalle. All rights reserved.
//

#import "MusicSearchJSONUntil.h"
#import "MusicSearchAppUtil.h"

@implementation MusicSearchJSONUntil



+(NSDictionary*) convertJSONDataToDictionary:(NSData*) jsonData
{
    NSError* error;
    if(!jsonData || jsonData.length == 0)
        return nil;
    
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    DLog(@"Json Dict %@",jsonDict);
    return jsonDict;
}

@end
