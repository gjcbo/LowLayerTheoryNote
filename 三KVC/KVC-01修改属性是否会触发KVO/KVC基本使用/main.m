//
//  main.m
//  KVC基本使用
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  简书 https://www.jianshu.com/writer#/notebooks/16118235/notes/31243731/preview


#import <Foundation/Foundation.h>
#import "Person.h"
#import "RBObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *person = [[Person alloc] init];

        //添加KVO监听
        RBObserver *observer = [[RBObserver alloc] init];
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
        [person addObserver:observer forKeyPath:@"age" options:options context:nil];
        
        //KVC赋值:是否会触发监听方法。
        [person setValue:@10 forKey:@"age"];
        NSLog(@"%d",person.age);
        
        //移除KVO监听
        [person removeObserver:observer forKeyPath:@"age"];
        
    
    }
    return 0;
}
