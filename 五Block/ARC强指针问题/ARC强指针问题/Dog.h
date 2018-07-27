//
//  Dog.h
//  ARC强指针问题
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;
@interface Dog : NSObject
@property (nonatomic, strong) Person *owner;
@property (nonatomic, copy) NSString *name;

@end
