//
//  SearchResultsCollectionViewCell.h
//  UnsplashAPITestApp
//
//  Created by Андрей on 02.08.2019.
//  Copyright © 2019 Андрей. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

NS_ASSUME_NONNULL_END
