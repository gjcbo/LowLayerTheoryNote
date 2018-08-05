//
//  NSArray+Hook.m
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//
//根据崩溃信息来写hook
/**
 //reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'\
 
 reason: '-[__NSCFArray objectAtIndex:]: index (-1 (or possibly larger)) beyond bounds (0)'

 
 */

#import "NSArray+Hook.h"
#import "NSObject+HookSwizzing.h"
#import <objc/runtime.h>

@implementation NSArray (Hook)

+ (void)load {
    
    //确保只执行一次。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Class cls1 = object_getClass(@"__NSArrayM");
        Class cls1 = objc_getClass("__NSArrayM");
        
//        [cls1 rb_swizzleOriginSelector:@selector(insertObject:atIndex:) newSelector:@selector(rb_insertObject:atIndex:)];
        [cls1 rb_swizzingOriginSelector:@selector(insertObject:atIndex:) swizzedSelector:@selector(rb_insertObject:atIndex:)];
        
        Class cls2 = objc_getClass("__NSCFArray");
        
        [cls1 rb_swizzingOriginSelector:@selector(objectAtIndex:) swizzedSelector:@selector(rb_objectAtIndex:)];
    });
}

#pragma mark - hook 钩子
- (void)rb_insertObject:(id)obj atIndex:(NSInteger)index {
    if (obj == nil) {
        NSLog(@"object cannot be nil 第:%d行 %s",__LINE__,__func__);
    }else if (self.count > index) {
        NSLog(@"index is invalid 第:%d行 %s",__LINE__,__func__);
    }else {
        [self rb_insertObject:obj atIndex:index];
    }
}

- (void)rb_objectAtIndex:(NSInteger)index {
    if (index<0) {
        NSLog(@"-[__NSCFArray objectAtIndex:]: index (-1 (or possibly larger)) beyond bounds (0)");
    }else if(index > self.count) {
        NSLog(@"数组越界");
    }else {
        [self rb_objectAtIndex:index];
    }
}

@end
