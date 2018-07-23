//
//  main.m
//  KVC-03取值流程
//
//  Created by RaoBo on 2018/7/23.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  简书 https://www.jianshu.com/writer#/notebooks/16118235/notes/31243731/preview


#import <Foundation/Foundation.h>
#import "RBPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        RBPerson *person = [[RBPerson alloc] init];

        
        person->_age = 41;
        person->_isAge = 42;
        person->age = 43;
        person->isAge = 44;
        NSLog(@"%@",[person valueForKey:@"age"]);
     
        
        
    }
    return 0;
}
