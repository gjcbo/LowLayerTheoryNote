//
//  Person+Test.m
//  01-给Category添加属性
//
//  Created by RaoBo on 2018/7/25.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person+Test.h"
#import <objc/runtime.h>

@implementation Person (Test)

// 分类中写@property. 系统不会帮你实现setter和getter方法。
// 在类里面同时重写setter和getter会报错,但是在Category中不会,从侧面说明了分类中写@property 不会生成setter、getter方法。---》在Category中写属性无效
// 通过关联对象来实现给分类添加属性功能。
// 关于 key的问题。

#pragma mark - Key的第一种写法
- (void)setWeight:(float)weight {
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_ASSIGN);
}

- (float)weight {
//    return [objc_getAssociatedObject(self, @selector(weight)) floatValue];

    //关于 _cmd:
    //每个方法内部都会有两个隐式参数：self(方法调用者)、 _cmd(方法名)
    NSLog(@"_cmd: %@",NSStringFromSelector(_cmd)); //weight 就是getter方法。
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}



#pragma mark - Key的第二种写法
#define kRBWeight @"weight"

//- (void)setWeight:(float)weight {
//    objc_setAssociatedObject(self, kRBWeight, @(weight), OBJC_ASSOCIATION_ASSIGN);
//}
//- (float)weight {
//   return [objc_getAssociatedObject(self, kRBWeight) floatValue];
//}

#pragma mark - Key的第三种写法
//static const void *RBWeightKey;
///// 给全局变量添加 static 将其作用域限制在当前文件内使用。外界即便使用extern修饰也无法访问。
////  另外static修饰的变量(无论是局部变量还是全局变量都是存放在 数据区的。)
//
//- (void)setWeight:(float)weight {
//    objc_setAssociatedObject(self, &RBWeightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
//}
//- (float)weight {
//    return [objc_getAssociatedObject(self, &RBWeightKey) floatValue];
//}



@end
