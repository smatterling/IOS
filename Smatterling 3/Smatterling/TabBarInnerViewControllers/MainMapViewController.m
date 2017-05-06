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
#import "MapViewPopoverControllerViewController.h"
#import "HyTransitions.h"
#import "AppManager.h"
#import "Constants.h"
#import "AppAnimationManager.h"

@interface MainMapViewController () <MKMapViewDelegate, UIPopoverPresentationControllerDelegate, mapPopoverDelegate>
{
    
    __weak IBOutlet MKMapView *mainMapView;
    NSMutableArray* mapAnnotations;
    NSMutableArray* infoArray;
    
    BOOL annotationAnimationCompleted;
    MapViewPopoverControllerViewController *viewControllerForPopover;
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
    [mainMapView setShowsUserLocation:YES];
    annotationAnimationCompleted = YES;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake([AppManager sharedInstance].userLatitude, [AppManager sharedInstance].userLongitude), 1200, 1200);
    [mainMapView setRegion:[mainMapView regionThatFits:region] animated:YES];
}

- (void)LoadTestData
{
    double lat = [AppManager sharedInstance].userLatitude + 4;
    double lng = [AppManager sharedInstance].userLongitude + 4;
    mapAnnotations = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 2; i < 20; i++)
    {
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        myAnnotation.title = @"Matthews Pizza";
        myAnnotation.subtitle = [NSString stringWithFormat:@"%d    ", i];
        [mapAnnotations addObject:myAnnotation];
        lat += 3.05 * i;
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
           // pinView.animatesDrop = YES;
            pinView.canShowCallout = NO;
            pinView.tintColor = [UIColor redColor];
            
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setUserInteractionEnabled:YES];
            imageView.layer.cornerRadius = imageView.frame.size.width/2;
            [imageView.layer setMasksToBounds:YES];
            [imageView setImageWithURL:[NSURL URLWithString:@"https://pbs.twimg.com/profile_images/656849296629874688/U9YyrNfm.jpg"] placeholderImage:[UIImage imageNamed:@"loading.png"]];
            imageView.transform = CGAffineTransformMakeScale(0.1,0.1);
            
//            imageView.userInteractionEnabled = YES;
//            UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LocationSelected:)];
//            [imageView addGestureRecognizer:tapGesture];
            
            [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
            
            [pinView addSubview:imageView];
            pinView.centerOffset = CGPointMake(0, imageView.frame.size.height / 2);
            pinView.calloutOffset = CGPointMake(0, 32);
            
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"did select annotation called");
    [mainMapView deselectAnnotation:view.annotation animated:YES];
    [[AppAnimationManager sharedInstance] SpringAnimationForView:view];
    if (viewControllerForPopover) {
        viewControllerForPopover = nil;
        viewControllerForPopover.delegate = nil;
    }
    
    viewControllerForPopover =
    [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewPopoverControllerViewController"];
    
    viewControllerForPopover.modalPresentationStyle = UIModalPresentationPopover;
    viewControllerForPopover.delegate = self;
    UIPopoverPresentationController *presentationPopover = viewControllerForPopover.popoverPresentationController;
    presentationPopover.backgroundColor = THEME_COLOR_BACKGROUND;
    
    viewControllerForPopover.preferredContentSize = CGSizeMake(self.view.frame.size.width, 200);
    viewControllerForPopover.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    if (presentationPopover != NULL) {
        presentationPopover.sourceView = view;
        presentationPopover.delegate = self;
        presentationPopover.permittedArrowDirections = UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown;
        presentationPopover.sourceRect = view.bounds;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:viewControllerForPopover animated:NO completion:nil];
    });
    
    
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

#pragma MapviewPopoverController delegate
- (void)GetDirectionCalled
{
    [viewControllerForPopover dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"get_directions" object:self userInfo:userInfo];
}

@end
