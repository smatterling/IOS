//
//  MapViewPopoverControllerViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 23/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "MapViewPopoverControllerViewController.h"
#import "AvatarCollectionViewCell.h"
#import "UIView+RoundedCorners.h"

@interface MapViewPopoverControllerViewController ()
{
    
    __weak IBOutlet UIView *directionView;
}
@end

@implementation MapViewPopoverControllerViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [directionView setRoundedCorners:UIRectCornerAllCorners radius:directionView.frame.size.width/2 andBorderWidth:1.0];
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

#pragma mark - CollectionView Delegate/DataSource Meathods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (AvatarCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"AvatarCollectionViewCell";
    
    AvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell ConfigureCell];
    [cell PopulateCell];
    return cell;
}

- (IBAction)GetDirectionBtnTpd:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(GetDirectionCalled)]) {
        [self.delegate GetDirectionCalled];
    }
}
@end
