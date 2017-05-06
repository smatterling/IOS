//
//  OnboardingPagerManager.h
//  Smatterling
//
//  Created by Muhammad Usama on 05/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardingPagerManager : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
