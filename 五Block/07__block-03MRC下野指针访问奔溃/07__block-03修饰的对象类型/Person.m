//
//  Person.m
//  07__block-03修饰的对象类型
//
//  Created by RaoBo on 2018/7/29.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    
    [super dealloc];
    
    NSLog(@"%s--买假疫苗的挂了",__func__);
}
@end
