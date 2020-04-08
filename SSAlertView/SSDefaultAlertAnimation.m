//
//  SSDefaultAlertAnimation.m
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import "SSDefaultAlertAnimation.h"
#import "SSCustomAlertView.h"
#import "UIView+SSFrameHelper.h"

@interface SSDefaultAlertAnimation ()
@property (nonatomic, assign) SSDefaultAlertAnimationState animationState;
@end

@implementation SSDefaultAlertAnimation
- (instancetype)initWithState:(SSDefaultAlertAnimationState)state {
    if (self = [super init]) {
        self.animationState = state;
    }
    return self;
}
- (NSTimeInterval)animationDuration {
    return 0.3;
}

- (void)showAnimationOfAnimationView:(SSCustomAlertView *)animationView viewSize:(CGSize)viewSize animation:(BOOL)animation {
    animationView.alpha = 1;
    animationView.ss_size = viewSize;
    if (self.animationState == SSDefaultAlertAnimationBottomState) {
        animationView.ss_centerX  = animationView.superview.ss_w / 2.0 + self.centeroffset.x;
        animationView.ss_y = animationView.superview.ss_h + self.centeroffset.y;
        [self animationMethod:animation animations:^{
            animationView.transform = CGAffineTransformMakeTranslation(0, - animationView.ss_h);
            animationView.backgroundMask.alpha = 1;
         } completion:nil];
    }
    if (self.animationState == SSDefaultAlertAnimationTopState) {
        animationView.ss_centerX  = animationView.superview.ss_w / 2.0 + self.centeroffset.x;
        animationView.ss_y = - animationView.ss_h + self.centeroffset.y;
        [self animationMethod:animation animations:^{
            animationView.transform = CGAffineTransformMakeTranslation(0, animationView.ss_h);
            animationView.backgroundMask.alpha = 1;
        } completion:nil];
    }
    
    if (self.animationState == SSDefaultAlertAnimationLeftState) {
        animationView.ss_centerY  = animationView.superview.ss_h / 2.0 + self.centeroffset.y;
        animationView.ss_x =  - animationView.ss_w + self.centeroffset.x;
        [self animationMethod:animation animations:^{
            animationView.transform = CGAffineTransformMakeTranslation(animationView.ss_w, 0);
            animationView.backgroundMask.alpha = 1;
        } completion:nil];
    }
    
    if (self.animationState == SSDefaultAlertAnimationRightState) {
        animationView.ss_centerY  = animationView.superview.ss_h / 2.0 + self.centeroffset.y;
        animationView.ss_x = animationView.superview.ss_w + self.centeroffset.x;

        [self animationMethod:animation animations:^{
             animationView.transform = CGAffineTransformMakeTranslation(- animationView.ss_w, 0);
            animationView.backgroundMask.alpha = 1;

        } completion:nil];
    }
    
    if (self.animationState == SSDefaultAlertAnimationCenterState) {
        animationView.alpha = 0;
        animationView.ss_centerX = animationView.superview.ss_w / 2.0 + self.centeroffset.x;
        animationView.ss_centerY = animationView.superview.ss_h / 2.0 + self.centeroffset.y;
        animationView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [self animationMethod:animation animations:^{
            animationView.alpha = 1;
            animationView.transform = CGAffineTransformIdentity;
            animationView.backgroundMask.alpha = 1;

        } completion:nil];

    }
    
}

- (void)hideAnimationOfAnimationView:(SSCustomAlertView *)animationView viewSize:(CGSize)viewSize animation:(BOOL)animation {
    __block SSCustomAlertView *view = animationView;
    [self animationMethod:animation animations:^{
        if (self.animationState == SSDefaultAlertAnimationCenterState) {
            view.alpha = 0;
        }else {
            view.transform = CGAffineTransformIdentity;
        }
        view.backgroundMask.alpha = 0;

    } completion:^(BOOL finished) {
        if (finished) {
            [view removeFromSuperview];
            [view.backgroundMask removeFromSuperview];
            view = nil;
        }
    }];
}


- (void)animationMethod:(BOOL)animation
              animations:(void(^ __nullable)(void))animations
              completion:(void(^ __nullable)(BOOL finished))completion {
    if (!animation) {
        !animations? :animations();
        !completion? :completion(YES);
    }else {
        [UIView animateWithDuration:[self animationDuration]
                         animations:animations
                         completion:completion];
    }
}


@end
