//
//  RBPerson.m
//  KVC-02赋值原理
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBPerson.h"

@implementation RBPerson

#pragma mark valueForkey:@"age" 的取值流程。 即便是Person什么属性都没有(没有属性,没有成员变量)
//按照 getKey、key、isKey、_key 顺序查找,如果有就展开调用。
//- (int)getAge{
//    return 11;
//}
//- (int)age{
//    return 12;
//}
//- (int)isAge {
//    return 13;
//}
//- (int)_age {
//    return 14;
//}


#pragma mark - 二 如果上述方法都找不到就
//访问 accessInstanceVariablesDirectly 的返回值，默认是 YES，
//默认:YES
//如果是NO就抛出异常 valueForUndefinedKey:  抛出异常 NSUnknownKeyException
//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
////    return NO;
//}

#pragma mark - 三 如果允许访问成员变量
// 会按照如下顺序进行赋值。
/**
 _key
 _isKey
 key
 isKey
 */
//都找不到，抛出异常。


@end
