# CBWAlertView
CustomAlertView
#gif

![fade](http://upload-images.jianshu.io/upload_images/874748-7c5538bc7fd05c15.gif?imageMogr2/auto-orient/strip)
![bigToSmall](http://upload-images.jianshu.io/upload_images/874748-6a09e51ebd56629f.gif?imageMogr2/auto-orient/strip)
![smallToBig](http://upload-images.jianshu.io/upload_images/874748-5810d182c482bf87.gif?imageMogr2/auto-orient/strip)
#useage

this is a custom AlertView that can modify the color of messeage/title/button.
also,it offer 3 animation type,they are `fade`/`big to small`/`small to big`

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


###验证不会产生内存泄露

###案例一
- 如果创建一个 View,加在当前的 VC 上

- view, 里面有一个 block,block 会调用当前VC方法

- 当前 VC 释放的时候,会产生内存泄露


![testView 没有干掉(removeFromSuperView)](http://upload-images.jianshu.io/upload_images/874748-56076d69b3d4a03e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![内存泄露](http://upload-images.jianshu.io/upload_images/874748-70626657184dc190.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

tips:这里采用[MLeaksFinder](https://github.com/Zepo/MLeaksFinder.git)检测内存泄露

###案例二

- 如果创建一个 View,加在当前的 VC 上

- view, 里面有一个 block,block 会调用当前VC方法

- 当前 VC 释放前干掉 view, 就不会产生内存泄露


![干掉 testView,就不会内存泄露](http://upload-images.jianshu.io/upload_images/874748-acc323f74e321d29.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


###[CBWAlertView](https://github.com/xeroxmx/CBWAlertView.git) 不会造成循环引用
1.我自己写的 CBWAlertView 是在执行完成之后 removeFromSuperView 的,所以不会造成循环引用

```
- (void)buttonAction:(UIButton *)button{
    
    AlertButtonItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismiss];
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
```

2.而且是加载 window 上的,不是加在 view 上面,更加不会照成循环引用
```
[[[[UIApplication sharedApplication] windows] lastObject] addSubview:self];
```

[demo](https://github.com/xeroxmx/TestLeakDemo.git)

[不会内存泄露验证](http://www.jianshu.com/p/96c1ab863b37)
