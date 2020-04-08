//
//  CustomViewController.m
//  SSAlertViewDemo
//
//  Created by Shuqy on 2020/4/8.
//  Copyright © 2020 Shuqy. All rights reserved.
//

#import "CustomViewController.h"
#import "SSCustomAlertView.h"
#import <SSAlertView/SSAlertView.h>

@interface CustomViewController ()
@property (nonatomic, strong) SSCustomAlertView *customAlertView;
@property(nonatomic, assign)   SSDefaultAlertAnimationState state;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)showAction:(id)sender {
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor yellowColor];
    tempView.ss_w = 200;
    tempView.ss_h = 200;
    _customAlertView = [[SSCustomAlertView alloc]initWithCustomView:tempView onView:self.view.window masktype:SSCustomAlertBackgroundMaskTypeBlack];
    _customAlertView.backgroundColor = [UIColor whiteColor];
    _customAlertView.customEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    SSDefaultAlertAnimation *animation = [[SSDefaultAlertAnimation alloc]initWithState:_state];
    _customAlertView.customAnimation = animation;
    [_customAlertView showViewAnimation:YES];
    
}

- (IBAction)hideAction:(id)sender{
    [_customAlertView hideViewAnimation:YES];
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    _state = sender.selectedSegmentIndex;
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
