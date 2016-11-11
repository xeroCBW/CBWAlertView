//
//  CBWAlertView.m
//  CBWKit
//
//  Created by 陈博文 on 16/4/29.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWAlertView.h"

static float const kCBWAlertViewCornerRadius  = 10.0;
static float const normalMargin = 20.0;
static float const lrMargin = 17.5;
static float const titleLabelBottomMargin = 10;
static float const titleFont = 17;
static float const messageFont = 13.0;
static float const buttonFont = 17.0;
static float const buttonHeight  = 45.0;
static float const showDuring = 0.25f;
static float const dismisDuring = 0.2f;
static float const delayDuring = 0.0f;
#define separatorMargin 0.5///[UIScreen mainScreen].scale//iphone6+不会消失
#define marginColor [UIColor colorWithRed:196.0/255 green:196.0/255 blue:201.0/255 alpha:1.0]//[UIColor colorWithRed:211.0/255.0 green:219.0/255.0 blue:223.0/255.0 alpha:1.0]//[UIColor groupTableViewBackgroundColor]//211  219 223//[UIColor clearColor]//
#define defaultBlueColor [UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]
#define colorHighLight [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:0.9]
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]


#pragma mark - AlertButtonItem
@interface AlertButtonItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) CBWAlertViewHandler action;
@end
//一定要有实现,要不然不能运行
@implementation AlertButtonItem

@end
#pragma mark - CBWAlertView

@interface CBWAlertView ()
/** 提示框的 title*/
@property (nonatomic ,copy) NSString *title;
/** 提示框的 message*/
@property (nonatomic ,copy) NSString *message;
/** 用来装 buttonItem 的数组*/
@property (nonatomic ,strong) NSMutableArray *items;
@end



@implementation CBWAlertView


- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        self.frame = [UIScreen mainScreen].bounds;
        self.items = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        
        self.alpha = 0.0;
    }
    return self;
    

}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
}


#pragma mark - init
- (void) creatContainerView{
    
    if (self.containerView == nil) {
        
        [self setUpDefaultView];

    }
    
    //重新设置尺寸,增加下面 button 的位置
    [self resizeFrameContainerView:self.containerView];
    
    self.containerView.center = self.center;
    self.containerView.backgroundColor =[UIColor colorWithRed:0.96 green:1.0 blue:1.0 alpha:1.0];// [UIColor colorWithRed:246.0/255 green:246.0/25 blue:246.0/25 alpha:1.0];//[UIColor clearColor];
    [self addSubview:self.containerView];
}

- (void)setUpDefaultView{
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 270;
    
    NSString *title = self.title;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:titleFont];
    titleLabel.textColor = self.titleTextColor?self.titleTextColor:[UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.frame = CGRectMake(lrMargin, 0, w - 2*lrMargin, titleSize.height);
    titleLabel.center = CGPointMake(w * 0.5, normalMargin + titleSize.height * 0.5);
    
    NSString *message = self.message;
    // 初始化label
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = self.messageTextColor?self.messageTextColor:[UIColor blackColor];
    // label获取字符串
    messageLabel.text = message;
    messageLabel.backgroundColor = [UIColor clearColor];
    // label获取字体
    messageLabel.font = [UIFont systemFontOfSize:messageFont];
    // 根据获取到的字符串以及字体计算label需要的size
    CGSize messageSize = [message boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageLabel.font} context:nil].size;
    // 设置无限换行
    messageLabel.numberOfLines = 0;
    
    if ([self isBlankString:message]) {
        messageSize.height = 0 - titleLabelBottomMargin;//置为空,没有默认也会有一行
    }else{
        //不做处理
    }
    messageLabel.frame = CGRectMake(lrMargin, normalMargin + titleSize.height + titleLabelBottomMargin, w - 2*lrMargin, messageSize.height);
//    NSLog(@"%f====%f",messageSize.height,messageSize.width);
    
    //h需要改变
    CGFloat  h = [self isBlankString:message]?normalMargin + titleSize.height + normalMargin:normalMargin + titleSize.height + titleLabelBottomMargin + messageSize.height + normalMargin;
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.containerView.layer.cornerRadius = kCBWAlertViewCornerRadius;
    self.containerView.layer.masksToBounds = YES;
    
    UIView *backgroupView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    backgroupView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:backgroupView];
    
    [self.containerView addSubview:titleLabel];
    [self.containerView addSubview:messageLabel];

}

- (void)addButtonsToView: (UIView *)container
{
    if (self.items.count == 0) { return; }
    
    CGFloat buttonWidth = container.bounds.size.width / self.items.count;
   
    //设置横线
    CGRect lineFrame = CGRectMake(0,container.bounds.size.height - buttonHeight - separatorMargin, container.bounds.size.width, separatorMargin);
    UIView *lineview = [[UIView alloc]initWithFrame:lineFrame];
    lineview.backgroundColor = marginColor;
    [container addSubview:lineview];
    
    CGRect frame = CGRectMake(0,container.bounds.size.height - buttonHeight, container.bounds.size.width, buttonHeight);
    UIView *buttonView = [[UIView alloc]initWithFrame:frame];
    buttonView.backgroundColor = [UIColor whiteColor];
    [container addSubview:buttonView];
    
    for (int i=0; i<self.items.count; i++) {
        
        AlertButtonItem *item = self.items[i];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setTitle:item.title forState:UIControlStateNormal];
        UIColor *itemColor = item.color?item.color:defaultBlueColor;
        [closeButton setTitleColor:itemColor forState:UIControlStateNormal];
        [closeButton setTitleColor:itemColor forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        closeButton.backgroundColor = [UIColor clearColor];
        [closeButton setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [closeButton setBackgroundImage:[self imageWithColor:colorHighLight] forState:UIControlStateHighlighted];
        if (i == 0) {
            [closeButton setFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight)];
        }else{
            [closeButton setFrame:CGRectMake(i * buttonWidth + separatorMargin, 0, buttonWidth - separatorMargin, buttonHeight)];
            
            //增加横线
            UIView *verticalView = [[UIView alloc]init];
            verticalView.frame = CGRectMake(i * buttonWidth, 0,separatorMargin, buttonHeight);
            verticalView.backgroundColor = marginColor;
            [buttonView addSubview:verticalView];
        }
        closeButton.tag = i;
        [closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:closeButton];
    }
}


- (void)resizeFrameContainerView:(UIView *)containerView{
    
    CGRect frame = containerView.frame;
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height + buttonHeight + separatorMargin);
    containerView.frame = frame;
    
}

#pragma mark - show && dismiss

-(void)show{
    
    [self creatContainerView];
    [self addButtonsToView:self.containerView];
    

    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    //如果发现键盘windows 出现,就选键盘下一个 windows
    if ([window isKindOfClass:[NSClassFromString(@"UIRemoteKeyboardWindow") class]]) {
        
        window = [[UIApplication sharedApplication].windows objectAtIndex:([UIApplication sharedApplication].windows.count -2)];
    }
    
    [window addSubview:self];
    
    if (self.animationType == AnimationTypeBigToSmall) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
        
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[ @(1.2), @(1.1), @(1.0) ];
        k.keyTimes = @[ @(0.0), @(0.5), @(0.9) ];
        k.calculationMode = kCAAnimationLinear;
        [self.containerView.layer addAnimation:k forKey:@"ShowAlertView"];
        
        return;
        
    }else if(self.animationType == AnimationTypeSmallToBig){
        
        self.containerView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        
    }
    
    [UIView animateWithDuration:showDuring
                          delay:delayDuring options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.alpha = 1.0f;
                         
                     } completion:nil];
}

- (void)dismiss{

    [UIView animateWithDuration:dismisDuring
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 0.0;
                         
                     } completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         
                         [self removeFromSuperview];
                     }];
    

}

#pragma mark - public

- (void)addButtonWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertViewHandler)handler{
  
    AlertButtonItem *item = [[AlertButtonItem alloc] init];
    item.title = title;
    item.color = color;
    item.action = handler;
    [self.items addObject:item];

}


#pragma mark - private

- (void)buttonAction:(UIButton *)button{
    
    AlertButtonItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismiss];
}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - setter && getter
-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end
