//
//  main.m
//  KVC-02赋值原理
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  简书 https://www.jianshu.com/writer#/notebooks/16118235/notes/31243731/preview

#import <Foundation/Foundation.h>
#import "RBPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        RBPerson *person = [[RBPerson alloc] init];
        
        [person setValue:@10 forKey:@"age"];
        
        NSLog(@"111111");
        
    }
    return 0;
}
