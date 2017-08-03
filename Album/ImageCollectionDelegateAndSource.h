//
// Created by Ahamed Shimak on 8/2/17.
// Copyright (c) 2017 Ahamed Shimak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageCollectionDelegateAndSource : UICollectionView <NSURLSessionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
- (void) setCellSize:(CGFloat)size;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                                             forIndexPath:(NSIndexPath *)indexPath
                                                                 imageURL:(NSString *)imageURL;
@end