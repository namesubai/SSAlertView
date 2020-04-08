//
//  SSCustomAlertView+Extention.m
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import "SSCustomAlertView+Extention.h"
#import "SSAlertCommonView.h"


@implementation SSCustomAlertView (Extention)
+ (instancetype)alertViewWithTitle:(NSString * __nullable)title
                           message:(NSString * __nullable)message
                      cancelButton:(NSString * __nullable)cnacelButton
                      otherButtons:(NSArray <NSString *> * __nullable)otherButtons
                            onView:(UIView *)onView
                       clickAction:(void(^ __nullable)(NSInteger index))clickAction

{
    NSMutableArray *actionArray = @[].mutableCopy;
    SSAlertAction *cancelAction = nil;
    if (cnacelButton.length) {
        cancelAction = [[SSAlertAction alloc]init];
        cancelAction.title = cnacelButton;
        [actionArray addObject:cancelAction];
    }
    [otherButtons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       SSAlertAction *action= [[SSAlertAction alloc]init];
       action.title = obj;
       [actionArray addObject:action];
        [action setAddAction:^{
            if (clickAction) {
                clickAction(1 + idx);
            }
        }];
    }];
    
    SSAlertCommonView *customView =[[SSAlertCommonView alloc]initWithTitle:title
                                                                   message:message
                                                                  viewType:SSAlertType
                                                                   actions:actionArray];
    SSCustomAlertView *alertView = [[SSCustomAlertView alloc]initWithCustomView:customView
                                                                         onView:onView
                                                            masktype:SSCustomAlertBackgroundMaskTypeBlack];
    SSDefaultAlertAnimation *animation = [[SSDefaultAlertAnimation alloc]initWithState:SSDefaultAlertAnimationCenterState];
    alertView.customAnimation = animation;
    alertView.canTouchMaskHide = NO;
    alertView.layer.cornerRadius = 5.0f;
    alertView.clipsToBounds = YES;
    __weak typeof(SSCustomAlertView *) weakAlertView = alertView;
    [cancelAction setAddAction:^{
        __strong typeof(SSCustomAlertView *) strongAlertView = weakAlertView;
        [strongAlertView hideViewAnimation:YES];
        if (clickAction) {
            clickAction(0);
        }
    }];
    
    return alertView;
}



+ (instancetype)actionSheetViewWithTitle:(NSString * __nullable)title
                                 message:(NSString * __nullable)message
                            cancelButton:(NSString * __nullable)cnacelButton
                            otherButtons:(NSArray <NSString *> * __nullable)otherButtons
                                  onView:(UIView *)onView
                             clickAction:(void(^ __nullable)(NSInteger index))clickAction
{
    NSMutableArray *actionArray = @[].mutableCopy;
    [otherButtons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       SSAlertAction *action= [[SSAlertAction alloc]init];
       action.title = obj;
       [actionArray addObject:action];
        [action setAddAction:^{
            if (clickAction) {
                clickAction(1 + idx);
            }
        }];
    }];
    
    
    SSAlertAction *cancelAction = nil;
    if (cnacelButton.length) {
        cancelAction = [[SSAlertAction alloc]init];
        cancelAction.title = cnacelButton;
        [actionArray addObject:cancelAction];
    }

    
    
    SSAlertCommonView *customView =[[SSAlertCommonView alloc]initWithTitle:title
                                                                   message:message
                                                                  viewType:SSActionSheetType
                                                                   actions:actionArray];
    SSCustomAlertView *alertView = [[SSCustomAlertView alloc]initWithCustomView:customView
                                                                         onView:onView
                                                            masktype:SSCustomAlertBackgroundMaskTypeBlack];
    SSDefaultAlertAnimation *animation = [[SSDefaultAlertAnimation alloc]initWithState:SSDefaultAlertAnimationBottomState];
    alertView.customAnimation = animation;
    __weak typeof(SSCustomAlertView *) weakAlertView = alertView;
    [cancelAction setAddAction:^{
        __strong typeof(SSCustomAlertView *) strongAlertView = weakAlertView;
        [strongAlertView hideViewAnimation:YES];
        if (clickAction) {
            clickAction(0);
        }
    }];
    
    return alertView;
}


@end
