//
//  Person.m
//  KVC基本使用
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person


#pragma mark - 为什么通过KVC进行赋值 会触发 KVO监听。
/**
 使用KVC 会触发下面两个方法。(手动触发KVO也是通过触发下面两个方法)
 - (void)willChangeValueForKey:(NSString *)key
 
 - (void)didChangeValueForKey:(NSString *)key
 
didChangeValueForKey 方法内部会调用监听器的方法。 属性值发生变化--->触发KVO
 */
- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey ");
}


- (void)didChangeValueForKey:(NSString *)key {
    
    NSLog(@"didChangeValueForKey - begin");
    
    [super didChangeValueForKey:key];
    
    NSLog(@"didChangeValueForKey - end");
}

@end
