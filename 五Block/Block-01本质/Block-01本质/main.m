//
//  main.m
//  Block-01本质
//
//  Created by RaoBo on 2018/7/26.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

//文件:
//        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String]
//行数 __LINE__
//参数: [[NSString stringWithFormat:FMT, ##__VA_ARGS__] UTF8String]


//#ifdef DEBUG
//#define NSLog(FMT, ...) fprintf(stderr, "%s:%d\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,[[NSString stringWithFormat:FMT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FMT, ...) nil
//#endif


/***
 block:封装了函数调用,和函数调用环境的OC对象
 函数调用   : 存储了函数的地址,拿到地址就可以进行调用
 函数调用环境: eg:函数的参数， 外面定义一个 int age = 10 ， 可以在block里面使用. 这就可以理解为函数调用环境。
 
 clang --> C++ 指令
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m
 
 
 //个人理解Block的底层结构分4部分    main1.cpp 中已经做了详细描述
 第一部分: __block_impl 结构体,保存了1.isa指针 和 2.FuncPtr指针(最终的调用就是通过FuncPtr来进行调用的) 3.其他信息.....
 
 第二部分 : block的描述信息 。desc
 
 第三部分 : block捕获的自动变量
 
 第四部分:  block {} 代码块转换成的 C/C++函数。
 把函数的地址传给 FuncPtr(函数指针)实现block的调用。
 */



#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        int age = 10;
        void(^block)(void) = ^(void) {
            NSLog(@"这是一个block");
            NSLog(@"这是一个block");
            NSLog(@"----age:%d",age);
        };
        
        age = 20;
        block();
        
    }
    return 0;
}

//block 的 语法
//void test1() {
////    eg1:
//            ^{
//                NSLog(@"这是一个block");
//                NSLog(@"这是一个block");
//            }();
//
////    eg2:
////    语法格式: 返回值类型 (^block名字)(参数列表) = ^返回值类型(参数列表) { 代码块}
//            int (^block)(void) = ^int (void){
//                return 3;
//            };
//            int res =  block();
//            NSLog(@"%d",res);
//}

