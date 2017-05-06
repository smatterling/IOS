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
    __weak IBOutlet UITextField *firstNameTextField;
    __weak IBOutlet UITextField *lastNameTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *passwordTextField;
    __weak IBOutlet UITextField *yearTextField;
    __weak IBOutlet UITextField *monthTextField;
    __weak IBOutlet UITextField *dayTextField;
    
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
    __weak IBOutlet UIView *imageViewContainer;
    __weak IBOutlet UILabel *titleLabel2;
    __weak IBOutlet UILabel *titleLabel1;
    __weak IBOutlet UIButton *maleButton;
    __weak IBOutlet UIButton *femaleButton;
    
    BOOL isMaleSelected;
}
@end

@implementation SignupViewController
@synthesize isFromProfile;


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.3f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [maleButton setSelected:YES];
    isMaleSelected = YES;
    [maleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [imageViewContainer setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(imageViewContainer.frame) / 2 andBorderWidth:1.0];
    
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
        
        titleLabel1.hidden = YES;
        titleLabel2.hidden = YES;
        imageViewContainer.hidden = NO;
        
    }
    else
    {
        logoutView.hidden = YES;
        deleteView.hidden = YES;
        [signUpButton setTitle:@"JOIN" forState:UIControlStateNormal];
        titleLabelTopbar.text = @"SIGN UP";
        
        titleLabel1.hidden = NO;
        titleLabel2.hidden = NO;
        imageViewContainer.hidden = YES;
    }
    
    
    firstNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:firstNameTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    lastNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:lastNameTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passwordTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:emailTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    dayTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:dayTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    monthTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:monthTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    yearTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:yearTextField.placeholder attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
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
- (IBAction)MaleBtnTpd:(id)sender {
    if (isMaleSelected == NO) {
        [maleButton setSelected:YES];
        [femaleButton setSelected:NO];
        isMaleSelected = YES;
        
        UIColor *selectedColor = [UIColor colorWithRed:155.0/255.0 green:207.0/255.0 blue:229.0/255.0 alpha:1.0];
        
        [maleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [maleButton setBackgroundColor:selectedColor];
        [femaleButton setBackgroundColor:[UIColor clearColor]];
    }
}
- (IBAction)FemaleBtnTpd:(id)sender {

    UIColor *selectedColor = [UIColor colorWithRed:155.0/255.0 green:207.0/255.0 blue:229.0/255.0 alpha:1.0];
    
    if (isMaleSelected == YES) {
        [maleButton setSelected:NO];
        [femaleButton setSelected:YES];
        isMaleSelected = NO;
        [femaleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [femaleButton setBackgroundColor:selectedColor];
        [maleButton setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)BackBtnTpd:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
