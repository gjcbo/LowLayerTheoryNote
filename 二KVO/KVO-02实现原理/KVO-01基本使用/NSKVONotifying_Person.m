//
//  NSKVONotifying_Person.m
//  KVO-01基本使用
//
//  Created by RaoBo on 2018/7/22.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "NSKVONotifying_Person.h"

@implementation NSKVONotifying_Person
- (void)setAge:(int)age {
    _NSSetIntValueAndNotify();
}

//伪代码
void _NSSetIntValueAndNotify()
{
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}
- (void)didChnageValueForKey:(NSString *)key {

    //通知监听器，某某属性值发生了改变。
    [observer observeValueForKeyPath:key ofObject:self change:nil context:nil];
}




// 目的:猜测,苹果不开源,重写class方法可以屏蔽KVO内部实现，隐藏NSKVONotifying_Person类的存在。
- (Class)class {
    
}


// 收尾工作
- (void)dealloc
{
    
}

- (BOOL)_isKVOA {
    
}


@end
