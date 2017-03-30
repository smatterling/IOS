//
//  ProfileMeetingTableViewCell.m
//  Smatterling
//
//  Created by Muhammad Usama on 17/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "ProfileMeetingTableViewCell.h"
#import "UIView+RoundedCorners.h"

@implementation ProfileMeetingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)ConfigureCell
{
    [self.photoImageView setRoundedCorners:UIRectCornerAllCorners radius:self.photoImageView.frame.size.width/2 andBorderWidth:1.0];
    
    //[self.photoView setmask:YES];
}
@end
