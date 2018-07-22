//
//  Person.m
//  KVO-01基本使用
//
//  Created by RaoBo on 2018/7/22.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)setAge:(int)age {
    _age = age;
}

//实现原理
/**
 1.先调用 willChangeValueForKey
 
 2.再调用   [super setAge:age];
 
 3.然后调用 didChangeValueForKey 这个方法里面调用了 监听器的方法。
  -[ViewController observeValueForKeyPath:ofObject:change:context:]--96
  -[      监听器    observeValueForKeyPath:ofObject:change:context:]--96
 */

- (void)willChangeValueForKey:(NSString *)key {
 
    [super willChangeValueForKey:key];
    
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key  {
    
    NSLog(@"didChangeValueForKey - begin");
    
    [super didChangeValueForKey:key];
    
    NSLog(@"didChangeValueForKey - end");
}
@end

