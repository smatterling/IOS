//
//  RateUserCollectionViewCell.m
//  Smatterling
//
//  Created by Muhammad Usama on 18/04/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "RateUserCollectionViewCell.h"

@implementation RateUserCollectionViewCell
@synthesize isShowingOverlay;

- (void)ConfigureCell
{
    
    
    self.overlayView.frame = CGRectMake(0, 0, 1, 1);
    self.overlayView.center = self.photoImageView.center;
    
    
}

- (void)PopulateCell
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.photoImageView.layer setCornerRadius:self.photoImageView.frame.size.height/2];
    [self.photoImageView.layer setMasksToBounds:YES];
    
    [self.overlayView.layer setCornerRadius:self.overlayView.frame.size.height/2];
    [self.overlayView.layer setMasksToBounds:YES];

}


- (void)ShowOverlayView
{
    self.pointsLabel.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        self.overlayView.frame = CGRectMake(self.photoImageView.frame.origin.x, self.photoImageView.frame.origin.y, self.photoImageView.frame.size.width, self.photoImageView.frame.size.height);
        [self.overlayView.layer setCornerRadius:self.overlayView.frame.size.height/2];
        [self.overlayView.layer setMasksToBounds:YES];
        self.overlayView.center = self.photoImageView.center;
        
    } completion:^(BOOL finished) {
        isShowingOverlay = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.pointsLabel.alpha = 1.0;
        }];
    }];
    
}

- (void)HideOverlayView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.pointsLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.overlayView.layer setCornerRadius:self.overlayView.frame.size.height/2];
            [self.overlayView.layer setMasksToBounds:YES];
            
            self.overlayView.frame = CGRectMake(0, 0, 1, 1);
            self.overlayView.center = self.photoImageView.center;
            isShowingOverlay = NO;
            
        }];

        
    }];
    
    
}
@end
