# CBWAlertView
CustomAlertView
#gif



#useage

this is a custom AlertView that can modify the color of messeage/title/button.
also,it offer 3 animation type,they are fade/big to small/small to big

here are examples:

```
/**
 *  透明度渐变
 */
- (IBAction)fadeAction:(id)sender {
    
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"标题" andMessage:@"内容.... message...."];

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

```

more usage please view the demo

[CBWAlertViewDemo](https://github.com/xeroxmx/CBWAlertView.git)