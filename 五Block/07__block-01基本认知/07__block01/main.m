//
//  main.m
//  07__block01
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

//基本认知
//1. __block用于解决block内部无法修改的auto变量值的问题
//2.使用 __block 修饰的变量会被包装成OC对象
//3.__block 不能修饰全局变量。static修饰的变量。


typedef void(^RBBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
       __block int age = 10;
        RBBlock block1 = ^{
            NSLog(@"age is :%d",age);
        };
        
        age = 200;
        block1();
    }
    return 0;
}
