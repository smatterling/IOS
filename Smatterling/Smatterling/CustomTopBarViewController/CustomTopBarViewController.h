//
//  CustomTopBarViewController.h
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTopBarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIImageView *notificationIcon;
@property (weak, nonatomic) IBOutlet UIImageView *nectarIcon;
@property (weak, nonatomic) IBOutlet UILabel *nectarLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoicon;

@end
