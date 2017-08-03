//
//  ImageCollectionViewController.m
//  Album
//
//  Created by Ahamed Shimak on 8/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "Library.h"
#import "ImageCollectionDelegateAndSource.h"

@interface ImageCollectionViewController () {
    
}

@property(weak, nonatomic) IBOutlet ImageCollectionDelegateAndSource *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *randomImage;

@end

@implementation ImageCollectionViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = _collectionView;
    self.collectionView.dataSource = _collectionView;
    [_collectionView setCellSize:[[UIScreen mainScreen] bounds].size.width / 2];
    self.navigationItem.title = @"Image Collection";
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRandomImage:(UIImageView *)randomImage {
    NSString *imgURL = [[Library sharedManager] indexOfImageURL:2];
    NSURL *url = [NSURL URLWithString:imgURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    randomImage.image = img;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
