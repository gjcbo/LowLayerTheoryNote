//
//  main.m
//  Block-02变量捕获
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//
// clang --->c++指令 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m

#import <Foundation/Foundation.h>
#import "Person.h"


// 转成C++后的 block的底层结构。
//struct __main_block_impl_0 {
//    struct __block_impl impl;
//    struct __main_block_desc_0* Desc;
//    int *age; // static 修饰的局部变量会捕获。通过指针访问
//    float height; //auto 自动自动变量会不会。 值传递。在block尾部修改不会影响到block内部的值变化。
//    全局变量不会捕获。直接访问。
//    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int *_age, float _height, int flags=0) : age(_age), height(_height) {
//        impl.isa = &_NSConcreteStackBlock;
//        impl.Flags = flags;
//        impl.FuncPtr = fp;
//        Desc = desc;
//    }
//};

//使用
#pragma mark - 主题:block变量捕获机制
/**
 
 为了保证block内部能够正常访问外部变量。block有个变量捕获机制。
 变量类型          捕获到block内部          访问方式
 局部变量 auto          ✅                  值传递
 局部变量 static        ✅                  地址访问
 
 
 全部变量                ❌                  直接访问
 */
//全部变量全局可以访问。
//自动变量:局部自动变量   auto int age = 10; auto默认是隐藏的 ，用完了就自动释放了，自动变量。
//static 也是可以修饰局部变量，//static 修饰的局部变量捕获后就编程 int *age; ---》通过指针进行访问。在外部修改他的值会导致



//全局变量不会被block捕获，因为全局可访问。
int globalVar = 100;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
    }
    return 0;
}

#pragma mark -  一 变量作用域
//void localVariableActionScope(void) {
//    //常识回顾:局部变量作用域，如果把 int age 写在 {} 里面，在 “}“ 后面就不能在访问了，局部变量出作用域自动销毁，出作用域就无法访问了。这里直接编译报错。 Use of undeclared identifier 'age'
//    {
//        int age = 10;
//    }
//    age = 40;
//}


#pragma mark - 二 变量捕获。
void variableCapture() {
    static int age = 10;
    float height = 45.8;
    
    void(^block2)(void) = ^{
        NSLog(@"age:%d ====heigh:%.2f === globalVar:%d",age, height,globalVar);
    };
    
    //1. static 修饰的局部变量被block捕获后 捕获的结果是int * 型，通过地址访问 所以在block调用前修改值会变化
    
    age = 40;
    height = 66.66;
    globalVar = 8888;
    
    block2();
}

#pragma mark - 三 猜测变量的存储区域:根据已知推测未知
void test4(void){
    int num1 = 10;
    static int staticNum = 30;
    //      测试  变量存储位置
    NSLog(@"数据区: %p",&globalVar); //数据区:全局变量、static修饰的变量(局部变量+全局变量)
    NSLog(@"栈区:%p",&num1); //局部变量存储在栈区
    NSLog(@"堆区%p",[[Person alloc] init]); //alloc、malloc 出来的变量存放在堆区
    NSLog(@"%p", &staticNum);  //根据打印的地址比较可以推测--》在堆区。
}


