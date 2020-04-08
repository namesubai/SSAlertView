//
//  SSCustomAlertView+Extention.h
//  SSAlertView
//
//  Created by Shuqy on 2020/1/14.
//  Copyright © 2020 shuqy. All rights reserved.
//



#import "SSCustomAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSCustomAlertView (Extention)
+ (instancetype)alertViewWithTitle:(NSString * __nullable)title
                           message:(NSString * __nullable)message
                      cancelButton:(NSString * __nullable)cnacelButton
                      otherButtons:(NSArray <NSString *> * __nullable)otherButtons
                            onView:(UIView *)onView
                       clickAction:(void(^ __nullable)(NSInteger index))clickAction;

+ (instancetype)actionSheetViewWithTitle:(NSString * __nullable)title
                                 message:(NSString * __nullable)message
                            cancelButton:(NSString * __nullable)cnacelButton
                            otherButtons:(NSArray <NSString *> * __nullable)otherButtons
                                  onView:(UIView *)onView
                             clickAction:(void(^ __nullable)(NSInteger index))clickAction;

@end

NS_ASSUME_NONNULL_END
