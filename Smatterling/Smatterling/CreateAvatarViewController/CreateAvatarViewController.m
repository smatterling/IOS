//
//  CreateAvatarViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 07/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "CreateAvatarViewController.h"
#import "AvatarCollectionViewCell.h"
#import <Photos/Photos.h>
@interface CreateAvatarViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{

    __weak IBOutlet UICollectionView *photoCollectionView;
    __weak IBOutlet UIImageView *avatarImageView;
    
}
@end

@implementation CreateAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getAllPhotosFromCamera];
}

NSArray *imageArray;
NSMutableArray *mutableArray;
PHFetchResult *result;
PHCachingImageManager *imageManager;

-(void)getAllPhotosFromCamera
{
    imageArray=[[NSArray alloc] init];
    mutableArray =[[NSMutableArray alloc]init];
    
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized)
            {
                PHFetchOptions *options = [[PHFetchOptions alloc] init];
                options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
                result = [PHAsset fetchAssetsWithOptions:options];
                //    PHAsset]
                imageManager = [[PHCachingImageManager alloc] init];
                [photoCollectionView reloadData];
            }
            
            else {
                // Access has been denied.
            }
        }];
        
    }else if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized)
    {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        result = [PHAsset fetchAssetsWithOptions:options];
        //    PHAsset]
        imageManager = [[PHCachingImageManager alloc] init];
        [photoCollectionView reloadData];
    }
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
    
    return [result count];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (AvatarCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier=@"AvatarCollectionViewCell";
    
    AvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    PHAsset *asset = result[indexPath.item];
    
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
   // requestOptions.synchronous = true;

    cell.avatarImageView.image = nil;
    
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage *result, NSDictionary *info)
     {
         if (indexPath.row == 0) {
             avatarImageView.image = result;
         }
         cell.avatarImageView.image = result;
     }];
    
    
   // [cell.avatarImageView setFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame) - 10, CGRectGetHeight(cell.frame) - 10)];
   // cell.avatarImageView.center = cell.center;
    
    [cell ConfigureCell];
    [cell PopulateCell];
    
    
    return cell;
}


#pragma mark UICollectionView Delegate Meathod

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AvatarCollectionViewCell* cell = (AvatarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.avatarImageView.hidden = NO;
    
    PHAsset *asset = result[indexPath.item];
    
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info)
     {
         avatarImageView.image = result;
     }];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = (collectionView.frame.size.height - 45)/2;
    CGSize cellSize = CGSizeMake(cellHeight, cellHeight);
    return cellSize;
}


- (IBAction)BackBtnTpd:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
