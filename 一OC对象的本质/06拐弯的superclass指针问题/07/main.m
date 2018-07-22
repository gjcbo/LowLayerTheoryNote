//
//  main.m
//  07
//
//  Created by RaoBo on 2018/7/21.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  拐弯的superclass 指针 问题

#import <Foundation/Foundation.h>
#import <objc/message.h>

#import "NSObject+Test.h"

@interface Person : NSObject
+ (void)test;
@end
@implementation Person
//+ (void)test {
//    NSLog(@"+[Person test] %p 第:%d行",self,__LINE__);
//}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        Person *per = [Person class];
    
//         问题描述: 把 Person 的 + (void)test的实现和NSObject的  + (void)test 都注释掉,只实现 NSObject 的 -  (void)test{}, 依然可以实现调用。
        // 以前的认知: 类对象怎么可以调用 -号方法、对象方法？
        // 现在     : 对象调方法就是发消息, 通过isa、superclass指针一层一层往上找,找对应的方法的实现。找到就调用，知道NSObject还是找不到--->nil --》unrecognized selector sent to xxxxx 崩溃了。
        // 在发消息的时候像这样 objc_msgSend(对象,@selector(test))。他是根据方法名去找方法的实现,这个时候根本就无法区分-,+号方法。只不过就是根据isa、superclass一层一层往上找，找到就调用。找不到就崩溃。
        
//isa-->superclass -->superclass-->......  ---> Root class(基类的类对象) ---->nil

        [Person test];
        // 发消息。
        ((void (*)(id, SEL))objc_msgSend) ([Person class],@selector(test));
                
        [NSObject test];
        //发消息
        ((void (*)(id, SEL))objc_msgSend) ([NSObject class],@selector(test));
    }
    return 0;
}
