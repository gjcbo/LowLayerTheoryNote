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

//typedef struct objc_class *Class; //64bit操作系统 结构体指针占8个字节

struct NSObject_IMPL {
    Class isa;
};

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS; //8
    int _age; // 4
    int _hieght; //4
    int _no; //4
    double weight; // 8
    char sex; //1
    double money; // 8
    int browers; //4
}; //56
//56 -- 16的倍数-> 64
// 40 ---》16倍数 -----》 48

@interface Person : NSObject
{
    int _age;
    int _height;
    int _no;
    double weight;
    char sex;
    double money;
    int browers; //4
}
@end

@implementation Person

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSLog(@"%zd",sizeof(struct Person_IMPL)); // 24
        
//        Person *p = [[Person alloc] init];
//
//        //24个就够了，实际上给多了。 内存分配问题。
//        NSLog(@"%zd %zd",
//              class_getInstanceSize([Person class]), // 24
//              malloc_size((__bridge const void *)p));//32
        
        //一个NSObject对象占用多少内存?
        /**
         系统分配了16个字节给NSObject对象(通过malloc_size函数获得) 实际分配的内存
         但NSObject对象内部只使用了8个字节的空间(64bit环境下可以通过 class_getInstanceSize获得) 真正用上的。
         
         
         */
        // 16个字节。
        NSObject *objc = [[NSObject alloc] init];
        NSLog(@"%zd %zd",class_getInstanceSize([NSObject class]),
              malloc_size((__bridge const void *)objc));
        NSLog(@"================");
        
        
        
        //
        Person *person = [[Person alloc] init];
        NSLog(@"%zd %zd",class_getInstanceSize([Person class]), // 54
              malloc_size((__bridge const void *)person) // 64
              );
    }
    return 0;
}
