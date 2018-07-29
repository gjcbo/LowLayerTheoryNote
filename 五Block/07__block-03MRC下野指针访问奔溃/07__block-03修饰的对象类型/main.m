//
//  main.m
//  07__block-03修饰的对象类型
//
//  Created by RaoBo on 2018/7/29.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


#pragma mark - 二
//MRC环境下 下面的程序会崩溃，Thread 1 : EXC_BAD_ACCESS(code=1,address = 0x18
/**
 在 block() 调用之前release person 对象铁定奔溃。野指针访问。
 反复实验, 排除干扰因素。
 1.MRC环境下使用了 auto 变量。所以这是一个StackBlock栈区block, 很危险的。栈区内存随时被释放。
 2.因为是栈区block所以不会对 person 对象进行持有。
 3.[person release] 后再去调用block().
 4.block 内部分装了一段代码。这里面用到了person对象。但是此时person对象已经被销毁。你还去访问。铁定奔溃。
 访问了野指针====》BAD_ACCESS
 5. 间接证明了ARC下block被强指针指向时。回被copy到堆区。
 */
int main(){
    
    Person *person = [[Person alloc] init];
    
    void(^block)(void) = ^{
        NSLog(@"%@",person);
    };
    
    [person release];
    block();
    NSLog(@"1.--------");
    
    [block release];
    
    NSLog(@"2.----------");
}


#pragma mark - 一 判断block类型(复习)
int main1(int argc, const char * argv[]) {
    @autoreleasepool {

    //block的类型
        /**
         GlobalBlock    没有使用auto变量。
         StackBlock      使用了auto变量，
         MallocBlock      Stack使用了copy
         
         注意区分环境
         ARC，自动管理内存，编译器会自动做一些操作. 《潜规则》 你不了解潜规则。有些东西你就是想不明白。
         比如 auto类型的自动变量。 默认是省略的。😁😁😁😁😁😁😁。功底越扎实，知识面越广，学的就越快。这个也符合马太效应。强者愈强,弱者愈弱。你会,你就会的越多;你不会,很痛苦的,越来越差，慢慢就被淘汰了。生活本来就是一件很痛苦的事情，你会惊讶为什么小孩的疫苗都敢造假，造假的代价就是设备故障，作恶者继续逍遥法外,你会很通过，有病吧，这个社会烂透了。你会感慨高房价。最终你发现自己成了奴隶。拼命劳作，只是能填饱肚子。
         
         随机应变，用自己的话总结,记忆会更加深刻。
         
         ARC 环境下，编译器会根据情况自动将栈上block复制到堆上。
         1. block 作为方法返回值的时候
         2. block被强指针指向时。(ARC下默认所有对象都是强指针，所谓强指针指向就是进行了赋值操作。比如  Person *per1 = [[Person alloc] init];   per1强指向 Person创建出来的对象)
         3. 系统API 中含有 usingBlock方法参数时
         4. block作为GCD方法参数时
         */
        
       __block Person *person = [[Person alloc] init];

        void(^block)(void) = ^{
            NSLog(@"%@",person);
        };
        
        [person release];
        
        NSLog(@"%@",[block class]);
    }
    return 0;
}

