//
// Created by Ahamed Shimak on 8/2/17.
// Copyright (c) 2017 Ahamed Shimak. All rights reserved.
//

#import "Library.h"

@implementation Library {
    NSArray *imageCollection;
}

+ (id)sharedManager {
    static Library *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        imageCollection = [NSArray arrayWithObjects:@"https://cdn.pixabay.com/photo/2016/03/28/12/35/cat-1285634_960_720.png",
                           @"https://cdn.pixabay.com/photo/2014/09/30/21/15/mushroom-467553__340.jpg",
                           @"http://www.mybligr.com/wp-content/uploads/2017/01/most-beautiful-tiger-animals-pics-images-photos-pictures-6.jpg",
                           @"https://static01.nyt.com/images/2016/11/16/world/16Supermoon2/16Supermoon2-superJumbo.jpg",
                           @"http://www.lanlinglaurel.com/data/out/111/4912839-landscape-images.jpeg",
                           @"https://cdn.pixabay.com/photo/2017/04/06/20/15/owl-2209230__340.jpg",
                           @"https://static.pexels.com/photos/8700/wall-animal-dog-pet.jpg",
                           @"http://www.holifestival.org/images/holi-image-4-big.jpg",nil];
    }
    return self;
}

- (NSString *)indexOfImageURL:(int)index {
    return imageCollection[index];
}

- (int)imageCount {
    return [imageCollection count];
}


@end
