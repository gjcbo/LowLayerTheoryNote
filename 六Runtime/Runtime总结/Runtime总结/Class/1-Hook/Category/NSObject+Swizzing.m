//
//  NSObject+Swizzing.m
//  runtime消息转发
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  swizzle： OC的方法混写。

#import "NSObject+Swizzing.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzing)
+ (void)rb_swizzingOriginSelector:(SEL)originSel swizzledSelector:(SEL)swizzledSel {
    Class cls = [self class];
    
    //原来的方法
    Method originMethod = class_getInstanceMethod(cls, originSel);
    //要交换的方法
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    //给类的原方法添加新的方法实现。

    /**
     参数1：类名
     参数2：原始方法
     参数3：新方法的实现
     参数4：新方法的TypeEncoding
     */
    BOOL isAddSuccess = class_addMethod(cls, originSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (isAddSuccess) { //添加方法成功，就替换原方法的实现
        class_replaceMethod(cls, originSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else { //反之直接交换方法的实现。一般会先走这里。✅
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

//+ (void)rb_swizzingOriginSelector:(SEL)originSel swizzedSelector:(SEL)swizzedSel {
//
//    Class cls = [self class];
//
//    //原来的方法
//    Method originMethod = class_getInstanceMethod(cls, originSel);
//
//    Method swizzedMethod = class_getInstanceMethod(cls, swizzedSel);
//
//   BOOL isAdd = class_addMethod(cls, originSel, method_getImplementation(swizzedMethod), method_getTypeEncoding(swizzedMethod));
//
//    if (isAdd) {
//        class_replaceMethod(cls, originSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
//    }else {
//
//        method_exchangeImplementations(originMethod, swizzedMethod);
//    }
//}

@end
