//
//  main.m
//  ARC强指针问题
//
//  Created by RaoBo on 2018/7/27.
//  Copyright © 2018年 RaoBo. All rights reserved.
// https://blog.csdn.net/fanyong245758753/article/details/50487181

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

/**
 ARC判断原则
 只要还有一个强指针变量指向对象，对象就会保持在内存中。
 
 强指针
    1.默认所有指针变量都是强指针。✅ 在ARC中想提前释放一对象, 设置该对象的指针指向空即可， p= nil; 没有强指针指向该对象是，给对象就会被销毁。
    2.被 __strong 修饰的指针变量
 
 弱指针
 被 __weak修饰的指针
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        //一 强指针(ARC默认所有指针变量就是强指针)
//        Assigning retained object to weak variable; object will be released after assignment
        //__weak 如果用__weak修饰的话,一生下来就被销毁
//        __weak  Person *person = [[Person alloc] init];
//
//        Dog *dog = [[Dog alloc] init];
//        person.dog = dog;
//        dog = nil;
//
//        person.age = 10;
//        NSLog(@"%@ %@ %d",person,person.dog,person.age); //(null) (null) 0
        
        NSLog(@"-------------");
        
        //二 循环引用问题 dealloc 方法都不会走
        //如果Person的dog属性 和Dog的Person属性都是strong修饰的时候就会导致循环引用。相互持有，导致无法释放，造成内存泄漏。
        //解决办法就是。一方使用weak修饰
        //问题:❌,都用weak修饰也能解决问题,不知道有什么副作用？？？？❌
        Person *p2 = [[Person alloc] init]; // ARC默认所有指针变量都是强指针
        p2.age = 20;
        NSLog(@"p2.age = %d",p2.age);
        p2.age = 40;
        NSLog(@"p2.age = %d",p2.age);
        
        Dog *d2 = [[Dog alloc] init];
        d2.name = @"哈士奇";
        p2.dog = d2;
        NSLog(@"%@",p2.dog.name);
        d2.owner = p2;
        
        //ARC确实牛逼:从打印结果来看。不用管理内存，随意修改成员变量的值。不用的时候对象自动销毁。确实牛逼，都是在最后被销毁。

    }

    return 0;
}

