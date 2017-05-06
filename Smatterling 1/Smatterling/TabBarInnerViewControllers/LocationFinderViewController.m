//
//  LocationFinderViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 15/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "LocationFinderViewController.h"
#import "LocationTableViewCell.h"
#import "AppAnimationManager.h"
#import "UIView+RoundedCorners.h"

@interface LocationFinderViewController ()
{
    
    
}
@end

@implementation LocationFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)BackBtnTpd:(id)sender
{
   // [self dismissViewControllerAnimated:YES completion:nil];
    
    [[AppAnimationManager sharedInstance] HideSubview:self.view onMainView:self.view.superview];
}

#pragma mark - TableView Delegate/DataSource Meathods


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (LocationTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"LocationTableViewCell";
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    [cell.distanceView setRoundedCorners:UIRectCornerAllCorners radius:CGRectGetHeight(cell.distanceView.bounds) / 2 andBorderWidth:1.0];
    return cell;
}


#pragma mark UITableView Delegate Meahod

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
@end
