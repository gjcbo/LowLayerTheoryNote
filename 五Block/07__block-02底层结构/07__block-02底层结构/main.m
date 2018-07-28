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


//理论 __block的内存管理。
/**
 1.当block在栈上时, 并不会对__block产生强引用。
 2.当block被拷贝到堆上时
 2-1> 会调用block内部的copy函数
 2-2> copy内部会调用 _Block_object_assign 函数
 2-3> _Block_object_assing 函数会对__block变量形成强引用 (retain)。
  这里仅限于ARC时会retain，MRC时不会retain
 

 当block从 堆中移除的时候
 1> 会调用block内部的 dispose 函数
 2> _Block_object_assign 函数内部会调用 _Block_object_dispose 函数
 3> _Block_object_dispose函数会自动释放引用的__block变量(release)
 */
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
