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
    [self.layer setCornerRadius:self.frame.size.height/2];
    [self.layer setMasksToBounds:YES];
}

- (void)PopulateCell
{
    
}
@end
