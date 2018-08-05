//
//  NSObject+HookSwizzing.m
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//   https://github.com/macios/runTime
//  利用runtime解决数组字典的崩溃问题: https://www.jianshu.com/p/080a238c62b9

//通用交换 IMP 写法

#import "NSObject+HookSwizzing.h"
#import <objc/runtime.h>

@implementation NSObject (HookSwizzing)


+ (void)rb_swizzleOriginSelector:(SEL)originSelector newSelector:(SEL)newSelector {
    Class cls = [self class];
    
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    
    //方法的实现IMP。
    IMP newMethodIMP = method_getImplementation(newMethod); //IMP
    const char *newTypeEncode = method_getTypeEncoding(newMethod);//方法编码

    BOOL isAddMethod = class_addMethod(cls, newSelector, newMethodIMP, newTypeEncode);
    
    //class_replace 和 method_exchange的区别
    if (isAddMethod) {
        
        //替换原来的方法
        IMP originMethodIMP = method_getImplementation(originMethod);
        const char *originTypeEncod = method_getTypeEncoding(originMethod);
        class_replaceMethod(cls, originSelector, originMethodIMP, originTypeEncod);
    }else {
        
        method_exchangeImplementations(originMethod, newMethod);
    }
}


+ (void)rb_swizzingOriginSelector:(SEL)originSel swizzedSelector:(SEL)swizzedSel {
    
    Class cls = [self class];
    
    //原来的方法
    Method originMethod = class_getInstanceMethod(cls, originSel);
    
    Method swizzedMethod = class_getInstanceMethod(cls, swizzedSel);
    
    BOOL isAdd = class_addMethod(cls, originSel, method_getImplementation(swizzedMethod), method_getTypeEncoding(swizzedMethod));
    
    if (isAdd) {
        class_replaceMethod(cls, originSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else {
        
        method_exchangeImplementations(originMethod, swizzedMethod);
    }
}

@end
