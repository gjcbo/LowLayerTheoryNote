//
//  UIView+Hook.m
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "UIView+Hook.h"
#import <objc/runtime.h>

@implementation UIView (Hook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method systemMethod = class_getInstanceMethod([self class], @selector(setBackgroundColor:));
        
        Method myMethod = class_getInstanceMethod([self class], @selector(rb_setBackgroundColor:));
        method_exchangeImplementations(systemMethod, myMethod);
    });
}

- (void)rb_setBackgroundColor:(UIColor *)color {
    
    //🌰：hook系统方法，如果是红的就换成绿色的
    if (color == [UIColor redColor]) {
        [self rb_setBackgroundColor:[UIColor greenColor]];
        NSLog(@"方法被交换");
    }else { //正常颜色 
        [self rb_setBackgroundColor:color];
    }
}
@end
