//
//  MainMapViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "MainMapViewController.h"
#import "CustomAnnotation.h"
#import "MKAnnotationView+WebCache.h"
#import "CustomMarkerView.h"

#import <MapKit/MapKit.h>
#import "UIImageView+WebCache.h"

@interface MainMapViewController () <MKMapViewDelegate>
{
    
    __weak IBOutlet MKMapView *mainMapView;
    NSMutableArray* mapAnnotations;
    NSMutableArray* infoArray;
    
    BOOL annotationAnimationCompleted;
}
@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LoadTestData];
    //[self.mapview addAnnotations:self.mapAnnotations];
    dispatch_async(dispatch_get_main_queue(), ^{
        [mainMapView addAnnotations:mapAnnotations];
    });
    
    [mainMapView setDelegate:self];
    
    annotationAnimationCompleted = YES;
}



- (void)LoadTestData
{
    double lat = 40.33168900;
    double lng = -110.03073100;
    mapAnnotations = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 20; i++)
    {
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        myAnnotation.title = @"Matthews Pizza";
        myAnnotation.subtitle = [NSString stringWithFormat:@"%d    ", i];
        [mapAnnotations addObject:myAnnotation];
        lat += 1.05 * i;
        lng += 0.55 * i+i;
    }
    [mainMapView addAnnotations:mapAnnotations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [mainMapView setRegion:[mainMapView regionThatFits:region] animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        CustomMarkerView *pinView = (CustomMarkerView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[CustomMarkerView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.tintColor = [UIColor redColor];
            
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setUserInteractionEnabled:YES];
            imageView.layer.cornerRadius = imageView.frame.size.width/2;
            [imageView.layer setMasksToBounds:YES];
            [imageView setImageWithURL:[NSURL URLWithString:@"https://pbs.twimg.com/profile_images/656849296629874688/U9YyrNfm.jpg"] placeholderImage:[UIImage imageNamed:@"loading.png"]];
            imageView.transform = CGAffineTransformMakeScale(0.1,0.1);
            [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
            
            [pinView addSubview:imageView];
            pinView.centerOffset = CGPointMake(0, imageView.frame.size.height / 2);
            
            
            //
            //
            //            dispatch_queue_t concurrentQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //
            //            //this will start the image loading in bg
            //
            //            dispatch_async(concurrentQueue, ^{
            //                NSData *image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://findbetter.ru/public/uploads/1481662800/2043.png"]];
            //
            //                //this will set the image when loading is finished
            //
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //                    pinView.imageView1.image = [UIImage imageWithData:image];
            //                });
            //            });
            //
            
            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
    
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
