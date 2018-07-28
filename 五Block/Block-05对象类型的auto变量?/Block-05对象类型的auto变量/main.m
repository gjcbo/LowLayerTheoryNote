//
//  main.m
//  Block-05对象类型的auto变量
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  对象类型的auto类型变量???这个是有疑惑的。


#import <Foundation/Foundation.h>
#import "Person.h"

//重复以前的知识: block内使用auto变量后就是stackBlock类型
//ARC默认所有指针都是强指针
//ARC下block被强指针指向会自动进行copy操作。如果是stackBlock copy后就变成MallocBlock拷贝到堆空间。如果是globalBlock使用copy后还是globalBlock



#pragma mark - 二 堆上的block
/**
 如果block被拷贝到堆上
 1>会调用block内部的copy函数
 2>copy函数内部会调用 _Block_object_assign 函数
 3> _Block_object_assign函数内部会根据 auto变量的修饰符(__strong, __weak )做出相应的操作 形成强引用或弱引用。
 

 如果block从堆上被移除
 1>会调用block内部的dispose函数
 2>dispose 函数内部会自动调用 _Block_object_dispose 函数
 3>_Block_object_dispose 函数内部会自动释放引用auto变量。
 */






#pragma mark - 一 栈上的block不会对对象类型的auto变量产生强引用？
//没证明出来。
//typedef void(^RBBlock)(void);
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        //一：栈区的block2
//        //这是一个栈区block。__NSStackBlock__,
//        //判断条件:1.没有强指针指向他。2.使用了auto变量。---->栈区。
////        NSLog(@"%@",[^{
////            NSLog(@"%d",person.age);
////        } class]);
//
//
////        //栈区的block2
//        {
//            //局部变量在栈区 person 栈区，
//            Person *person = [[Person alloc] init];
//
//            //这个block也在栈区。
//            [^{
//                NSLog(@"%d",person.age);
//            } copy];
//            NSLog(@"----------begin");
//        }
//        //出变量作用域，person挂了。block已经挂了。
////        -----------------------------------------------------------
//        NSLog(@"---------- end");
//
//
//
//
//
//
//        // 堆区的block: ARC默认都是强指针,因为有强制值指着他所以是堆区block。指向:对对象进行赋值操作可以认为就是强指针指向。
////        {
////            Person *person3 = [[Person alloc] init];
////
////            person3.age = 40;
////            RBBlock block3 = ^{
////                NSLog(@"%d----",person3.age);
////            };
////            person3.age = 3;
////            NSLog(@"%@",[block3 class]);
////            block3();
////
////            NSLog(@"------------begin");
////        }
////        NSLog(@"--------------end");
//
//    }
//
//    return 0;
//}

