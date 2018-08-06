//
//  RBPerson.m
//  01-动态方法解析
//
//  Created by RaoBo on 2018/8/6.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  

#import "RBPerson.h"
#import <objc/runtime.h>

@implementation RBPerson

#pragma mark - 方式四  ------------------------------
//调用C语言函数
void c_other(id self, SEL _cmd) {
    
    NSLog(@"%@--%@",self, NSStringFromSelector(_cmd));
}




//打印结果：i40@0:8@16q24d32
/**结果分析：
 分开来看就是这样的
 i40  @0  :8  @16  q24  d32
 第一段：i40 表示返回值是int类型。所有参数一共是40个字节。
 40个字节是怎么算的。每个方法内部都有两个默认参数。receive消息的接收者(一般都是self)、方法名(SEL _cmd)
 id self, SEL _cmd, NSString * name, NSInteger age, CGFloat height
 self, _cmd, name, age, height
 8   , 8   , 8   , 8  , 8      =====> 40个字节。
 
 第二段：@0 第一个参数是对象类型。从0 开始
 第三段：:8 第二个参数是方法选择器。 从8开始
 第四段：@16 第三个参数是 对象类型。从16开始
 第五段：q2 第四个参数是 long long 类型， 从24开始
 第五段：d32 第五个参数是 double类型。 从32开始。
 */
//总结结论：runtime的typeEncoding规则如上，能看懂就行。

- (int)rb_testName:(NSString *)name age:(NSInteger)age height:(CGFloat)height {
    NSLog(@"关于编码类型的测试 什么也么也不干");
    return 10;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == @selector(test)) {
        
        //IMP 方法的地址== 函数的地址。
        //直接把函数的地址传进去。 (IMP)c_other，做一下类型转换，消除警告
        //方法编码 "v16@0:8"    v表示void没有返回值。16有两个参数,都是指针所以占16个字节。第一个参数编码：@0 对象类型从0开始。第二个参数编码：:8 冒号表示方法选择器，从第八个地址开始。
        //想象计算结构体的占用的字节数。
        class_addMethod(self, sel, (IMP)c_other, "v16@0:8");
        
        Method testMethod = class_getInstanceMethod(self, @selector(rb_testName:age:height:));
        
        NSLog(@"编码类型是:%s",method_getTypeEncoding(testMethod));
        
    }
    
    return [super resolveInstanceMethod:sel];
}





#pragma mark - 方式三 ------------------------------
//- (void)other {
//    NSLog(@"%s--%d",__func__,__LINE__);
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if(sel == @selector(test)) {
//
//        Method otherMethod = class_getInstanceMethod(self, @selector(other));
//        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:sel];
//}



#pragma mark - 方式二 ------------------------------
//typedef struct objc_method *Method;
//struct objc_method = method_t 
//struct method_t {
//    SEL sel;
//    char * types;
//    IMP imp;
//};
//
//
//- (void)other {
//    NSLog(@"%s--%d",__func__,__LINE__);
//}
//
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if(sel == @selector(test)) {
//
//        struct method_t * otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//
//        NSLog(@"方法名:%s,  编码类型:%s, 方法的实现的地址:%p",otherMethod->sel, otherMethod->types, otherMethod->imp);
//        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);
//
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:sel];
//}


#pragma mark - 方式一 ------------------------------
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if(sel == @selector(test)) {
//        //获取其他方法
//        Method otherMethod = class_getInstanceMethod(self, @selector(other));
//
//        //动态添加 -(void)test方法的实现
//        //对象方法添加到类对象上。
//        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
//
//        return YES; //其实你传NO，也没问题。通过查看底层源码，他根本就没用这个值。
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark - 笔记
/**
 消息机制第二阶段：动态方法解析 + (BOOL)resolveXXXXXMethod:(SEL)sel
 1.可以认为Method和 方法列表的中的 method_t是一样的。
 
 struct method_t {
    SEL sel;  //方法名
    char * types; //类型编码
    IMP imp; //方法的实现
 };

 2. + (BOOL)resolveXXXXXXMethod:(SEL)sel 的调用时机
 消息发送阶段走完了：通过isa指针、superclass指针还是找不到方法的实现。
 就会进入 动态方法解析阶段。调用 + (BOOL)resolveXXXXMethod 方法
 可以在这里做的事情：可以通过runtime动态的添加方法的实现，解决方法找不到造成的奔溃：unrecognize selector xxxx
 
 
 如果第一阶段：消息发送，通过isa、superclass 指针可以找到方法的实现就直接调用，就不会来到这里了。
 
 */
@end
