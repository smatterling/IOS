//
//  RateUserCollectionViewCell.h
//  Smatterling
//
//  Created by Muhammad Usama on 18/04/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateUserCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (nonatomic) BOOL isShowingOverlay;

- (void)ConfigureCell;
- (void)PopulateCell;
- (void)ShowOverlayView;
- (void)HideOverlayView;
@end
