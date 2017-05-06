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
#import "CustomTabBarViewController.h"
#import "AppManager.h"
#import "HostLocationCompletionViewController.h"
#import "CustomTopBarViewController.h"
#import "RateUserViewController.h"

@interface TabBarManagerViewController ()
{
    
    NotificationsViewController* notificationVC;
    CustomTabBarViewController* customTabbarVC;
    CustomTopBarViewController* customTopbarVC;
    HostLocationCompletionViewController* hostLocationNotifVC;
    
    __weak IBOutlet UIView *topbar;
    __weak IBOutlet UIView *bottomBar;
    
    
    BOOL isFirstItemEnabled;
    BOOL isSecondItemEnabled;
    BOOL isThirdItemEnabled;
    
    BOOL isHosting;
    BOOL isProfiling;
    BOOL isViewingMainMap;
    BOOL isRouteShowing;
    
    
    BOOL isNotificationShowing;
    
    float start;
    BOOL directionUp;
    BOOL isTapped;
}
@end

@implementation TabBarManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initializing and holding all the viewcontrollers once.
    
    
    // Notification handlers for tab bar items
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FirstTabSelected:) name:@"firstTabSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SecondTabSelected:) name:@"secondTabSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ThirdTabSelected:) name:@"thirdTabSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationSelected:) name:@"notification_topbar" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetDirectionSelected:) name:@"get_directions" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideLocation:) name:@"hide_location" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitLocation:) name:@"quit_location" object:nil];
    
    isFirstItemEnabled = YES;
    isSecondItemEnabled = YES;
    isThirdItemEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SettingsTapped:) name:@"Settings" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HostingProcessComplete:) name:@"hosting_location_complete" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CloseNotificationBtnTapped) name:@"close_notification_view" object:nil];
    
    for (UIViewController* vc in self.childViewControllers) {
        if ([vc isKindOfClass:[CustomTabBarViewController class]]) {
            customTabbarVC = (CustomTabBarViewController*)vc;
        }
    }
    
    for (UIViewController* vc in self.childViewControllers) {
        if ([vc isKindOfClass:[CustomTopBarViewController class]]) {
            customTopbarVC = (CustomTopBarViewController*)vc;
        }
    }
}

- (void)CloseNotificationBtnTapped
{
    [self CloseNotificationView:customTopbarVC.notificationButton];
}


- (void)viewDidAppear:(BOOL)animated
{
    // Add main map in main content view so that it can stay on back always
    [self InitializeTabItems];
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
        _mainMapVC.view.frame = _mainContentView.frame;
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
        else if (isRouteShowing)
        {
            NSLog(@"Already Route showing");
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
    
    if (isRouteShowing) {
        isSecondItemEnabled = YES;
        isThirdItemEnabled = YES;
        
        isRouteShowing = NO;
        [_routeVC.view removeFromSuperview];
        
        [[AppAnimationManager sharedInstance] ChangeImageOfImageView:customTabbarVC.tabItem2 WithImage:[UIImage imageNamed:@"ic_bottombar_plus"] andParentView:self.view];
        [self.innerContentView setUserInteractionEnabled:NO];
    }
    else
    {
        if (isSecondItemEnabled)
        {
            if (isHosting && ![AppManager sharedInstance].isHostingProcessComplete)
            {
                // User tapped on x button to close hosting location view
                [_hostVC.view removeFromSuperview];
                isHosting = NO;
                [[AppAnimationManager sharedInstance] ChangeImageOfImageView:[userInfo objectForKey:@"view"] WithImage:[UIImage imageNamed:@"ic_bottombar_plus"] andParentView:self.view];
                [self.innerContentView setUserInteractionEnabled:NO];
                
            }
            else if (isHosting && [AppManager sharedInstance].isHostingProcessComplete)
            {
                // User tapped on tick after completing the process of hosting location. show hosting notificaiton vc
                
                
                [_hostVC.view removeFromSuperview];
                isHosting = NO;
                [self.innerContentView setUserInteractionEnabled:NO];
                
                if (hostLocationNotifVC == nil)
                {
                    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
                    hostLocationNotifVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HostLocationCompletionViewController"];
                    hostLocationNotifVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                    hostLocationNotifVC.view.alpha = 1.0;
                    [self.view bringSubviewToFront:hostLocationNotifVC.view];
                    [self.view addSubview:hostLocationNotifVC.view];
                }
                else
                {
                    [self.view addSubview:hostLocationNotifVC.view];
                }
            }
            else if (!isHosting && [AppManager sharedInstance].isLocationHidden)
            {
                // user completed creation of location and it is hidden now. show hosting notificaiton vc
                
                if (hostLocationNotifVC == nil)
                {
                    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
                    hostLocationNotifVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HostLocationCompletionViewController"];
                    hostLocationNotifVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                    hostLocationNotifVC.view.alpha = 1.0;
                    [self.view bringSubviewToFront:hostLocationNotifVC.view];
                    [self.view addSubview:hostLocationNotifVC.view];
                }
                else
                {
                    [self.view addSubview:hostLocationNotifVC.view];
                }

            }
            else
            {
                // User tapped on + button to open the host location view
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
    
    if (notificationVC != nil)
    {
        [notificationVC.view removeFromSuperview];
        notificationVC = nil;
    }
    
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
        notificationVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
        notificationVC.view.frame = CGRectMake(button.frame.origin.x + (button.frame.size.width/2), button.frame.origin.y + button.frame.size.height, button.frame.size.width, button.frame.size.height);
        
        notificationVC.view.alpha = 0.0;
        [self.view bringSubviewToFront:notificationVC.view];
        [self.view addSubview:notificationVC.view];
        
    
    
//    for (UIView* view  in  [self.view subviews]) {
//        if ([view isKindOfClass:[notificationVC.view]) {
//            
//        }
//    }
    
    if (isNotificationShowing == NO)
    {
        [self OpenNotificationView:button];
    }
    else
    {
        [self CloseNotificationView:button];
    }
    isNotificationShowing = !isNotificationShowing;
}


- (void)OpenNotificationView : (UIButton*)button
{
    isFirstItemEnabled = NO;
    isSecondItemEnabled = NO;
    isThirdItemEnabled = NO;
    [[AppAnimationManager sharedInstance] ShowView:notificationVC.view FromButton:button toFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + topbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - topbar.frame.size.height)];
   // [self.view bringSubviewToFront:customTabbarVC.view];
    
}
- (void)CloseNotificationView : (UIButton*)button
{
    isFirstItemEnabled = YES;
    isSecondItemEnabled = YES;
    isThirdItemEnabled = YES;
    [[AppAnimationManager sharedInstance] HideView:notificationVC.view FromButton:button toFrame:CGRectMake(button.frame.origin.x + (button.frame.size.width/2), button.frame.origin.y + button.frame.size.height, button.frame.size.width, button.frame.size.height)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_topbar_closed" object:self];
    
}



- (void)GetDirectionSelected:(NSNotification*)notification
{
    isSecondItemEnabled = YES;
    isThirdItemEnabled = NO;
    [self.innerContentView setUserInteractionEnabled:YES];
    NSMutableDictionary* userInfo = [notification.userInfo mutableCopy];
        if (isRouteShowing == NO)
        {
            [[AppAnimationManager sharedInstance] ChangeImageOfImageView:customTabbarVC.tabItem2 WithImage:[UIImage imageNamed:@"ic_bottombar_cancel"] andParentView:self.view];
            
            [self.innerContentView setUserInteractionEnabled:YES];
            [self.innerContentView addSubview:_routeVC.view];
            [self.innerContentView bringSubviewToFront:_hostVC.view];
            isRouteShowing = YES;
            
        }
}

- (void)HostingProcessComplete:(NSNotification*)notification
{
    [[AppAnimationManager sharedInstance] ChangeImageOfImageView:customTabbarVC.tabItem2 WithImage:[UIImage imageNamed:@"ic_bottombar_finish"] andParentView:self.view];
    [AppManager sharedInstance].isHostingProcessComplete = YES;
}

- (void)HideLocation:(NSNotification*)notification
{
    [AppManager sharedInstance].isLocationHidden = YES;
    [[AppAnimationManager sharedInstance] ChangeImageOfImageView:customTabbarVC.tabItem2 WithImage:[UIImage imageNamed:@"ic_bottombar_continue"] andParentView:self.view];
    [hostLocationNotifVC.view removeFromSuperview];
    NSLog(@"Location hide");
}

- (void)QuitLocation:(NSNotification*)notification
{
    
    [[AppAnimationManager sharedInstance] ChangeImageOfImageView:customTabbarVC.tabItem2 WithImage:[UIImage imageNamed:@"ic_bottombar_plus"] andParentView:self.view];
    [hostLocationNotifVC.view removeFromSuperview];
    [self ShowRateView];
    NSLog(@"Location quit");
    
}

//... inside mainView impl:
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isNotificationShowing)
    {
        UITouch *touch = (UITouch *)[touches anyObject];
        start = [touch locationInView:self.view].y;
    //    if(start > 30 && notificationVC.view.center.y < 0)//touch was not in upper area of view AND pulldownView not visible
    //    {
    //        start = -1; //start is a CGFloat member of this view
    //    }
        
        
        if(start > notificationVC.closeButton.frame.origin.y && start-customTopbarVC.view.frame.size.height < notificationVC.closeButton.frame.size.height + notificationVC.closeButton.frame.origin.y )
        {
            NSLog(@"button area");
            
            isTapped = YES;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isNotificationShowing) {
    isTapped = NO;
    
    UITouch *touch = (UITouch *)[touches anyObject];
    CGFloat now = [touch locationInView:self.view].y;
    CGFloat diff = now - start;
    directionUp = diff < 0;//directionUp is a BOOL member of this view
    float nuCenterY = notificationVC.view.center.y + diff;
//    notificationVC.view.center = CGPointMake(notificationVC.view.center.x, nuCenterY);
    
    [notificationVC.view setFrame:CGRectMake(notificationVC.view.frame.origin.x, notificationVC.view.frame.origin.y, notificationVC.view.frame.size.width, notificationVC.view.frame.size.height + diff)];
    
    
    start = now;
    }
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isNotificationShowing) {
        if (!isTapped) {
            if (directionUp)
            {
                if (notificationVC.view.frame.origin.y + notificationVC.view.frame.size.height < self.view.frame.size.height/2) {
                    // initial frame
                    
                    [[AppAnimationManager sharedInstance] HideView:notificationVC.view FromButton:customTopbarVC.notificationButton toFrame:CGRectMake(customTopbarVC.notificationButton.frame.origin.x + (customTopbarVC.notificationButton.frame.size.width/2), customTopbarVC.notificationButton.frame.origin.y + customTopbarVC.notificationButton.frame.size.height, customTopbarVC.notificationButton.frame.size.width, customTopbarVC.notificationButton.frame.size.height)];
                    customTopbarVC.lineView.hidden = NO;
                    isNotificationShowing = NO;
                    isFirstItemEnabled = YES;
                    isSecondItemEnabled = YES;
                    isThirdItemEnabled = YES;
                }
                else
                {
                    // final frame
                    
                    [[AppAnimationManager sharedInstance] ShowView:notificationVC.view FromButton:customTopbarVC.notificationButton toFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + topbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - topbar.frame.size.height)];
                    customTopbarVC.lineView.hidden = YES;
                    isNotificationShowing = YES;
                    isFirstItemEnabled = NO;
                    isSecondItemEnabled = NO;
                    isThirdItemEnabled = NO;
                    
                }
            }
            else if(start>=0)
            {
                // final frame
                [[AppAnimationManager sharedInstance] ShowView:notificationVC.view FromButton:customTopbarVC.notificationButton toFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + topbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - topbar.frame.size.height)];
                customTopbarVC.lineView.hidden = YES;
                isNotificationShowing = YES;
                isFirstItemEnabled = NO;
                isSecondItemEnabled = NO;
                isThirdItemEnabled = NO;
            }
        }
        else
        {
            isTapped = NO;
            [[AppAnimationManager sharedInstance] HideView:notificationVC.view FromButton:customTopbarVC.notificationButton toFrame:CGRectMake(customTopbarVC.notificationButton.frame.origin.x + (customTopbarVC.notificationButton.frame.size.width/2), customTopbarVC.notificationButton.frame.origin.y + customTopbarVC.notificationButton.frame.size.height, customTopbarVC.notificationButton.frame.size.width, customTopbarVC.notificationButton.frame.size.height)];
            customTopbarVC.lineView.hidden = NO;
            isNotificationShowing = NO;
            isFirstItemEnabled = YES;
            isSecondItemEnabled = YES;
            isThirdItemEnabled = YES;
        }
    }
    
}

- (void)ShowRateView
{
   // [self HideLocation:nil];
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    RateUserViewController* rateUserVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RateUserViewController"];
    //signupVC.isFromProfile = YES;
    [self.navigationController pushViewController:rateUserVC animated:YES];
}


@end
