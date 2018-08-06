//
//  NSArray+Hook.m
//  runtime消息转发
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  利用runtime解决数组字典的崩溃问题: https://www.jianshu.com/p/080a238c62b9
//  优点 ： 防止奔溃。
//  缺点 ： 不好定位bug。
#import "NSArray+Hook.h"
#import <objc/runtime.h>
#import "NSObject+Swizzing.h"

//'*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'

@implementation NSArray (Hook)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls1 = objc_getClass("__NSArrayM");
        [cls1 rb_swizzingOriginSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(rb_insertObject:atIndex:)];
    });
}

- (void)rb_insertObject:(id)objc atIndex:(NSInteger)index {
    if (objc == nil) {
        NSLog(@"空的：*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil");
    }else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    }else {
        [self rb_insertObject:objc atIndex:index];
    }
}

@end

