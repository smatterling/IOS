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
    
    return 2;
    
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
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 1.0;
    
    //[cell.layer setCornerRadius:30.0f];
    
    // border
   // [cell.layer setBorderColor:[UIColor lightGrayColor].CGColor];
   // [cell.layer setBorderWidth:1.5f];
    
    // drop shadow
    [cell.layer setShadowColor:[UIColor blackColor].CGColor];
    [cell.layer setShadowOpacity:0.8];
    [cell.layer setShadowRadius:3.0];
    [cell.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = collectionView.frame.size.height;
    CGSize cellSize = CGSizeMake(cellHeight, cellHeight);
    return cellSize;
}


- (IBAction)GetDirectionBtnTpd:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(GetDirectionCalled)]) {
        [self.delegate GetDirectionCalled];
    }
}
@end
