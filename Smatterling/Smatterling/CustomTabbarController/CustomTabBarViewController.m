//
//  CustomTabBarViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 13/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "AppAnimationManager.h"
#import "Constants.h"
#import "UIView+RoundedCorners.h"

@interface CustomTabBarViewController ()
{
    UITapGestureRecognizer* tapGesture_item1;
    UITapGestureRecognizer* tapGesture_item2;
    UITapGestureRecognizer* tapGesture_item3;
}
@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initializing tapGestures
    [self InitializeTabItemGestures];
    [self ConfigureTabItems];
}


- (void)ConfigureTabItems
{
//    _tabItem3.layer.cornerRadius = _tabItem1.frame.size.width/2;
    //  [imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[imageView.layer setBorderWidth:1.0];
//    [_tabItem3.layer setMasksToBounds:YES];
    [_tabItem3 setRoundedCorners:UIRectCornerAllCorners radius:_tabItem1.frame.size.height/2 andBorderWidth:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)InitializeTabItemGestures
{
    tapGesture_item1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TabItem1Tapped:)];
    tapGesture_item2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TabItem2Tapped:)];
    tapGesture_item3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TabItem3Tapped:)];
    
    [self.tabItem1 addGestureRecognizer:tapGesture_item1];
    [self.tabItem2 addGestureRecognizer:tapGesture_item2];
    [self.tabItem3 addGestureRecognizer:tapGesture_item3];
}
- (void)TabItem1Tapped : (UITapGestureRecognizer*)gesture
{
    // Main Map
    
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:gesture.view forKey:@"view"];
    [[AppAnimationManager sharedInstance] PerformTabItemAnimationForTab:gesture.view ofType:TAB_FIRST_ANIMATION];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"firstTabSelected" object:self];
}

- (void)TabItem2Tapped : (UITapGestureRecognizer*)gesture
{
    // Host Location
    
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:gesture.view forKey:@"view"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTabSelected" object:self userInfo:userInfo];
}

- (void)TabItem3Tapped : (UITapGestureRecognizer*)gesture
{
    // Profile
    
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:gesture.view forKey:@"view"];
    
    [[AppAnimationManager sharedInstance] PerformTabItemAnimationForTab:gesture.view ofType:TAB_THIRD_ANIMATION];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"thirdTabSelected" object:self userInfo:userInfo];
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
