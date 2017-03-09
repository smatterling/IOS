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
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    result = [PHAsset fetchAssetsWithOptions:options];
    imageManager = [[PHCachingImageManager alloc] init];
    
//    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
//    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
//    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
//    requestOptions.synchronous = true;
//
//    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
//
//    NSLog(@"%d",(int)result.count);
//    
//    PHImageManager *manager = [PHImageManager defaultManager];
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[result count]];
//    
//    // assets contains PHAsset objects.
//    
//    __block UIImage *ima;
//    for (PHAsset *asset in result) {
//        // Do something with the asset
//        
//        [manager requestImageForAsset:asset
//                           targetSize:PHImageManagerMaximumSize
//                          contentMode:PHImageContentModeDefault
//                              options:requestOptions
//                        resultHandler:^void(UIImage *image, NSDictionary *info) {
//                            ima = image;
//                            
//                            [images addObject:ima];
//                        }];
//        
//        
//    }
//    
//    imageArray = [images copy];  // You can direct use NSMutuable Array images
    [photoCollectionView reloadData];
    
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
    [cell ConfigureCell];
    [cell PopulateCell];
    
    PHAsset *asset = result[indexPath.item];
    
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
   // requestOptions.synchronous = true;

    
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage *result, NSDictionary *info)
     {
         cell.avatarImageView.image = result;
     }];
    
    return cell;
}


#pragma mark UICollectionView Delegate Meathod

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
