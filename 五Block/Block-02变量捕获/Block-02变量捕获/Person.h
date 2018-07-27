//
//  Person.h
//  Block-02变量捕获
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, assign) int age;

- (instancetype)initWithAge:(int)age;

@end
