//
//  OnboardingViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 05/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "OnboardingViewController.h"
#import "MMPulseView.h"
#import "UIView+RoundedCorners.h"

@interface OnboardingViewController () 
{
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *titleLabel1;
    __weak IBOutlet UILabel *titleLabel2;
    __weak IBOutlet UILabel *titleLabel3;
    __weak IBOutlet UIView *innerView;
    __weak IBOutlet UIImageView *pulseImageView;
    __weak IBOutlet UIView *bottomView;
    
    CGRect initialFrame;
    CGRect finalFrame;
    
    MMPulseView *pulseView;
}
@property (nonatomic, strong) NSArray *pulseArray;
@end

@implementation OnboardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    finalFrame = bottomView.frame;
    
    initialFrame = CGRectMake(self.view.frame.origin.x - bottomView.frame.size.width, bottomView.frame.origin.y, bottomView.frame.size.width, bottomView.frame.size.height);
    bottomView.frame = initialFrame;
    
    [self createCloseButton];
    [self MakePulseView];
    
}

- (void)MakePulseView
{
    [pulseImageView setRoundedCorners:UIRectCornerAllCorners radius:pulseImageView.frame.size.width/2 andBorderWidth:1.0];
    pulseView = [[MMPulseView alloc] init];
    pulseView.frame = innerView.frame;
    [self.view addSubview:pulseView];
    pulseView.center = innerView.center;
    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pulseView.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    
    pulseView.minRadius = 30;
    pulseView.maxRadius = 120;
    
    pulseView.duration = 4;
    pulseView.count = 4;
    pulseView.lineWidth = 1.0f;
    
    pulseImageView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView beginAnimations:@"fadeInNewView" context:NULL];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationRepeatCount:1];
    
    pulseImageView.transform = CGAffineTransformMakeScale(1,1);
    pulseImageView.alpha = 1.0f;
    [UIView commitAnimations];
    
}

- (void)createCloseButton {
    UIImageView *imageview= [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"Home"];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCloseButtonTouch)];
    [imageview setUserInteractionEnabled:true];
    [imageview addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"appeard");
    [self AnimateViews];
}

- (void)AnimateViews
{
    if (!pulseView)
    {
        [self MakePulseView];
    }
    
    [pulseView startAnimation];
    
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

- (void)didCloseButtonTouch {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)CloseBtnTpd:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
