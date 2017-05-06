//
//  ViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 03/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "ViewController.h"
#import "OnboardingViewController.h"
#import "OnboardingPagerManager.h"
#import "SignupViewController.h"
#import "AppManager.h"

// Custom Login Button Classes
#import "HyTransitions.h"
#import "HyLoginButton.h"


@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    __weak IBOutlet UITextField *email_field;
    __weak IBOutlet UITextField *password_field;
    __weak IBOutlet UIButton *fb_button;
    __weak IBOutlet UIButton *tw_button;
    __weak IBOutlet UIButton *login_button;
    __weak IBOutlet UIButton *register_button;
    __weak IBOutlet UIView *loginButtonPanel;
    __weak IBOutlet UIImageView *fbIcon;
    __weak IBOutlet UILabel *cityLabel;
    
    BOOL isSelected;
    BOOL isSwitchOn;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // cityLabel.text = [AppManager sharedInstance].userCity;
    
    [self createPresentControllerButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FbBtnTpd:(id)sender
{
//    CABasicAnimation *rotate =
//    [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotate.byValue = @(M_PI*2); // Change to - angle for counter clockwise rotation
//    rotate.duration = 1.0;
//    
//    [fb_button.layer addAnimation:rotate
//                            forKey:@"myRotationAnimation"];
    
    UIButton* button = (UIButton*)sender;
//    button.transform = CGAffineTransformMakeScale(0.1,0.1);
//    [UIView beginAnimations:@"fadeInNewView" context:NULL];
//    [UIView setAnimationDuration:1.0];
//    button.transform = CGAffineTransformMakeScale(1,1);
//    button.alpha = 1.0f;
//    [UIView commitAnimations];
    
    //////////////// IMAGE CHANGE ANIMATION
    
//    UIImage * toImage = [UIImage imageNamed:@"ic_twitter.png"];
//    CGAffineTransform rotate = CGAffineTransformMakeRotation(360);
//    
//    [UIView transitionWithView:self.view
//                      duration:1.0f
//                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent
//                    animations:^{
//                        [fbIcon setImage:toImage];
//                        fbIcon.layer.affineTransform = rotate;
//                        //fbIcon.layer.affineTransform = scale;
//                    } completion:NULL];

    
    
    //////////////// SPRING BUTTON ANIMATION
    fbIcon.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        fbIcon.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}



//{
//    [UIView animateWithDuration:1
//                          delay:0
//                        options:(UIViewAnimationOptionTransitionCrossDissolve)
//                     animations:^ {
////                         if (CGAffineTransformEqualToTransform(fb_button.transform, CGAffineTransformIdentity)) {
////                             [fb_button setTransform:CGAffineTransformMakeRotation((0.0174)*135)];
////                         } else {
////                             [fb_button setTransform:CGAffineTransformMakeRotation((0.0174)*360)];
////                         }
//                         if (isSelected) {
//                             //[fb_button setImage:[UIImage imageNamed:@"test-check-white.png"] forState:UIControlStateNormal];
////                             fb_button.selected = NO;
//                             isSelected = NO;
//                             [fb_button setTransform:CGAffineTransformMakeRotation((0.0174)*135)];
//                             
//                         }
//                         else
//                         {
//                            // [fb_button setImage:[UIImage imageNamed:@"test_close_white.png"] forState:UIControlStateNormal];
//                             //[fb_button setImage:[UIImage imageNamed:@"test_close_white.png"] forState:UIControlStateNormal];
////                             fb_button.selected = YES;
//                             isSelected = YES;
//                             [fb_button setTransform:CGAffineTransformMakeRotation((0.0174)*360)];
//                         }
////                        // fb_button.transform = CGAffineTransformRotate(CGAffineTransformIdentity,M_PI * 2);
////                         [fb_button setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
//                     }
//                     completion:^(BOOL finished) {
//                         
//                     }
//     ];
//}


- (IBAction)LoginBtnTpd:(id)sender {
    
    HyLoginButton *loginButton = (HyLoginButton*)sender;
    
    [self PresentViewController:loginButton];
    
}

- (IBAction)RegisterBtnTpd:(id)sender
{
    SignupViewController* signUpVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self.navigationController pushViewController:signUpVC animated:YES];
}

- (void)createPresentControllerButton{
    HyLoginButton *loginButton = [[HyLoginButton alloc] initWithFrame:login_button.frame];
    [loginButton setBackgroundColor:[UIColor colorWithRed:77.0/255.0 green:188.0/255.0 blue:233.0/255.0 alpha:0.82]];
    [loginButton setTitle:@"log in" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
    [loginButtonPanel addSubview:loginButton];
}

- (void)PresentViewController:(HyLoginButton *)button {
    typeof(self) __weak weak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
       // [weak didPresentControllerButtonTouch];
        
        isSwitchOn = !isSwitchOn;
        
        if (isSwitchOn) {
            //网络正常 或者是密码账号正确跳转动画
            [button succeedAnimationWithCompletion:^{
                if (isSwitchOn)
                {
                    //isSwitchOn = NO;
                    [weak didPresentControllerButtonTouch];
                    
                }
            }];
        } else {
            //网络错误 或者是密码不正确还原动画
            [button failedAnimationWithCompletion:^{
                if (isSwitchOn == NO) {
                    //isSwitchOn = YES;
                    [weak didPresentControllerButtonTouch];
                }
            }];
        }
        
        
        
    });
}

- (void)didPresentControllerButtonTouch
{
//    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingPageController"];
//    controller.transitioningDelegate = self;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    
//    navigationController.transitioningDelegate = self;
//    [navigationController.navigationBar setHidden:YES];
//    [self presentViewController:navigationController animated:YES completion:nil];
//    
//    
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingPagerManager"];
    controller.transitioningDelegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.transitioningDelegate = self;
    [navigationController.navigationBar setHidden:YES];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isPush:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isPush:false];
}

@end
