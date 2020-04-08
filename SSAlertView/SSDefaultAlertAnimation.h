//
//  SSDefaultAlertAnimation.h
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSCustomAlertAnimation.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

///四种呈现的方式
typedef NS_ENUM(NSInteger,SSDefaultAlertAnimationState) {
    ///重顶部开始呈现
    SSDefaultAlertAnimationTopState,
    ///从左边开始呈现
    SSDefaultAlertAnimationLeftState,
    ///从底部开始呈现
    SSDefaultAlertAnimationBottomState,
    ///从右边开始呈现
    SSDefaultAlertAnimationRightState,
    ///中心位置呈现
    SSDefaultAlertAnimationCenterState,
};

@interface SSDefaultAlertAnimation : NSObject <SSCustomAlertAnimation>
///view相对中心点的偏移量
@property (nonatomic, assign) CGPoint centeroffset;

///初始化方法
- (instancetype)initWithState:(SSDefaultAlertAnimationState)state;


@end

NS_ASSUME_NONNULL_END
