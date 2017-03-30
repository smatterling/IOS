//
//  UIView+RoundedCorners.m
//  UIViewRoundedCorners
//
//  Created by Vashishtha Jogi on 11/20/11.
//  Copyright (c) 2011 Vashishtha Jogi. All rights reserved.
//

#import "UIView+RoundedCorners.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@implementation UIView (RoundedCorners)

-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius andBorderWidth:(float)borderWidth{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = THEME_COLOR_BORDER;
    self.layer.borderWidth = borderWidth;
}

@end
