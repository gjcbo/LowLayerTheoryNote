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
