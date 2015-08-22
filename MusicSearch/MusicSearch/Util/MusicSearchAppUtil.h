//
//  MusicSearchAppUtil.h
//  MusicSearch
//
//  Created by Pavani Repalle. on 5/12/15.
//  Copyright (c) 2015 Pavani Repalle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicSearchAppUtil : NSObject

//#define kTIMEOUT_INTERVAL            150

//Pring NSLong only in the release mode
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif
@end
