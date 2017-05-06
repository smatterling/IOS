//
//  TabBarManagerViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 07/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "TabBarManagerViewController.h"
#import "MainMapViewController.h"
#import "RouteViewController.h"
#import "HostLocationViewController.h"
#import "ProfileViewController.h"
#import "AppAnimationManager.h"
#import "SignupViewController.h"
#import "NotificationsViewController.h"
#import "Constants.h"

@interface TabBarManagerViewController ()
{
    
    NotificationsViewController* notificationVC;
    __weak IBOutlet UIView *topbar;
    __weak IBOutlet UIView *bottomBar;
    
    
    BOOL isFirstItemEnabled;
    BOOL isSecondItemEnabled;
    BOOL isThirdItemEnabled;
    
    BOOL isHosting;
    BOOL isProfiling;
    BOOL isViewingMainMap;
    
    BOOL isNotificationShowing;
}
@end

@implementation TabBarManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initializing and holding all the viewcontrollers once.
    [self InitializeTabItems];
    
    // Notification handlers for tab bar items
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FirstTabSelected:) name:@"firstTabSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SecondTabSelected:) name:@"secondTabSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ThirdTabSelected:) name:@"thirdTabSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationSelected:) name:@"notification_topbar" object:nil];
    
    
    isFirstItemEnabled = YES;
    isSecondItemEnabled = YES;
    isThirdItemEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SettingsTapped:) name:@"Settings" object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    // Add main map in main content view so that it can stay on back always
    [self AddMainMapView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)InitializeTabItems
{
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    
    if (_mainMapVC == nil) {
        _mainMapVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainMapViewController"];
        _mainMapVC.view.frame = _mainContentView.bounds;
    }
    
    if (_routeVC == nil) {
        _routeVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RouteViewController"];
        _routeVC.view.frame = _innerContentView.bounds;
    }
    
    if (_hostVC == nil) {
        _hostVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HostLocationViewController"];
        _hostVC.view.frame = _innerContentView.bounds;
    }
    
    if (_profileVC == nil) {
        _profileVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        _profileVC.view.frame = _innerContentView.bounds;
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.destinationViewController isKindOfClass:[SignupViewController class]]) {
//        SignupViewController* signupVC = (SignupViewController*)segue.destinationViewController;
//        signupVC.isFromProfile = YES;
//    }
}



- (void)AddMainMapView
{
    [self.mainContentView addSubview:_mainMapVC.view];
    [self.mainContentView sendSubviewToBack:_mainMapVC.view];
}

#pragma mark Tab Item Selectors



- (void)FirstTabSelected : (NSNotification*)notification
{
    NSMutableDictionary* userInfo = [notification.userInfo mutableCopy];
    if (isFirstItemEnabled) {
        if (isHosting)
        {
            NSLog(@"Already hosting");
        }
        else if (isProfiling)
        {
            [[AppAnimationManager sharedInstance] PerformTabItemAnimationForTab:[userInfo objectForKey:@"view"] ofType:TAB_FIRST_ANIMATION];
            
            
            [_profileVC.view removeFromSuperview];
            isThirdItemEnabled = YES;
            [self.innerContentView setUserInteractionEnabled:NO];
        }
    }
}

- (void)SecondTabSelected : (NSNotification*)notification
{
    NSMutableDictionary* userInfo = [notification.userInfo mutableCopy];
    
    if (isSecondItemEnabled)
    {
        if (isHosting)
        {
            [_hostVC.view removeFromSuperview];
            isHosting = NO;
            [[AppAnimationManager sharedInstance] ChangeImageOfImageView:[userInfo objectForKey:@"view"] WithImage:[UIImage imageNamed:@"ic_bottombar_plus"] andParentView:self.view];
            
        }
        else
        {
            [[AppAnimationManager sharedInstance] ChangeImageOfImageView:[userInfo objectForKey:@"view"] WithImage:[UIImage imageNamed:@"ic_bottombar_cancel"] andParentView:self.view];
            
            [self.innerContentView setUserInteractionEnabled:YES];
            [self.innerContentView addSubview:_hostVC.view];
            [self.innerContentView bringSubviewToFront:_hostVC.view];
            isHosting = YES;
            
            if (isProfiling)
            {
                [_profileVC.view removeFromSuperview];
                isThirdItemEnabled = YES;
            }
        }
        
    }
    
}

- (void)ThirdTabSelected : (NSNotification*)notification
{
    NSMutableDictionary* userInfo = [notification.userInfo mutableCopy];
    if (isHosting) {
        // Return msg to quit hosting
        NSLog(@"Already hosting");
    }
    else
    {
        if (isThirdItemEnabled && isHosting == NO)
        {
            // Showing profile view
            [[AppAnimationManager sharedInstance] PerformTabItemAnimationForTab:[userInfo objectForKey:@"view"] ofType:TAB_FIRST_ANIMATION];
            [self.innerContentView addSubview:_profileVC.view];
            [self.innerContentView setUserInteractionEnabled:YES];
            
            isProfiling = YES;
            isThirdItemEnabled = NO;
            isSecondItemEnabled = YES;
        }
    }
    
}


- (void)SettingsTapped:(NSNotification*)notification
{
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    SignupViewController* signupVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    signupVC.isFromProfile = YES;
    [self.navigationController pushViewController:signupVC animated:YES];
}

- (void)NotificationSelected:(NSNotification*)notification
{
    
    
    NSMutableDictionary* userInfo = [notification.userInfo mutableCopy];
    UIButton* button = [userInfo objectForKey:@"view"];
    
    if (notificationVC == nil)
    {
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
        notificationVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
        notificationVC.view.frame = CGRectMake(button.frame.origin.x + (button.frame.size.width/2), button.frame.origin.y + button.frame.size.height, button.frame.size.width, button.frame.size.height);
        
        notificationVC.view.alpha = 0.0;
        [self.view bringSubviewToFront:notificationVC.view];
        [self.view addSubview:notificationVC.view];
    }
    else
    {
        [self.view addSubview:notificationVC.view];
    }
    
    if (isNotificationShowing == NO)
    {
        isFirstItemEnabled = NO;
        isSecondItemEnabled = NO;
        isThirdItemEnabled = NO;
        [[AppAnimationManager sharedInstance] ShowView:notificationVC.view FromButton:button toFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + topbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - topbar.frame.size.height)];
    }
    else
    {
        isFirstItemEnabled = YES;
        isSecondItemEnabled = YES;
        isThirdItemEnabled = YES;
        [[AppAnimationManager sharedInstance] HideView:notificationVC.view FromButton:button toFrame:CGRectMake(button.frame.origin.x + (button.frame.size.width/2), button.frame.origin.y + button.frame.size.height, button.frame.size.width, button.frame.size.height)];
    }
    isNotificationShowing = !isNotificationShowing;
}



@end
