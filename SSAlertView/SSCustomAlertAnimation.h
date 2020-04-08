//
//  SSCustomAlertAnimation.h
//  SSAlertView
//
//  Created by Shuqy on 2020/1/13.
//  Copyright © 2020 shuqy. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SSCustomAlertView;

@protocol SSCustomAlertAnimation <NSObject>

- (void)showAnimationOfAnimationView:(SSCustomAlertView *)animationView
                            viewSize:(CGSize)viewSize
                           animation:(BOOL)animation;

- (void)hideAnimationOfAnimationView:(SSCustomAlertView *)animationView
                            viewSize:(CGSize)viewSize
                           animation:(BOOL)animation;


@end
