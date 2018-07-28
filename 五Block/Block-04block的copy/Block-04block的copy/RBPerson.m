//
//  RBPerson.m
//  Block-04block的copy
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBPerson.h"

@implementation RBPerson

- (void)dealloc {
//    [super dealloc];
    NSLog(@"%s--%d",__func__,__LINE__);
}
@end
