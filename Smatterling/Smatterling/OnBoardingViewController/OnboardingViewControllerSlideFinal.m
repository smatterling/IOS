//
//  OnboardingViewControllerSlideFinal.m
//  Smatterling
//
//  Created by Muhammad Usama on 06/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "OnboardingViewControllerSlideFinal.h"

@interface OnboardingViewControllerSlideFinal ()
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *titleLabel1;
    __weak IBOutlet UILabel *titleLabel2;
    __weak IBOutlet UIImageView *tickImageView;
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet UILabel *appTitleLabel;
    __weak IBOutlet UIButton *createAvatarButton;
    __weak IBOutlet UIView *createAvatarView;
    __weak IBOutlet UIView *bottomView;
    
    // used for animation of create avatar view
    CGRect initialFrame;
    CGRect finalFrame;
}
@end

@implementation OnboardingViewControllerSlideFinal

- (void)viewDidLoad {
    [super viewDidLoad];
    initialFrame = CGRectMake(createAvatarView.frame.origin.x, createAvatarView.frame.origin.y + createAvatarView.frame.size.height, createAvatarView.frame.size.width, createAvatarView.frame.size.height);
    finalFrame = createAvatarView.frame;
    //createAvatarView.frame = initialFrame;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self AnimateViews];
}
- (void)AnimateViews
{
    // animating create avatar view
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         createAvatarView.frame = finalFrame;
//                     }
//                     completion:^(BOOL finished){
//                     }];
    // animating labels view
    
    //bottomView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    createAvatarView.hidden = NO;
    [UIView animateWithDuration:0.6/1.5 animations:^{
        //bottomView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
      //      bottomView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
        //        bottomView.transform = CGAffineTransformIdentity;
                tickImageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    createAvatarView.frame = initialFrame;
    createAvatarView.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CreateAvatarBtnTpd:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"create_avatar_selected" object:self];
    
}
@end
