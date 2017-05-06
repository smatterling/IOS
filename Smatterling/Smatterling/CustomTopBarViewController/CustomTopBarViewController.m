//
//  CustomTopBarViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "CustomTopBarViewController.h"

@interface CustomTopBarViewController ()

@end

@implementation CustomTopBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationClosed:) name:@"notification_topbar_closed" object:nil];
    
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
- (IBAction)NotificationBtnTpd:(id)sender {
    
    UIButton* button = (UIButton*)sender;
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:button forKey:@"view"];
    self.lineView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_topbar" object:self userInfo:userInfo];
}

- (void)NotificationClosed:(NSNotification*)notification
{
    self.lineView.hidden = NO;
}

@end
