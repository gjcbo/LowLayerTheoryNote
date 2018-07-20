//
//  main.m
//  InterView-01
//
//  Created by RaoBo on 2018/7/19.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

struct NSObject_IMPL {
    Class isa;
};

struct RBStudent_IMPL {
    struct NSObject_IMPL NSObject_IVARS; // 8
    int _no; // 4
    int _age; // 4
    double _height; // 8
}; // 24
//计算结构体所占用内存大小:内存对齐:结构体内存大小必须最大成员所占字节的倍数。

//一个Person对象、一个Student 占用多少内存空间？
@interface RBStudent : NSObject
{
    // 添加 public 才可以通过 stu ->_age = 5; 进行赋值和访问
    @public
    int _no;
    int _age;
    double _height;
}
@end
@implementation RBStudent
@end

//
struct Test1 {
    int a; // 4
    int b; // 4
    char c; // 1
}; // 12



struct Test2 {
    int a; // 4
    double b; // 8
    char c; // 1
};// 24


struct Test3 {
    double a; // 8
    int b; // 4
    char c; // 1
}; // 16



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"%zd",sizeof(struct Test1 )); // 12
        NSLog(@"%zd",sizeof(struct Test2 )); // 24
        NSLog(@"%zd",sizeof(struct Test3 )); // 16 
        
//
//        RBStudent *stu = [[RBStudent alloc] init];
//        stu->_no = 4;
//        stu->_age = 8;
//        stu->_height = 110.0;
//
//        NSLog(@"%zd",class_getInstanceSize([RBStudent class]));
//        NSLog(@"%zd",malloc_size((__bridge const void *)stu));
//
//
//        struct RBStudent_IMPL *stuImpl = (__bridge struct RBStudent_IMPL *)stu;
//        NSLog(@"_no:%d _age:%d _height:%f",stuImpl->_no,stuImpl->_age,stuImpl->_height);
        
    }
    return 0;
}
