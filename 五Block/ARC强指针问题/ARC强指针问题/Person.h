//
//  Person.h
//  ARC强指针问题
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;

@interface Person : NSObject
@property (nonatomic, assign) int age;

//如果Person和Dog相互持有并且都是strong强指针的就会导致循环引用，会导致内存泄漏。都挂不了。
//解决循环引用。一方使用weak修饰
//问题:如果都使用weak修饰也能解决循环引用问题、有什么副作用吗？ 
@property (nonatomic, weak) Dog *dog;

@end
