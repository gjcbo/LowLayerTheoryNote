//
//  RBPerson.m
//  KVC-02赋值原理
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBPerson.h"

@implementation RBPerson
//- (void)setAge:(int)age {
//    NSLog(@"setAge--%d",age);
//}

//- (void)_setAge:(int)age {
//    NSLog(@"_setAge -- %d",age);
//}

//accessInstanceVariablesDirectly
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}
#pragma mark- kvc setValue: forKey:赋值原理
/**
 参考: 简书xxx 流程图
 一图胜千言。
 setValue: forKey:
 按照
 setKey: ,  _setKey: 的顺序查找方法
 --->找到了，传递参数，调用方法
 
 ---> 没找到方法 查看accessInstanceVariablesDirectly方法的返回值
 ---> NO 调用 setValue: forUndefinedKey:并抛出异常 ：NSUnknownKeyException
 ---> YES 按照 :_key,_isKey, key, isKey的顺序去查找成员变量
 ---> 找到了直接赋值
 ---> 没找到 NO 调用 setValue: forUndefinedKey:并抛出异常 ：NSUnknownKeyException
 
 */

@end
