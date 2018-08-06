//
//  main.m
//  01-动态方法解析
//
//  Created by RaoBo on 2018/8/6.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  动态方法解析

#import <Foundation/Foundation.h>
#import "RBPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        RBPerson *person = [[RBPerson alloc] init];
        //需求：没有 -(void)test方法的实现，不希望程序崩溃。
        [person test];
    }
    return 0;
}





#pragma mark - 笔记
/**
 Person对象有一个 -(void)test 方法，没有写实现，运行后直接报经典错误：方法找不到。
 利用runtime的消息机制原理。就是不写 - (void)test 的方法实现，就是让它方法找不到，但是还要保证程序崩溃。
 
 
 消息机制分三个阶段：消息发送阶段、动态方法解析阶段 、消息转发阶段。
 
 1.先回顾：isa指针、superclss、OC方法调用流程
 2. unrecognized selector sent  to xxxxxx 奔溃问题解决。
 instance(实例)对象方法调用流程：通过isa 找到 class(类)对象。如果没有，就通过superclass指针去父类的class(类)对象中找...... 直到 基类的class(类)对象中，还是找不到就会抛出异常：unrecognized selector  xxxx  方法找不到。奔溃。此时消息机制的第一阶段结束。将会进入第二阶段：动态方法解析，再给一次机会，去找方法的实现，
 
 3. + (BOOL)resolveInstanceMethod
 注意这是一个加号方法。
 什么时候会被调用： 消息发送阶段，如果找不到方法的实现，就会进入动态方法解析。注意这是一个类方法（+）
 找到了方法的实现，就不会来这里。
 
 */
