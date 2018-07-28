//
//  main.m
//  07__block-02底层结构
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  解决 __weak 无法转换问题
/**
 使用clang转 OC为C++时可能遇到的问题:
 cannot create __weak reference because the current deployment target does not support weak references
 
 解决办法 ： 支持ARC/指定运行时版本。
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-8.0.0 main.m

 */



#import <Foundation/Foundation.h>

typedef void (^RBBlock) (void);

// __block 修饰的变量被包装成OC对象
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

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int num;
    struct __Block_byref_age_0 *age; // by ref
};






int main(int argc, const char * argv[]) {
    @autoreleasepool {

    
        int num = 20;
        
        __block int age = 10;
        
        NSObject *objc = [[NSObject alloc] init];
        __weak NSObject *weakObjc = objc;
        
        RBBlock block = ^ {
            
            age = 30;
            
            NSLog(@"num : %d",num);
            NSLog(@"age : %d",age);
            NSLog(@" %p",weakObjc);
        };
        
        
        
        //将block强制转换成这种结构体 __main_block_impl_0
        struct __main_block_impl_0 *blockImpl = (__bridge struct __main_block_impl_0 *)block;
        
        block();

    }
    return 0;
}
