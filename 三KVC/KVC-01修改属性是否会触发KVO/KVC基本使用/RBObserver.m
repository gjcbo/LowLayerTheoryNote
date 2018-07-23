//
//  RBObserver.m
//  KVC基本使用
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBObserver.h"

@implementation RBObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@对象的%@属性发生的变化%@",object,keyPath,change);
}
@end
