//
//  ProfileMeetingTableViewCell.h
//  Smatterling
//
//  Created by Muhammad Usama on 17/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileMeetingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
- (void)ConfigureCell;
@end
