//
//  SearchResultsCollectionViewController.m
//  UnsplashAPITestApp
//
//  Created by Андрей on 30.07.2019.
//  Copyright © 2019 Андрей. All rights reserved.
//

#import "SearchResultsCollectionViewController.h"
#import "ANServerManager.h"
#import "SearchResultsCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"



@interface SearchResultsCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *photosURLs;

@property (assign, nonatomic) NSUInteger numberOfItems;
@property (assign, nonatomic) CGSize cellSize;
@property (assign, nonatomic) UIEdgeInsets cellInsets;

@end



@implementation SearchResultsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.headerText;
    
    self.photosURLs = [NSMutableArray array];
    self.numberOfItems = 100;
    
    self.cellInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat cellWidth = self.view.frame.size.width/2 - self.cellInsets.left - self.cellInsets.right;
    self.cellSize = CGSizeMake(cellWidth, cellWidth);
    
    [self getPhotosFromServer];
}

- (void)getPhotosFromServer {
    
    [[ANServerManager sharedManager]
     getPhotosFromServerWithQuery:self.headerText
     quantityPerPage:self.numberOfItems
     onSuccess:^(NSArray *newPhotosURLs) {
         [self.photosURLs addObjectsFromArray:newPhotosURLs];
         if (self.photosURLs.count < self.numberOfItems)
             self.numberOfItems = self.photosURLs.count;
         [self.collectionView reloadData];
     }
     onFailure:^(NSError *error, NSUInteger statusCode) {
         NSLog(@"Error = %@ code = %lu", [error localizedDescription], statusCode);
     }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const reuseIdentifier = @"SearchResultsCollectionViewCellID";
    
    __weak SearchResultsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = nil;
    [cell.activityIndicator setHidden:NO];
    [cell.activityIndicator startAnimating];
    
    // Configure the cell
    if (self.photosURLs.count != 0) {
        
        NSURLRequest *URLRequest = [NSURLRequest requestWithURL:self.photosURLs[indexPath.row]];
        [cell.imageView setImageWithURLRequest:URLRequest
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           [cell.imageView setImage:image];
                                           [cell.activityIndicator setHidden:YES];
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           NSLog(@"Error: %@", error.localizedDescription);
                                       }];
    }
    
    return cell;
}


#pragma mark <UICollectionViewFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return self.cellInsets;
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
