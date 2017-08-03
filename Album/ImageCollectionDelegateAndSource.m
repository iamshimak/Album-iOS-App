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

        [self compressImage:responseObject onCompletion:^(UIImage *compressedImage) {
            indicator.hidden = YES;
            [indicator stopAnimating];

            if (compressedImage) {
                imageView.image = compressedImage;
            } else {
                imageView.image = responseObject;
            }
        }];

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

- (void)setCellSize:(CGFloat)size {
    cellSize = size;
}

- (void)compressImage:(UIImage *)inputImage onCompletion:(void (^)(UIImage *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *compressedImage = [self compressImage:inputImage];

        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(compressedImage);
            });
        }
    });
}

- (UIImage *)compressImage:(UIImage *)imageToCompress {
    return [self compressImage:imageToCompress compressRatio:0.0 maxCompressRatio:0.1f];
}

- (UIImage *)compressImage:(UIImage *)image compressRatio:(CGFloat)ratio maxCompressRatio:(CGFloat)maxRatio {

    //We define the max and min resolutions to shrink to
    int MIN_UPLOAD_RESOLUTION = 568 * 320;
    int MAX_UPLOAD_SIZE = 50;

    float factor;
    float currentResolution = image.size.height * image.size.width;

    //We first shrink the image a little bit in order to compress it a little bit more
    if (currentResolution > MIN_UPLOAD_RESOLUTION) {
        factor = sqrt(currentResolution / MIN_UPLOAD_RESOLUTION) * 2;
        image = [self scaleDown:image withSize:CGSizeMake(image.size.width / factor, image.size.height / factor)];
    }

    //Compression settings
    CGFloat compression = ratio;
    CGFloat maxCompression = maxRatio;

    //We loop into the image data to compress accordingly to the compression ratio
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > MAX_UPLOAD_SIZE && compression > maxCompression) {
        compression -= 0.25;
        imageData = UIImageJPEGRepresentation(image, compression);
    }

    //Retuns the compressed image
    return [[UIImage alloc] initWithData:imageData];
}

- (UIImage *)scaleDown:(UIImage *)image withSize:(CGSize)newSize {

    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);

    //Draws a rect for the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];

    //We set the scaled image from the context
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return scaledImage;
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

    return [(ImageCollectionDelegateAndSource *) collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                          forIndexPath:indexPath
                                                                                              imageURL:imageURL];
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
