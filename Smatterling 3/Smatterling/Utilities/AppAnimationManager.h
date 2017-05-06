//
//  AppAnimationManager.h
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AnimationDelegate <NSObject>

@optional
- (void)AnimationCompleteForItem:(int)item;
- (void)TabAnimationCompeted:(UIView*)item;
@end





@interface AppAnimationManager : NSObject

@property (nonatomic, retain) id <AnimationDelegate>delegate;

+ (AppAnimationManager *) sharedInstance;
- (void)PerformTabItemAnimationForTab:(UIView*)view ofType:(int)type;
- (void)PerformAnimationOfType:(int)type ForItem:(id)item andDuration:(float)duration;
- (void)ChangeImageOfImageView:(UIImageView*)imageView WithImage:(UIImage*)image andParentView:(UIView*)parentView;
- (void)ShowSubview:(UIView*)viewToReplace onMainView:(UIView*)mainView;
- (void)HideSubview:(UIView*)viewToReplace onMainView:(UIView*)mainView;
- (void)ShowView:(UIView*)view FromButton:(UIButton*)button toFrame:(CGRect)finalFrame;
- (void)HideView:(UIView*)view FromButton:(UIButton*)button toFrame:(CGRect)finalFrame;
- (void)SpringAnimationForView : (UIView*)view;
@end
