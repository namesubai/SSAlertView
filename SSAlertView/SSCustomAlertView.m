//
//  SSAlertCustomView.m
//  SSAlertView
//
//  Created by Shuqy on 2020/1/13.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import "SSCustomAlertView.h"
#import "UIView+SSFrameHelper.h"


@interface SSCustomAlertView()
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *onView;
@property (nonatomic, strong) UIButton *backgroundMaskButton;
///遮罩类型
@property (nonatomic, assign) SSCustomAlertBackgroundMaskType masktype;
@end

@implementation SSCustomAlertView

- (id)initWithCustomView:(UIView *)customView
                  onView:(nonnull UIView *)onView{
    return [self initWithCustomView:customView onView:onView masktype:SSCustomAlertBackgroundMaskTypeNone];
}

- (id)initWithCustomView:(UIView *)customView
                  onView:(UIView *)onView
                masktype:(SSCustomAlertBackgroundMaskType)masktype {
    if (self = [super initWithFrame:CGRectZero]) {
        if (onView) {
            self.customView = customView;
            self.onView = onView;
            self.masktype = masktype;
            [self setupViews];
        }
    }
    
    return self;
}


- (void)setupViews {
    self.canTouchMaskHide = YES;
    if (self.customView) {
        if (self.masktype != SSCustomAlertBackgroundMaskTypeNone) {
            [self.onView addSubview:self.backgroundMaskButton];
            [self.backgroundMaskButton addTarget:self action:@selector(backgroundMaskAction) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:self.customView];
        [self.onView addSubview:self];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.customView.ss_x = self.customEdgeInsets.left;
    self.customView.ss_y = self.customEdgeInsets.top;
}

- (void)showViewAnimation:(BOOL)animation {
    
    if ([self.customAnimation respondsToSelector:@selector(showAnimationOfAnimationView:viewSize:animation:)]) {
        CGSize customViewSize = [self.customView systemLayoutSizeFittingSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        if (!CGSizeEqualToSize(self.customView.ss_size, CGSizeZero)) {
            customViewSize = self.customView.ss_size;
        }
        CGSize size = CGSizeMake(customViewSize.width + self.customEdgeInsets.left + self.customEdgeInsets.right, customViewSize.height + self.customEdgeInsets.top + self.customEdgeInsets.bottom);
        [self.customAnimation showAnimationOfAnimationView:self viewSize:size animation:animation];
    }
    
}

- (void)hideViewAnimation:(BOOL)animation {
    if ([self.customAnimation respondsToSelector:@selector(hideAnimationOfAnimationView:viewSize:animation:)]) {
        CGSize customViewSize = [self.customView systemLayoutSizeFittingSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        if (!CGSizeEqualToSize(self.customView.ss_size, CGSizeZero)) {
            customViewSize = self.customView.ss_size;
        }
        CGSize size = CGSizeMake(customViewSize.width + self.customEdgeInsets.left + self.customEdgeInsets.right, customViewSize.height + self.customEdgeInsets.top + self.customEdgeInsets.bottom);
        [self.customAnimation hideAnimationOfAnimationView:self viewSize:size animation:animation];
    }

}

- (void)backgroundMaskAction {
    if (self.canTouchMaskHide) {
        [self hideViewAnimation:YES];
    }
}


#pragma mark - getter


- (UIButton *)backgroundMaskButton {
    if (!_backgroundMaskButton) {
        _backgroundMaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundMaskButton.alpha = 0;
        _backgroundMaskButton.frame = CGRectMake(0, 0, self.onView.ss_w, self.onView.ss_h);
        _backgroundMaskButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    return _backgroundMaskButton;
}

- (UIView *)backgroundMask {
    return self.backgroundMaskButton;
}


#pragma mark - setter

- (void)setCustomEdgeInsets:(UIEdgeInsets)customEdgeInsets {
    _customEdgeInsets = customEdgeInsets;
    [self layoutIfNeeded];
}

- (void)setMasktype:(SSCustomAlertBackgroundMaskType)masktype {
    _masktype = masktype;
    if (masktype != SSCustomAlertBackgroundMaskTypeNone) {
        if (masktype == SSCustomAlertBackgroundMaskTypeBlack) {
            self.backgroundMaskButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
