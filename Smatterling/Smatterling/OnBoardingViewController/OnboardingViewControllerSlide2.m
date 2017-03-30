//
//  OnboardingViewControllerSlide2.m
//  Smatterling
//
//  Created by Muhammad Usama on 06/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "OnboardingViewControllerSlide2.h"

@interface OnboardingViewControllerSlide2 ()
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

@implementation OnboardingViewControllerSlide2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    finalFrame = bottomView.frame;
    initialFrame = CGRectMake(self.view.frame.origin.x - bottomView.frame.size.width, bottomView.frame.origin.y, bottomView.frame.size.width, bottomView.frame.size.height);
    bottomView.frame = initialFrame;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self AnimateViews];
}

- (void)AnimateViews
{
    NSLog(@"appeard");
    bottomView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        bottomView.frame = finalFrame;
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    bottomView.frame = initialFrame;
    bottomView.hidden = YES;
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
