//
//  TabBarManagerViewController.h
//  Smatterling
//
//  Created by Muhammad Usama on 07/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainMapViewController;
@class RouteViewController;
@class HostLocationViewController;
@class ProfileViewController;

@interface TabBarManagerViewController : UIViewController
@property (nonatomic, retain) MainMapViewController* mainMapVC;
@property (nonatomic, retain) RouteViewController* routeVC;
@property (nonatomic, retain) HostLocationViewController* hostVC;
@property (nonatomic, retain) ProfileViewController* profileVC;

@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UIView *innerContentView;


@end
