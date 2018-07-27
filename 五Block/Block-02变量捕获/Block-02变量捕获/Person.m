//
//  Person.m
//  Block-02变量捕获
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

void(^block1)(void);


int age_;
@implementation Person



- (void)test {

    age_ = 100;
    block1 = ^ {
        NSLog(@"age : %d",age_);
    };
}


- (instancetype)initWithAge:(int)age {
    if (self = [super init]) {
        self.age = _age;
    }
    
    return self;
}



@end
