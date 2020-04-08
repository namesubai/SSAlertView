//
//  SSAlertCommonView.h
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSAlertCommonViewType) {
    SSAlertType,
    SSActionSheetType,
};


@interface SSAlertAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, copy) void(^addAction)(void);

@end


@interface SSAlertCommonView : UIView
- (id)initWithTitle:(NSString * __nullable)title
            message:(NSString * __nullable)message
           viewType:(SSAlertCommonViewType)viewType
            actions:(NSArray <SSAlertAction *> *)actions;
@end

NS_ASSUME_NONNULL_END
