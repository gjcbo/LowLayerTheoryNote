//
//  Person.m
//  01-给Category添加属性
//
//  Created by RaoBo on 2018/7/25.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"


@implementation Person

//问题:使用@property 同时重写seter /getter，编译报错:无法识别_name。

//细节回顾:如果使用@property 申明一个属性.系统默认会生成settr+getter+ _name。
//如果同时重写setter、getter 系统就不会生成该属性的setter和getter方法了,也就不会生成带下划线的成员变量了。所以就会  Use of undeclared identifier '_name';
//解决办法 使用 @systhesize(综合、合成)
//@synthesize name = _name;

//- (void)setName:(NSString *)name {
//    _name = name;
//}
//
//- (NSString *)name {
//    return _name;
//}

@end
