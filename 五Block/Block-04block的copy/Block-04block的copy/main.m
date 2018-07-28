//
//  main.m
//  Block-04block的copy
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBPerson.h"


/**
 在ARC环境下,编译器会自动将栈上的block进行一次copy操作,拷贝到堆区，比如以情况
 block作为函数返回值时
 将block赋值给__strong指针时
 block 作为Cocoa API 方法名中有useingBlock的方法参数时
 block 作为GCD API的方法的参数时。
 
 */
#pragma mark - 三
//
//int main(){
//
//    return 0;
//}



#pragma mark - 二 ARC 将block赋值给__strong指针时 会进行copy操作
/**
 第一个问题:什么叫被强指针指向。
 ARC下默认所有指针都是强指针。 个人理解:一个对象(block也是一个OC对象) 只要使用了=号进行赋值，可以认为被强指针指向。
 RBBlock block = ^{ };
 void(^block2 )(void) = ^{};
 
 前提:ARC
 ARC打印结果 1. __NSStackBlock__， 2.-[RBPerson dealloc]--15
 MRC打印结果 1. __NSStackBlock__， 2. RBPerson 对象不会死。
 
 结论:1.ARC下 block被强指针指向，会自动进行copy操作。
 2.ARC系统自动做了内存管理。自动在合适的时机释放内存。
 */
typedef void(^RBBlock)(void);
int main() {
    //注意是ARC环境。
    int a = 100;
    //强指针指向。
    RBBlock block = ^{
        NSLog(@"a:%d=====",a);
    };
    NSLog(@"%@",[block class]);

    //强指针指向。
    void(^block2 )(void) = ^{
        NSLog(@"a:%d=====",a);
    };
    block2();
    NSLog(@"%@",[block2 class]);

    //这可以认为强指针 p 指向了 RBPerson 对象。
    RBPerson *p = [[RBPerson alloc] init];
    NSLog(@"p.age = %d",p.age);
    
    
    //没有强指针指着的
    NSLog(@"%@",[^{
        NSLog(@"a:%d=====",a);
    } class]); //__NSStackBlock__
    
    
    
    
    NSArray *arr = @[];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}





#pragma mark - 一 MRC下block作为方法返回值问题-2
//block作为函数返回值时 ARC下会自动进行copy操作、
//
//typedef void(^RBBlock)(void);
//
//RBBlock myblock()
//{
//    //常识:访问了auto变量的block是stackblock。
//    //栈区block随时被释放。
//    int age  = 10;
//
//    //MRC 这样写，编译报错  ❌ Returning block that lives on the local stack
//    //ARC ✅ 没问题。从侧面可以推出在ARC环境下block作为返回值会自动进行copy
//    return ^{
//      NSLog(@"---------%d",age);
//    };
//}
//
//int main() {
//
////block作为函数的返回值
//    RBBlock block = myblock();
//    block();
//}





#pragma mark - 一 MRC下block作为方法返回值问题、
/**
 {
//如果是MRC下这样下回直接奔溃
//如果是ARC则没有问题:因为在ARC下block作为方法的返回值的时候，编译器会对block自动进行一次copy。
typedef void(^RBBlock) (void);
RBBlock myBlock() {
  
    int num1 = 10;
    RBBlock block = ^{
        NSLog(@"-------%d",num1);
    };
    //因为使用了auto变量，所以这是一个StackBlock变量。栈区内存出变量作用域会自动释放。
    NSLog(@"%@",[block class]); //__NSStackBlock__
    
    
    //此时将栈区的block作为方法返回值,随时有可能被销毁，直接奔溃。野指针问题(内存已经被销毁还去访问直接奔溃)
    //解决办法: 返回的时候加上copy 拷贝到堆区,保住他的命。
    //疑问:不明白的是:1.为什么这样写不行。    [block copy]; return block;
    
    return [block copy];
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
   
        RBBlock block = myBlock();
        
        block();
        NSLog(@"%@",[block class]);
    }
    return 0;
}
 
 }
 */



