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

//typedef struct objc_method *Method;
//struct objc_method = method_t 
struct method_t {
    SEL sel;
    char * types;
    IMP imp;
};


- (void)other {
    NSLog(@"%s--%d",__func__,__LINE__);
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if(sel == @selector(test)) {

        struct method_t * otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
        
        NSLog(@"方法名:%s,  编码类型:%s, 方法的实现的地址:%p",otherMethod->sel, otherMethod->types, otherMethod->imp);
        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}



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
