//
//  SSAlertCommonView.m
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import "SSAlertCommonView.h"
#import "UIView+SSFrameHelper.h"

#define kAlertViewScreenWidth           [UIScreen mainScreen].bounds.size.width
#define kAlertViewScreenHeight          [UIScreen mainScreen].bounds.size.height
#define kAlertViewMaxWidth              kAlertViewScreenWidth * 0.7
#define kActionSheetViewMaxWidth        kAlertViewScreenWidth


static const CGFloat kAlertViewButtonHeight = 40;
static const CGFloat kActionSheetButtonHeight = 50;

 CGFloat kSafeAreaBottomHeight(){
    CGFloat bottomHeight = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        bottomHeight = mainWindow.safeAreaInsets.bottom;

    }
    
    return bottomHeight;
}


@implementation SSAlertAction


@end


@interface SSAlertCommonView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSMutableArray <SSAlertAction *> *actionArray;
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;
@property (nonatomic, assign) SSAlertCommonViewType viewtype;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *contianerView;
@end

@implementation SSAlertCommonView

- (id)initWithTitle:(NSString * __nullable)title
            message:(NSString * __nullable)message
           viewType:(SSAlertCommonViewType)viewType
            actions:(NSArray <SSAlertAction *> *)actions {
    
    if (self = [super initWithFrame:CGRectZero]) {
        self.viewtype = viewType;
        self.actionArray = actions.mutableCopy;
        self.backgroundColor = [UIColor whiteColor];
        
        _contianerView = [UIView new];
        [self addSubview:_contianerView];
        
        if (title.length) {
            _titleLabel = [UILabel new];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.numberOfLines = 0;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.text = title;
            [_contianerView addSubview:_titleLabel];
        }
        
        if (message.length) {
            _messageLabel = [UILabel new];
            _messageLabel.font = [UIFont systemFontOfSize:14];
            _messageLabel.numberOfLines = 0;
            _messageLabel.textAlignment = NSTextAlignmentCenter;
            _messageLabel.text = message;
            [_contianerView addSubview:_messageLabel];
        }
        
        
        if (actions.count) {
            _buttonView = [[UIView alloc]init];
            _buttonView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:_buttonView];
            
            _buttonArray = @[].mutableCopy;
            [actions enumerateObjectsUsingBlock:^(SSAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button setTitle:obj.title forState:UIControlStateNormal];
                [button setBackgroundColor:self.backgroundColor];
                button.titleLabel.font = obj.titleFont;
                [button setTitleColor:obj.titleColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_buttonView addSubview:button];
                [_buttonArray addObject:button];
            }];
            
        }
        

        [self refreshFrame];
    }
    
    return self;
}

- (void)refreshFrame {
    CGFloat space = 15;
    CGFloat viewMaxWidth = self.viewtype == SSAlertType? kAlertViewMaxWidth:kActionSheetViewMaxWidth;
    CGFloat height = 0, width = viewMaxWidth,containerWidth = viewMaxWidth - space * 2;
    CGFloat originY = 0;
    
    CGFloat cotainerOriginY = 0;
    if (self.titleLabel) {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(containerWidth, MAXFLOAT)];
        self.titleLabel.ss_origin = CGPointMake(0,cotainerOriginY);
        self.titleLabel.ss_size = CGSizeMake(containerWidth, titleSize.height);
        height += titleSize.height + space;
        cotainerOriginY += space + titleSize.height;
        originY = space;
    }
    if (self.messageLabel) {
        CGSize messageSize = [self.messageLabel sizeThatFits:CGSizeMake(containerWidth, MAXFLOAT)];
        self.messageLabel.ss_origin = CGPointMake(0, cotainerOriginY);
        self.messageLabel.ss_size = CGSizeMake(containerWidth, messageSize.height);;
        height += messageSize.height + space;
        originY = space;
    }
    
    self.contianerView.ss_origin = CGPointMake(space, originY);
    self.contianerView.ss_size = CGSizeMake(containerWidth, height);
    originY += height;

    
    if (self.buttonArray.count) {
        CGFloat buttonSpace = 0.5;
        CGFloat button_total_height = 0;
        CGFloat buttonTopLineHeight = 0.5;
        
        if (self.viewtype == SSActionSheetType) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 obj.ss_origin = CGPointMake(0, buttonTopLineHeight + (kActionSheetButtonHeight + buttonSpace) * idx);
                if (idx == self.buttonArray.count - 1) {
                    obj.ss_size = CGSizeMake(width, kActionSheetButtonHeight + kSafeAreaBottomHeight());
                    obj.titleEdgeInsets = UIEdgeInsetsMake(-kSafeAreaBottomHeight(), 0, 0, 0);
                }else {
                    obj.ss_size = CGSizeMake(width, kActionSheetButtonHeight);
                }
             }];
             button_total_height = buttonTopLineHeight + kActionSheetButtonHeight  * self.buttonArray.count + buttonSpace * (self.buttonArray.count - 1) + kSafeAreaBottomHeight();
        }
        
        if (self.viewtype == SSAlertType) {
            if (self.buttonArray.count > 2) {
                [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.ss_origin = CGPointMake(0, buttonTopLineHeight + (kAlertViewButtonHeight + buttonSpace) * idx);
                    obj.ss_size = CGSizeMake(width, kAlertViewButtonHeight);
                }];
                button_total_height = buttonTopLineHeight + kAlertViewButtonHeight  * self.buttonArray.count + buttonSpace * (self.buttonArray.count - 1);

            }else {
                if (self.buttonArray.count == 1) {
                    UIView *button = self.buttonArray.firstObject;
                    button.ss_origin = CGPointMake(0, buttonTopLineHeight);
                    button.ss_size = CGSizeMake(width, kAlertViewButtonHeight);
                }else {
                    UIView *button1 = self.buttonArray.firstObject;
                    button1.ss_origin = CGPointMake(0, buttonTopLineHeight);
                    button1.ss_size = CGSizeMake(width/2.0 - buttonSpace/2.0, kAlertViewButtonHeight);
                    
                    UIView *button2 = self.buttonArray.lastObject;
                    button2.ss_origin = CGPointMake(button1.ss_w + buttonSpace, buttonTopLineHeight);
                    button2.ss_size = CGSizeMake(width/2.0 - buttonSpace/2.0, kAlertViewButtonHeight);
                }
                button_total_height = kAlertViewButtonHeight + buttonTopLineHeight;

            }
        }
   
        _buttonView.ss_origin = CGPointMake(0, originY + 0.5);
        _buttonView.ss_size = CGSizeMake(width, button_total_height);
        height += button_total_height + (originY > 0 ? space : 0);
        
    }
    
    self.ss_size = CGSizeMake(width, height);
}


- (void)layoutSubviews {
    [super layoutSubviews];
  
}


- (void)buttonAction:(UIButton *)button {
    NSInteger index = [self.buttonArray indexOfObject:button];
    SSAlertAction *action = [self.actionArray objectAtIndex:index];
    if (action.addAction) {
        action.addAction();
    }
}



@end
