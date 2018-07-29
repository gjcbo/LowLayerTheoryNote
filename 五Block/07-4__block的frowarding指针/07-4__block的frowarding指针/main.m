//
//  main.m
//  07-4__block的frowarding指针
//
//  Created by RaoBo on 2018/7/29.
//  Copyright © 2018年 RaoBo. All rights reserved.
//
// clang转C++ 指令
// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-11.0 main.m

#import <Foundation/Foundation.h>

typedef void(^RBBlock)(void);


struct __Block_byref_age_0 {
    void *__isa;
    struct __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};


struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int no;
    struct __Block_byref_age_0 *age; // by ref
};


//
////指向自己的结构体指针
//struct Student {
//    char *name ;
//    struct Student *forwarding;
//    int age;
//    float score;
//};


//关于 __block
/**
 问：__block的作用是什么？有什么使用注意点？
 答：
 一： 是什么？
 1-1 __block 用来解决block内部无法修改auto变量值的问题
 1-2 __block 不能修饰全局变量、静态变量(static) 编译报错。
 1-3 编译器会将 __block包装成一个对象。 在底层就是一个结构体 struct __Block_byref_age_0，有一个isa 指针和捕获的自动变量 age
 
 二 __block 的内存管理问题
 2-1 当block在栈区是 不会对 __block变量产生强引用。
 2-2 当block被copy到堆区时
    2-2-1 会调用 block内部的copy函数
    2-2-2 copy函数内部会调用 _Block_object_assing 函数
    2-2-3 _Block_object_assing函数会对__block 变量形成强应用(retain)
 
 2-3 当 block从堆区移除的时候
    2-3-1 会调用block内部的dispose函数
    2-3-2 dispose函数内部会调用 _Block_object_dispose函数
    2-3-3 _Block_object_dispsoe 会自动释放引用的 ————block变量(release)
 
 
 三 __block 的__forwarding指针问题
 
 struct __Block_byref_age_0 {
 void *__isa;
 struct __Block_byref_age_0 *__forwarding;
 int __flags;
 int __size;
 int age;
 };
 
 被__block 修饰的变量会被包装成一个OC对象也就是上面的结构体。struct  __Block_byref_age_0 结构体
 这个结构体里面有一个 __forwarding 指针指向这个结构体自己。
 
 __Block_byref_age_0 *age = __cself->age; // bound by ref
 
 (age->__forwarding->age) = 30;
 
 访问age成员变量的流程：通过 __block 包装成的结构体指针--->拿到里面的 __forwarding指针,指向该结构体自己。---->再去访问该结构体里面的成员变量   ->age
 
 为什么这么搞这么复杂？
 为了在栈区和堆区都能访问到这个age这个成员变量。
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int no = 20;
        __block int age = 10;
        
        NSObject *object = [[NSObject alloc] init];
        __weak NSObject *weakObject = object;
        
        RBBlock myblock1 = ^{
            age = 30;
            
            NSLog(@"%d",no);
            NSLog(@"%d",age);
            NSLog(@"%p",weakObject);
        };
        
        myblock1();
    
    }
    return 0;
}
