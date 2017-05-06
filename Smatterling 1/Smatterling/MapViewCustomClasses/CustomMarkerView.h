//
//  CustomMarkerView.h
//  CustomMarkerViews
//
//  Created by Muhammad Usama on 10/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CustomMarkerView : MKAnnotationView 
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (nonatomic,retain)UIView *contentView;

@end
