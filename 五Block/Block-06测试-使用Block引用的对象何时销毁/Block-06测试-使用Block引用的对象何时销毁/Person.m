//
//  Person.m
//  Block-06测试-使用Block引用的对象何时销毁
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    NSLog(@"%s 挂了----------",__FUNCTION__);
}
@end
