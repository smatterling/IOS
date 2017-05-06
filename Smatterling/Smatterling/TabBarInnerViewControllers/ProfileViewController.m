//
//  ProfileViewController.m
//  Smatterling
//
//  Created by Muhammad Usama on 14/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIView+RoundedCorners.h"
#import "ProfileMeetingTableViewCell.h"
#import "AppAnimationManager.h"
#import "SignupViewController.h"

@interface ProfileViewController ()
{
    
    __weak IBOutlet UIView *meetingsView;
    __weak IBOutlet UIScrollView *topScrollView;
    __weak IBOutlet UITableView *meetingTableView;
    __weak IBOutlet UIView *historyOuterView;
    __weak IBOutlet UIView *historyInnerView;
    __weak IBOutlet UITableView *historyTableView;
    __weak IBOutlet UIImageView *photoImageView;
    __weak IBOutlet UIImageView *blendImageView;
    
    float start;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [meetingsView setRoundedCorners:UIRectCornerAllCorners radius:meetingsView.frame.size.width/2 andBorderWidth:1.0];
    
//    photoImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//    photoImageView.layer.shadowOffset = CGSizeMake(0, 50);
//    photoImageView.layer.shadowOpacity = 0.8;
//    photoImageView.layer.shadowRadius = 5;
//    photoImageView.layer.masksToBounds = NO;
    

}


- (void)viewWillAppear:(BOOL)animated
{
    topScrollView.frame = CGRectMake(topScrollView.frame.origin.x, topScrollView.frame.origin.y, self.view.frame.size.width, topScrollView.frame.size.height);
    CGRect tableViewFrame = CGRectMake(historyTableView.frame.origin.x, historyTableView.frame.origin.y, self.view.frame.size.width - (historyTableView.frame.origin.x * 2), 100*20);
    CGRect innerViewFrame = CGRectMake(historyInnerView.frame.origin.x, historyInnerView.frame.origin.y, self.view.frame.size.width, tableViewFrame.size.height + photoImageView.frame.size.height + 20);
    CGRect outerViewFrame = CGRectMake(historyOuterView.frame.origin.x, historyOuterView.frame.origin.y, self.view.frame.size.width, innerViewFrame.size.height);
    
    historyTableView.frame = tableViewFrame;
    historyInnerView.frame = innerViewFrame;
   // blendImageView.frame = CGRectMake(0, 0, blendImageView.frame.size.width, innerViewFrame.size.height);
    historyOuterView.frame = outerViewFrame;
    
    meetingsView.center = CGPointMake(self.view.frame.size.width/2, meetingsView.frame.origin.y + (meetingsView.frame.size.height/2));
    
    topScrollView.contentSize = CGSizeMake(self.view.frame.size.width, outerViewFrame.size.height);
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

#pragma mark - TableView Delegate/DataSource Meathods


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (ProfileMeetingTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"ProfileMeetingTableViewCell";
    ProfileMeetingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell ConfigureCell];
    return cell;
}


#pragma mark UITableView Delegate Meahod

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)SettingsBtnTpd:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Settings" object:self];
}
@end
