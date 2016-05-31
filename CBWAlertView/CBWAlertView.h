//
//  CBWAlertView.h
//  CBWKit
//
//  Created by 陈博文 on 16/4/29.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AnimationTypeFade = 1,
    AnimationTypeBigToSmall,
    AnimationTypeSmallToBig,
} AnimationType;

@class CBWAlertView;
typedef void(^CBWAlertViewHandler) (CBWAlertView *alertView);

@interface CBWAlertView : UIView
/** titleTextColor*/
@property (nonatomic ,strong) UIColor *titleTextColor;
/** messageTextColor*/
@property (nonatomic ,strong) UIColor *messageTextColor;
/** animationType*/
@property (nonatomic ,assign)  AnimationType animationType;
/** containerView*/
@property (nonatomic ,strong) UIView *containerView;
/** 处理button 点击的block*/
@property (nonatomic ,strong) void (^buttonClickActionBlock)(CBWAlertView *alertView,NSUInteger index);
- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertViewHandler )handler;

- (void)show;
- (void)dismiss;
@end
