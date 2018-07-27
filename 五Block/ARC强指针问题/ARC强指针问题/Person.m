//
//  Person.m
//  ARC强指针问题
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    NSLog(@"%s--%d",__func__,__LINE__);
}
@end
