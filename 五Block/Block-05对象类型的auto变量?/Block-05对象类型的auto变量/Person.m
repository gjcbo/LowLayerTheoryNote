//
//  Person.m
//  Block-05对象类型的auto变量
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)dealloc {
    NSLog(@"%s 挂了",__func__);
}



- (void)xxxxxxBlock {
 
    void(^lishiBlock)(void) = ^{
    
        NSLog(@"李四block");
    };
    
    lishiBlock();
    
}
- (void)testBlock {
    void(^zhangsanBlock)(void) = ^{
        NSLog(@"张三block");
    };
    zhangsanBlock();
    
    void(^zhangsanBlock222222222)(void) = ^{
        NSLog(@"张三block");
    };
    zhangsanBlock222222222();
    
    void(^zhangsanBlock33333333333)(void) = ^{
        NSLog(@"张三block");
    };
    zhangsanBlock33333333333();
    
}
@end
