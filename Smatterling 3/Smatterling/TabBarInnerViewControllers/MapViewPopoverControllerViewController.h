//
//  MapViewPopoverControllerViewController.h
//  Smatterling
//
//  Created by Muhammad Usama on 23/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol mapPopoverDelegate <NSObject>

- (void)GetDirectionCalled;

@end


@interface MapViewPopoverControllerViewController : UIViewController
@property (nonatomic, retain) id <mapPopoverDelegate>delegate;
@end
