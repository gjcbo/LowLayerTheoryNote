//
//  NSObject+HookSwizzing.h
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HookSwizzing)

/**
 交换两个方法的实现

 @param originSelector 原来的方法选择器；方法名
 @param newSelector 新的方法选择器。
 */
+ (void)rb_swizzleOriginSelector:(SEL)originSelector newSelector:(SEL)newSelector;


+ (void)rb_swizzingOriginSelector:(SEL)originSel swizzedSelector:(SEL)swizzedSel;

@end
