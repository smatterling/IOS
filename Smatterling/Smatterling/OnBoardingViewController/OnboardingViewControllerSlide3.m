//
//  OnboardingViewControllerSlide3.m
//  Smatterling
//
//  Created by Muhammad Usama on 06/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "OnboardingViewControllerSlide3.h"

@interface OnboardingViewControllerSlide3 ()
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *titleLabel1;
    __weak IBOutlet UILabel *titleLabel2;
    __weak IBOutlet UILabel *titleLabel3;
    __weak IBOutlet UIView *innerView;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIView *bottomView;

    CGRect finalFrame;
    CGRect initialFrame;
}
@end

@implementation OnboardingViewControllerSlide3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    finalFrame = bottomView.frame;
    initialFrame = CGRectMake(self.view.frame.origin.x - bottomView.frame.size.width, bottomView.frame.origin.y, bottomView.frame.size.width, bottomView.frame.size.height);
    bottomView.frame = initialFrame;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)AnimateViews
{
    // Animation of top image view
    
    imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    imageView.hidden = NO;
    [UIView animateWithDuration:0.6/1.5 animations:^{
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    // bottom view animation ended
    NSLog(@"appeard");
    bottomView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        bottomView.frame = finalFrame;
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [self AnimateViews];
}

- (void)viewDidDisappear:(BOOL)animated
{
    bottomView.frame = initialFrame;
    bottomView.hidden = YES;
    imageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
