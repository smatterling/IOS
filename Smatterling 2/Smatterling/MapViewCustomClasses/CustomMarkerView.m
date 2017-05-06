//
//  CustomMarkerView.m
//  CustomMarkerViews
//
//  Created by Muhammad Usama on 10/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "CustomMarkerView.h"

#import <QuartzCore/QuartzCore.h>
#define  Arror_height 15

@interface CustomMarkerView ()

-(void)drawInContext:(CGContextRef)context;
- (void)getDrawPath:(CGContextRef)context;
@end

@implementation CustomMarkerView
@synthesize contentView;

- (void)dealloc
{
    self.contentView = nil;
    //[super dealloc];
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        self.canShowCallout = NO;
        //self.centerOffset = CGPointMake(0, -120);
        self.frame = CGRectMake(0, 0, 40, 40);
        self.backgroundColor = [UIColor clearColor];
        
        //[self.layer setMasksToBounds:YES];
        self.layer.cornerRadius = self.frame.size.width/2;
//        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        [self.layer setBorderWidth:1.0];
    }
    return self;
}
@end
