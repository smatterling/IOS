//
//  HostLocationViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "HostLocationViewController.h"
#import "LocationTableViewCell.h"
#import "AppAnimationManager.h"
#import "LocationFinderViewController.h"
#import "AvatarCollectionViewCell.h"
#import "UIView+RoundedCorners.h"

#import <MapKit/MapKit.h>

@interface HostLocationViewController ()
{
    __weak IBOutlet UIView *topLocationView;
    __weak IBOutlet UIView *mapView;
    __weak IBOutlet MKMapView *locationMap;
    __weak IBOutlet UICollectionView *avatarCollectionView;
    
    LocationFinderViewController* locationFinderVC;
    
    
    __weak IBOutlet UIView *dayView;
    __weak IBOutlet UIView *monthView;
    __weak IBOutlet UIView *yearView;
}
@end

@implementation HostLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationFinderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LocationFinderViewController"];
    locationFinderVC.view.frame = CGRectMake(self.view.frame.size.width, locationFinderVC.view.frame.origin.y, locationFinderVC.view.frame.size.width, locationFinderVC.view.frame.size.height);
    [locationFinderVC.view setAlpha:0.0];
    [self.view addSubview:locationFinderVC.view];
    
    [dayView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(dayView.bounds) / 2 andBorderWidth:1.0];
    
    [monthView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(dayView.bounds) / 2 andBorderWidth:1.0];
    
    [yearView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(dayView.bounds) / 2 andBorderWidth:1.0];
    
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

- (IBAction)ShowLocationFinder:(id)sender {
    [[AppAnimationManager sharedInstance] ShowSubview:locationFinderVC.view onMainView:self.view];
}


#pragma mark - CollectionView Delegate/DataSource Meathods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 2;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (AvatarCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseableIdentifier=@"AvatarCollectionViewCell";
    
    AvatarCollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseableIdentifier forIndexPath:indexPath];
    // cell customization
    [cell ConfigureCell];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *userInfo = [channelPhotosEntries objectAtIndex:indexPath.row];
//    [[NSNotificationCenter defaultCenter] postNotificationName: @"DidSelectChannelPhoto" object:userInfo userInfo:userInfo];
}

@end
