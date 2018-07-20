//
//  main.m
//  03
//
//  Created by RaoBo on 2018/7/20.
//  Copyright © 2018年 RaoBo. All rights reserved.
//class 类对象和 meta-class元类对象


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject
{
    int _age;
    int _height;
    int _num;
}
@end

@implementation Person
@end

#pragma mark - 一 class 类对象 &  meta-class 元类对象
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //《一》instance对象
        NSObject *objc1 = [[NSObject alloc] init];
        NSObject *objc2 = [[NSObject alloc] init];
        
        //0x10060db50 0x1006111b0 地址不一样
        //instance 实例对象各是各的,地址都不一样。存放:isa、成员变量的值。
        NSLog(@"%p %p",
              objc1,
              objc2);
        NSLog(@"=======================");
        
        
        
        // 0x7fffa587f140 0x7fffa587f140 0x7fffa587f140 0x7fffa587f140 0x7fffa587f140 地址都一样。
        //《二 》class 对象。 每个类的类对象有且只有一个份。存放:isa指针、superclass指针、成员变量的信息、属性信息、协议、对象方法(因为是共有的,一份就够了。)
        //class方法返回的一直都是class对象。类对象。
        Class objcClass1 = [objc1 class];
        Class objcClass2 = [objc2 class];
        Class objcClass3 = object_getClass(objc1);
        Class objcClass4 = object_getClass(objc2);
        Class objcClass5 = [NSObject class];
        Class objcClass6 = objc_getClass("NSObject");
        NSLog(@"%p %p %p %p %p %p",
              objcClass1,
              objcClass2,
              objcClass3,
              objcClass4,
              objcClass5,
              objcClass6);
        NSLog(@"=======================");
        
        // 《三》 meta-class对象。元类对象。
        //获取元类对象:object_getClass(请传class对象)  如果传的是instance对象(实例对象)返回的是class对象。
        Class objectMetaClass = object_getClass([NSObject class]);
        NSLog(@"%p",objectMetaClass);
        NSLog(@"是不是元类对象:%@",class_isMetaClass(objectMetaClass) ? @"是":@"不是");
        Class objectMetaClass2 = [[[NSObject class] class] class];
        NSLog(@"%p",objectMetaClass2);
        NSLog(@"是不是元类对象:%@",class_isMetaClass(objectMetaClass2) ? @"是" : @"不是");
        
        
        Class testObjc1 = objc_getClass("NSObject");
        NSLog(@"%p",testObjc1);
        Class testObjc2 = objc_getClass("Person");
        NSLog(@"%p",testObjc2);
        
        
        //
//        Class testObjc3 = object_getClass(objectMetaClass);
//        NSLog(@"%@",testObjc3); //NSObject
        
    }
    return 0;
}

/**
 1. Class objc_getClass(const char * aClassName)
 1>传入字符串类名
 2>返回对应的类对象
 
 
 2.Class object_getClass(id obj)
 1> 传入的Objc可能是instance对象、class对象、meta-class对象
 2> 返回值
 a) 如果是instance对象,返回class对象
 b) 如果是class对象,返回meta-class对象
 c)如果是meta-class对象,返回NSObject(基类) 的 meta-class对象
 
 
 3. - (Class)class 、+ (Class)class
 1> 返回:类对象
 
 - (Class) {
    return self->isa;
 }
 
 + (Class) {
    return self;
 }
 //可以在 
 */
