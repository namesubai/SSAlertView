//
//  ViewController.m
//  SSAlertViewDemo
//
//  Created by Shuqy on 2020/4/8.
//  Copyright © 2020 Shuqy. All rights reserved.
//

#import "ViewController.h"
#import <SSAlertView/SSAlertView.h>
#import "CustomViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.dataArray = @[@{@"title":@"showAlertView",
                         @"selector":NSStringFromSelector(@selector(showAlertAction))},
                       @{@"title":@"showActionSheet",
                         @"selector":NSStringFromSelector(@selector(showActionSheetViewAction))},
                       @{@"title":@"showCustomView",
                         @"selector":NSStringFromSelector(@selector(showCustomAction))}];
    // Do any additional setup after loading the view.
}

- (void)showAlertAction{
    SSCustomAlertView *alertView = [SSCustomAlertView alertViewWithTitle:@"标题"
                                                                message:@"内容内容内容内容内容内容内容内容内容内"

                                                               cancelButton:@"取消"
                                                               otherButtons:@[@"确定"]
                                                                     onView:self.view
                                                                clickAction:^(NSInteger index) {}];
    [alertView showViewAnimation:YES];
}

- (void)showActionSheetViewAction {
    SSCustomAlertView *alertView = [SSCustomAlertView actionSheetViewWithTitle:@"标题" message:@"内容内容内容内容内容内容内容内容内容内容" cancelButton:@"取消" otherButtons:@[@"action1",@"action2",@"action3",@"action4"] onView:self.view clickAction:^(NSInteger index) {
        
    }];
    [alertView showViewAnimation:YES];
}

- (void)showCustomAction {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomViewController *vc = [ mainStory instantiateViewControllerWithIdentifier:@"CustomViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL action = NSSelectorFromString(self.dataArray[indexPath.row][@"selector"]) ;
    [self performSelector:action withObject:nil];
}

@end
