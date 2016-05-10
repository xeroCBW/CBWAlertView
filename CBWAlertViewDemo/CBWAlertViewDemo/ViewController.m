//
//  ViewController.m
//  CBWAlertViewDemo
//
//  Created by 陈博文 on 16/5/4.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "CBWAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 *  透明度渐变
 */
- (IBAction)fadeAction:(id)sender {
    
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"标题" andMessage:@"内容.... message...."];
//    view.animationType = AnimationTypeBigToSmall;
    //设置 title 和 message的颜色,可以不设置默认为黑色
    view.titleTextColor = [UIColor redColor];
    view.messageTextColor = [UIColor greenColor];
    
    [view addButtonWithTitle:@"取消" color:[UIColor lightGrayColor] handler:^(CBWAlertView *alertView) {
        NSLog(@"取消按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    //设置按钮的颜色和标题
    UIColor *color = [UIColor colorWithRed:0 green:118.0/255.0 blue:255.0/255.0 alpha:1.0];
    [view addButtonWithTitle:@"确定" color:color handler:^(CBWAlertView *alertView) {
        NSLog(@"确定按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    [view show];
   

}

/**
 *  从大变成小进来(系统效果)
 */
- (IBAction)bigToSmallAction:(id)sender {
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"标题" andMessage:@"内容.... message...."];
    view.animationType = AnimationTypeBigToSmall;
    //设置 title 和 message的颜色,可以不设置默认为黑色
//    view.titleTextColor = [UIColor redColor];
//    view.messageTextColor = [UIColor greenColor];
    
    [view addButtonWithTitle:@"取消" color:nil handler:^(CBWAlertView *alertView) {
        NSLog(@"取消按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    //设置按钮的颜色和标题
    
  
    
    [view addButtonWithTitle:@"确定" color:nil handler:^(CBWAlertView *alertView) {
        NSLog(@"确定按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    [view show];
}

/**
 *  从小变成大进来
 */
- (IBAction)smallToBigAction:(id)sender {
    
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"标题" andMessage:@"内容.... message...."];
        view.animationType = AnimationTypeSmallToBig;
    //设置 title 和 message的颜色,可以不设置默认为黑色
    view.titleTextColor = [UIColor redColor];
    view.messageTextColor = [UIColor greenColor];
    
    [view addButtonWithTitle:@"取消" color:[UIColor lightGrayColor] handler:^(CBWAlertView *alertView) {
        NSLog(@"取消按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    //设置按钮的颜色和标题
    UIColor *color = [UIColor colorWithRed:0 green:118.0/255.0 blue:255.0/255.0 alpha:1.0];
    [view addButtonWithTitle:@"确定" color:color handler:^(CBWAlertView *alertView) {
        NSLog(@"确定按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    [view show];

}

- (IBAction)systemDefault:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"系统中自带" message:@"这里面需要填详细信息的哦" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}



@end
