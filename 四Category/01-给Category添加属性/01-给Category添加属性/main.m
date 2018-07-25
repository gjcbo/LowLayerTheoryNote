
//  main.m
//  01-给Category添加属性
//
//  Created by RaoBo on 2018/7/25.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Person *person1 = [[Person alloc] init];
//        person1.age = 10;
        
        //使用关联对象给Category添加属性
        person1.weight = 40.0;
        NSLog(@"weight: %.2f",person1.weight);
    }
    return 0;
}
