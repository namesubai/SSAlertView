//
//  SSAlertCustomView.h
//  SSAlertView
//
//  Created by Shuqy on 2020/1/13.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSDefaultAlertAnimation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSCustomAlertBackgroundMaskType) {
    SSCustomAlertBackgroundMaskTypeNone, //默认没有遮罩
    SSCustomAlertBackgroundMaskTypeClear, //透明遮罩
    SSCustomAlertBackgroundMaskTypeBlack, //黑色遮罩
};

@interface SSCustomAlertView : UIView
///customView 的内间距
@property (nonatomic, assign) UIEdgeInsets customEdgeInsets;
///展示和隐藏动画设置
@property (nonatomic, strong) id <SSCustomAlertAnimation> customAnimation;
///遮罩视图
@property (nonatomic, strong, readonly) UIView *backgroundMask;
///是否点击遮罩隐藏，默认点击会隐藏
@property (nonatomic, assign) BOOL canTouchMaskHide;

///初始化
- (id)initWithCustomView:(UIView *)customView
                  onView:(UIView *)onView;
- (id)initWithCustomView:(UIView *)customView
                  onView:(UIView *)onView
                masktype:(SSCustomAlertBackgroundMaskType)masktype;
///展示
- (void)showViewAnimation:(BOOL)animation;
///隐藏
- (void)hideViewAnimation:(BOOL)animation;
@end


NS_ASSUME_NONNULL_END
