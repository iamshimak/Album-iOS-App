//
// Created by Ahamed Shimak on 8/2/17.
// Copyright (c) 2017 Ahamed Shimak. All rights reserved.
//

#import "ImageCollectionDelegateAndSource.h"
#import "Library.h"
#import <AFNetworking/AFImageDownloader.h>

@implementation ImageCollectionDelegateAndSource {
    CGFloat cellSize;
}
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                                             forIndexPath:(NSIndexPath *)indexPath
                                                                 imageURL:(NSString *)imageURL {

    UICollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *) [cell viewWithTag:111];

    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *) [cell viewWithTag:112];
    [indicator startAnimating];

    NSString *stringVideo = [NSString stringWithFormat:@"%@", imageURL];
    AFImageDownloader *dow = [[AFImageDownloader alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringVideo]];

    [dow downloadImageForURLRequest:request success:^(NSURLRequest *_Nonnull request, NSHTTPURLResponse *_Nullable response, UIImage *_Nonnull responseObject) {
        imageView.image = responseObject;
        indicator.hidden = YES;
        [indicator stopAnimating];

    }                       failure:^(NSURLRequest *_Nonnull request, NSHTTPURLResponse *_Nullable response, NSError *_Nonnull error) {
        //TODO set N/A image
        indicator.hidden = YES;
        [indicator stopAnimating];
    }];

    //    NSURL *url = [NSURL URLWithString:image];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *img = [[UIImage alloc] initWithData:data];
    //    //CGSize size = img.size;
    //    imageView.image = img;
    //
    //    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    //
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        //NSURLSessionDownloadTask *getImageTask =
    //        [[session downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:image]]
    //                        completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
    //
    //                            if (!error) {
    //                                //dispatch_async(dispatch_get_main_queue(), ^{
    //                                imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    //                                //});
    //
    //                                dispatch_async(dispatch_get_main_queue(), ^{
    //                                    indicator.hidden = YES;
    //                                    [indicator stopAnimating];
    //                                });
    //                            }
    //
    //
    //                        }] resume];
    //        //[getImageTask resume];
    //    });



    //    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:image]];
    //    [NSURLConnection sendAsynchronousRequest:request
    //                                       queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
    //
    //            if(!error) {
    //
    //            }
    //    }];

    return cell;
}

- (void) setCellSize:(CGFloat)size {
    cellSize = size;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

/*
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
 return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 20.0);
 }
 */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(cellSize, cellSize);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[Library sharedManager] imageCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    NSString *imageURL = [[Library sharedManager] indexOfImageURL:indexPath.row];
    UICollectionViewCell *cell = [(ImageCollectionDelegateAndSource *) collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                                   forIndexPath:indexPath
                                                                                                       imageURL:imageURL];

    //    UIImageView *imageView = (UIImageView *) [cell viewWithTag:111];
    //    NSURL *url = [NSURL URLWithString:];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *img = [[UIImage alloc] initWithData:data];
    //    //CGSize size = img.size;
    //    imageView.image = img;

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }

 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }

 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

 }
 */

@end
