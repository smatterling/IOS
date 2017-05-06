//
//  AvatarCollectionViewCell.h
//  Smatterling
//
//  Created by Muhammad Usama on 07/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

- (void)ConfigureCell;
- (void)PopulateCell;
@end
