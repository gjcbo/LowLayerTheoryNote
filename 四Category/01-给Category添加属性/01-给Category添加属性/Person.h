//
//  Person.h
//  01-给Category添加属性
//
//  Created by RaoBo on 2018/7/25.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;


//属性 = 地下划线的成员变量 + setter方法 + getter 方法
//- (void)setName:(NSString *)name {
//    _name = name;
//}
//
//- (NSString *)name {
//    return _name;
//}
//



@end
