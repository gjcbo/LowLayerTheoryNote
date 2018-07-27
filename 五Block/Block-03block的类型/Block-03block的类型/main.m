//
//  main.m
//  Block-03block的类型
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 关于block的类型一切以 运行时为准
 
 clang 转 C++ 只是一种参考
 */

/**
 block分三种，可以通过调用 class方法查看。最终都继承自NSObject 所以block有一个isa指针，所以说block也是OC对象
 注意:这个是区分环境的 MRC下和ARC会有不同。不做深究，了解就行。
 
 Tragers--->Building Setting -->搜索  ”automatic ref”
 
 block类型                       环境
 __NSGlobalBlock__          没有访问auto变量
 __NSStatcBlock__           访问了auto变量
 __NSMallocBlock__          __NSStatcBlock__ 调用了copy
 
 
 每一中block调用copy后的结果
 StatcBlock 从栈区拷贝到堆区
 MallocBlock  引用计数增加。
 
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        void test1(void);
        test1();
    }
    return 0;
}






#pragma mark - 一 调用class方法查看block的类型
void test1() {
    void(^block1)(void) = ^(void) {
        
        NSLog(@"假疫苗,寒了心");
    };
    
    int num1  = 10;
    void(^block2)(void) = ^{
        NSLog(@"Hello -%d",num1);
    };
    
    NSLog(@"%@ %@ %@",[block1 class],[block2 class],[^{
        NSLog(@"%d",num1);
    } class]);
}

void test2(void) {
    
    //调用class 方法查看block的类型
    void(^block2)(void) = ^{
        
        NSLog(@"Hello");
    };
    
    block2();

    // __NSGlobalBlock__  __NSGlobalBlock  NSBlock  NSObject
    NSLog(@"%@",[block2 class]);
    NSLog(@"%@",[[block2 class] superclass]);
    NSLog(@"%@",[[[block2 class] superclass] superclass]);
    NSLog(@"%@",[[[[block2 class] superclass] superclass] superclass]);
    
}
