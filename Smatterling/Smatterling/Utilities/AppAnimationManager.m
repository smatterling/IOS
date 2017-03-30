//
//  AppAnimationManager.m
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "AppAnimationManager.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppAnimationManager
@synthesize delegate;

static AppAnimationManager* sharedInstance;

+ (AppAnimationManager *) sharedInstance
{
    if (!sharedInstance){
        @synchronized(self)
        {
            if (!sharedInstance)
            {
                sharedInstance = [[AppAnimationManager alloc] init];
                
            }
        }
    }
    return sharedInstance;
}


+(id) alloc
{
    @synchronized(self)
    {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton WebservicesManager.");
        sharedInstance = [super alloc];
    }
    
    return sharedInstance;
}


- (void)ChangeImageOfImageView:(UIImageView*)imageView WithImage:(UIImage*)image andParentView:(UIView*)parentView
{
    UIImage * toImage = image;//[UIImage imageNamed:@"ic_twitter.png"];
    //imageView.transform = CGAffineTransformIdentity;
    /*
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI);
    [UIView transitionWithView:parentView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent
                    animations:^{
                        [imageView setImage:toImage];
                        imageView.transform = rotate;
                    } completion:^(BOOL finished) {
                        imageView.transform = CGAffineTransformIdentity;
                    }];*/
    
    CABasicAnimation *rotate =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.byValue = @(M_PI*2); // Change to - angle for counter clockwise rotation
    rotate.duration = 1.0;
    rotate.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [imageView.layer addAnimation:rotate
                            forKey:@"myRotationAnimation"];
    
    [UIView transitionWithView:parentView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent
                    animations:^{
                        [imageView setImage:toImage];
                        //imageView.transform = rotate;
                    } completion:^(BOOL finished) {
                        //imageView.transform = CGAffineTransformIdentity;
                    }];
    
}

- (void)PerformTabItemAnimationForTab:(UIView*)view ofType:(int)type
{
    // USE TAB_ITEM_ANIMATION_DURATION for duration of tab item animation
    
    
    switch (type) {
        case TAB_FIRST_ANIMATION:
        {
            view.transform = CGAffineTransformMakeScale(0.8,0.8);
            [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:3.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                //  [self.delegate TabAnimationCompeted:view];
            }];
            
        }
        break;
            
        default:
            break;
    }
}

- (void)PerformAnimationOfType:(int)type ForItem:(id)item andDuration:(float)duration
{
    switch (type) {
        case RIGHT_TO_LEFT_TRANSITION:
            
            break;
            
        default:
            break;
    }
    [self.delegate AnimationCompleteForItem:type];
}

- (void)ShowSubview:(UIView*)viewToReplace onMainView:(UIView*)mainView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        viewToReplace.frame = mainView.bounds;
        viewToReplace.alpha = 1.0;
       // mainView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)HideSubview:(UIView*)viewToReplace onMainView:(UIView*)mainView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        viewToReplace.frame = CGRectMake(mainView.frame.size.width, viewToReplace.frame.origin.y, viewToReplace.frame.size.width, viewToReplace.frame.size.height);
        viewToReplace.alpha = 0.0;
      //  mainView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)ShowView:(UIView*)view FromButton:(UIButton*)button toFrame:(CGRect)finalFrame
{
    [UIView animateWithDuration:0.2 animations:^{
        [view setFrame:finalFrame];
        [view setAlpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)HideView:(UIView*)view FromButton:(UIButton*)button toFrame:(CGRect)finalFrame
{
    [UIView animateWithDuration:0.2 animations:^{
        [view setFrame:finalFrame];
        [view setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        //[view ]
    }];
}

- (void)SpringAnimationForView : (UIView*)view 
{
    view.transform = CGAffineTransformMakeScale(0.5,0.5);
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:3.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //  [self.delegate TabAnimationCompeted:view];
    }];
}

@end
