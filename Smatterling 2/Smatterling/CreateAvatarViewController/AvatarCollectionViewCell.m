//
//  AvatarCollectionViewCell.m
//  Smatterling
//
//  Created by Muhammad Usama on 07/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "AvatarCollectionViewCell.h"

@implementation AvatarCollectionViewCell

- (void)ConfigureCell
{
    [self.avatarImageView.layer setCornerRadius:self.avatarImageView.frame.size.height/2];
    [self.avatarImageView.layer setMasksToBounds:YES];
}

- (void)PopulateCell
{
    
}
@end
