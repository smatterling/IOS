//
//  RateUserViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 17/04/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "RateUserViewController.h"
#import "Constants.h"
#import "RateUserCollectionViewCell.h"
@interface RateUserViewController ()
{
    
    __weak IBOutlet UIView *innerContentView;
    __weak IBOutlet UICollectionView *usersCollectionView;
    __weak IBOutlet UIView *bottomView;
    
    
    __weak IBOutlet UIView *fiveView;
    __weak IBOutlet UIButton *fiveButton;
    
    __weak IBOutlet UIView *tenView;
    __weak IBOutlet UIButton *tenButton;
    __weak IBOutlet UIButton *twentyButton;
    __weak IBOutlet UIView *twentyView;
    __weak IBOutlet UIView *minusFiveView;
    __weak IBOutlet UIButton *minusFiveButton;
    __weak IBOutlet UIView *minusTenView;
    __weak IBOutlet UIButton *minusTenButton;
    __weak IBOutlet UIView *minusTwentyView;
    __weak IBOutlet UIButton *minusTwentyButton;
    __weak IBOutlet UIImageView *tickImageView;
    
    RateUserCollectionViewCell* selectedCell;
    RateUserCollectionViewCell* lastSelectedCell;
    
}
@end

@implementation RateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [fiveView.layer setCornerRadius:fiveView.bounds.size.height/2];
    [fiveView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [fiveView.layer setBorderWidth:1.0];
    [fiveView.layer setMasksToBounds:YES];
    
    
    [tenView.layer setCornerRadius:tenView.bounds.size.height/2];
    [tenView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [tenView.layer setBorderWidth:1.0];
    [tenView.layer setMasksToBounds:YES];
    
    
    [twentyView.layer setCornerRadius:twentyView.bounds.size.height/2];
    [twentyView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [twentyView.layer setBorderWidth:1.0];
    [twentyView.layer setMasksToBounds:YES];
    
    
    [minusFiveView.layer setCornerRadius:minusFiveView.bounds.size.height/2];
    [minusFiveView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [minusFiveView.layer setBorderWidth:1.0];
    [minusFiveView.layer setMasksToBounds:YES];
    
    
    [minusTenView.layer setCornerRadius:minusTenView.bounds.size.height/2];
    [minusTenView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [minusTenView.layer setBorderWidth:1.0];
    [minusTenView.layer setMasksToBounds:YES];
    
    [minusTwentyView.layer setCornerRadius:minusTwentyView.bounds.size.height/2];
    [minusTwentyView.layer setBorderColor: THEME_COLOR_BORDER_BLUE];
    [minusTwentyView.layer setBorderWidth:1.0];
    [minusTwentyView.layer setMasksToBounds:YES];
    
    [tickImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideRateView:)];
    [tickImageView addGestureRecognizer:gesture];
}

- (void)hideRateView:(UITapGestureRecognizer*)gesture
{
    NSLog(@"HIde button tapped");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self AnimateTickButton];
}

- (void)AnimateTickButton
{
    tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
   // createAvatarView.hidden = NO;
    [UIView animateWithDuration:0.6/1.5 animations:^{
        //bottomView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            //      bottomView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            tickImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                //        bottomView.transform = CGAffineTransformIdentity;
                tickImageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];

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

- (IBAction)RateBtnTpd:(id)sender {
    if (selectedCell.isShowingOverlay) {
        UIButton* button = (UIButton*)sender;
        switch (button.tag) {
            case 0:
            {
                selectedCell.pointsLabel.text = @"5";
                break;
            }
            case 1:
            {
                selectedCell.pointsLabel.text = @"10";
                break;
            }
            case 2:
            {
                selectedCell.pointsLabel.text = @"20";
                break;
            }
            case 3:
            {
                selectedCell.pointsLabel.text = @"-5";
                break;
            }
            case 4:
            {
                selectedCell.pointsLabel.text = @"-10";
                break;
            }
            case 5:
            {
                selectedCell.pointsLabel.text = @"-20";
                break;
            }
                
            default:
                break;
        }
        
    }
}


#pragma mark - CollectionView Delegate/DataSource Meathods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 8;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (RateUserCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"RateUserCollectionViewCell";
    
    RateUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    [cell ConfigureCell];
    [cell PopulateCell];
    
    /*if (indexPath.row%3) {
        cell.backgroundColor = [UIColor redColor];
    }
    else
    {
        cell.backgroundColor = [UIColor yellowColor];
    }*/
    
    return cell;
}


#pragma mark UICollectionView Delegate Meathod

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedCell)
    {
        lastSelectedCell = selectedCell;
        if ([lastSelectedCell isShowingOverlay]) {
            [lastSelectedCell HideOverlayView];
        }
    }

    
    selectedCell = (RateUserCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!selectedCell.isShowingOverlay) {
        [selectedCell ShowOverlayView];
    }
    else
    {
        [selectedCell HideOverlayView];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    int cellWidth = (collectionView.frame.size.width)/2;
    int cellHeight = (collectionView.frame.size.height)/2;
    CGSize cellSize = CGSizeMake(cellWidth, cellHeight);
    return cellSize;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (selectedCell.isShowingOverlay) {
        [selectedCell HideOverlayView];
    }
}


@end
