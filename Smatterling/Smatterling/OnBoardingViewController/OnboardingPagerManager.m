//
//  OnboardingPagerManager.m
//  Smatterling
//
//  Created by Muhammad Usama on 05/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "OnboardingPagerManager.h"
#import "OnboardingViewController.h"
#import "OnboardingViewControllerSlide2.h"
#import "OnboardingViewControllerSlide3.h"
#import "OnboardingViewControllerSlideFinal.h"
#import "CreateAvatarViewController.h"

#import "Constants.h"
@interface OnboardingPagerManager ()
{
    UISwipeGestureRecognizer* swipeGesture;
    __weak IBOutlet UIPageControl *pageControl;
    int currentIndex;
}
@end

@implementation OnboardingPagerManager

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowCreateAvatarView) name:@"create_avatar_selected" object:nil];
    [self CreatePager];
}

- (void)ShowCreateAvatarView
{
    CreateAvatarViewController *createAvatarViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"CreateAvatarViewController"];
    [self.navigationController pushViewController:createAvatarViewController animated:YES];
}

- (void)CreatePager
{
    // Create page view controller
    self.pageViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingPageController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    OnboardingViewController *startingViewController = (OnboardingViewController*)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //[self.pageViewController.view setBackgroundColor:THEME_COLOR_BACKGROUND];
    //[self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
   // self.view.backgroundColor = [UIColor redColor];
//    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
//    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor whiteColor]];
//    [[UIPageControl appearance] setBackgroundColor:THEME_COLOR_BACKGROUND];
    
    pageControl.numberOfPages = NO_OF_PAGES - 1;
    [self.view bringSubviewToFront:pageControl];
    /////////////////// PAGER SETUP END  /////////////////
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Create a new view controller and pass suitable data.
    if (index == 0) {
        OnboardingViewController *pageContentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
    else if (index == 1) {
        OnboardingViewControllerSlide2 *pageContentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingViewControllerSlide2"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
    else if (index == 2) {
        OnboardingViewControllerSlide3 *pageContentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingViewControllerSlide3"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }

    else if (index == 3) {
        OnboardingViewControllerSlideFinal *pageContentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"OnboardingViewControllerSlideFinal"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
        //self.pageViewController..hidden = YES
    }
    else
    {
        return nil;
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((OnboardingViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index;
    
    if ([viewController isKindOfClass:[OnboardingViewController class]]) {
        index = ((OnboardingViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlide2 class]]) {
        index = ((OnboardingViewControllerSlide2*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlide3 class]]) {
        index = ((OnboardingViewControllerSlide3*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlideFinal class]]) {
        index = ((OnboardingViewControllerSlideFinal*) viewController).pageIndex;
    }
   
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == NO_OF_PAGES) {
        return nil;
    }
    
//    if ((int)index == 3) {
//        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ShowFinalSlide)];
//        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//        [pageViewController.view addGestureRecognizer:swipeGesture];
//    }
//    else
//    {
//        [self.view removeGestureRecognizer:swipeGesture];
//    }
    
    return [self viewControllerAtIndex:index];
}



//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return NO_OF_PAGES;
//}

//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    UIViewController* viewController = [pendingViewControllers firstObject];
    
    if ([viewController isKindOfClass:[OnboardingViewController class]]) {
        currentIndex = (int)((OnboardingViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlide2 class]]) {
        currentIndex = (int)((OnboardingViewControllerSlide2*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlide3 class]]) {
        currentIndex = (int)((OnboardingViewControllerSlide3*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[OnboardingViewControllerSlideFinal class]]) {
        currentIndex = (int)((OnboardingViewControllerSlideFinal*) viewController).pageIndex;
    }
    
    
//    if (index == NSNotFound) {
//        return nil;
//    }
//    
//    index++;
//    if (index == NO_OF_PAGES) {
//        return nil;
//    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
   // int currentIndex = NO_OF_PAGES - (int)[previousViewControllers count];
 //   pageControl.currentPage = (int)[previousViewControllers count];;
    
    if (completed)
    {
        pageControl.alpha = 1.0;
        
        if (currentIndex == NO_OF_PAGES - 1) {
            [UIView animateWithDuration:0.3 animations:^{
                pageControl.alpha = 0.0;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                pageControl.alpha = 1.0;
            }];
            pageControl.currentPage = currentIndex;
        }
        
        
    }
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

@end
