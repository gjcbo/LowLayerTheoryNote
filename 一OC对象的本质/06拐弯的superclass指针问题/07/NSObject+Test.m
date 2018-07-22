//
//  NSObject+Test.m
//  07
//
//  Created by RaoBo on 2018/7/21.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "NSObject+Test.h"


@implementation NSObject (Test)
//+ (void)test {
//    NSLog(@"+ [NSObject test] %p -- %d",self,__LINE__);
//}

- (void)test {
    NSLog(@"- [NSObject test] %p-- %d",self,__LINE__);
}

@end
