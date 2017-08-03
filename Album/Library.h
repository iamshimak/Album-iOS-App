//
// Created by Ahamed Shimak on 8/2/17.
// Copyright (c) 2017 Ahamed Shimak. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Library : NSObject
+ (id)sharedManager;

- (NSString *)indexOfImageURL:(int)index;
- (int)imageCount;
@end