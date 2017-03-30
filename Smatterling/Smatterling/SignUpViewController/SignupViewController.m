//
//  SignupViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 05/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "SignupViewController.h"
#import "UIView+RoundedCorners.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SignupViewController ()
{
    __weak IBOutlet UIView *dayView;
    __weak IBOutlet UIView *monthView;
    __weak IBOutlet UIView *yearView;
    __weak IBOutlet UIView *maleView;
    __weak IBOutlet UIView *femaleView;
    
    __weak IBOutlet UIView *logoutView;
    __weak IBOutlet UIView *deleteView;
    __weak IBOutlet UIButton *signUpButton;
    
    __weak IBOutlet UILabel *titleLabelTopbar;
    __weak IBOutlet TPKeyboardAvoidingScrollView *topScrollView;
    __weak IBOutlet UIView *innerView;
}
@end

@implementation SignupViewController
@synthesize isFromProfile;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [dayView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(dayView.bounds) / 2 andBorderWidth:1.0];
    
    [monthView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(monthView.bounds) / 2 andBorderWidth:1.0];
    
    [yearView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(yearView.bounds) / 2 andBorderWidth:1.0];
    
    [maleView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(maleView.bounds) / 2 andBorderWidth:1.0];
    
    [femaleView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(femaleView.bounds) / 2 andBorderWidth:1.0];
    
    [logoutView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(logoutView.bounds) / 2 andBorderWidth:1.0];
    
    [deleteView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(deleteView.bounds) / 2 andBorderWidth:1.0];
    
    if (self.isFromProfile) {
        logoutView.hidden = NO;
        deleteView.hidden = NO;
        [signUpButton setTitle:@"SAVE" forState:UIControlStateNormal];
        titleLabelTopbar.text = @"SETTINGS";
        
    }
    else
    {
        logoutView.hidden = YES;
        deleteView.hidden = YES;
        [signUpButton setTitle:@"JOIN" forState:UIControlStateNormal];
        titleLabelTopbar.text = @"SIGN UP";
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [topScrollView setContentSize:CGSizeMake(self.view.frame.size.width, innerView.frame.size.height)];
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

- (IBAction)BackBtnTpd:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
