//
//  HostLocationCompletionViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 23/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "HostLocationCompletionViewController.h"
#import "AppManager.h"
#import "UIView+RoundedCorners.h"

@interface HostLocationCompletionViewController ()
{
    
    __weak IBOutlet UIView *quitView;
    __weak IBOutlet UIView *hideView;
}

@end

@implementation HostLocationCompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [quitView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(quitView.bounds) / 2 andBorderWidth:1.0];
    [hideView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(hideView.bounds) / 2 andBorderWidth:1.0];
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

- (IBAction)QuitLocationBtnTpd:(id)sender
{
    {
        
        [UIView respondsToSelector:@selector(setTintColor:)];
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Smatterling"
                                     message:@"Do you want to quit this location?"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction* noAction = [UIAlertAction
                                  actionWithTitle:@"No"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
      
        
        UIAlertAction* yesAction = [UIAlertAction
                                 actionWithTitle:@"Yes"
                                 style:UIAlertActionStyleDestructive
                                 handler:^(UIAlertAction * action)
                                 {
                                     [AppManager sharedInstance].isLocationHidden = NO;
                                     [AppManager sharedInstance].isHostingProcessComplete = NO;
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"quit_location" object:self];
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        
        [view addAction:noAction];
        [view addAction:yesAction];
        [self presentViewController:view animated:YES completion:nil];
        
       
    }
}

- (IBAction)HideBtnTpd:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hide_location" object:self];
}
@end
