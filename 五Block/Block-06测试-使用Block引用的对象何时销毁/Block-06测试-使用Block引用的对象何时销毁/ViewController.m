//
//  ViewController.m
//  Block-06测试-使用Block引用的对象何时销毁
//
//  Created by RaoBo on 2018/7/28.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //ARC 默认都是强指针。
    Person *person1 = [[Person alloc] init];
    
    __weak Person *weakP = person1;
    

    //判断标准是:强指针什么时候挂。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //1s 后强指针挂了。
        NSLog(@"1.%@",person1);  //1s 后释放
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2.%@",weakP); //person1什么时候挂,  weakP 就什么时候挂。
            //打印结果 ：  2.(null)

        });
    });
    NSLog(@"touchesBegan--withEvent");
    
    // 总结:判断标准是什么？ 以 使用强指针指向的对象在block对象中销毁的时间为准
    
}

- (void)question3 {
    Person *person1 = [[Person alloc] init];
    
    __weak Person *weakP = person1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"1.%@",weakP);  //1s 后释放
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2.%@",person1); // 大约是 3s 后释放
        });
    });
    NSLog(@"touchesBegan--withEvent");
    
    // 总结:判断标准是什么？ 以 使用强指针指向的对象在block对象中销毁的时间为准
}


- (void)question2 {
    __weak Person *person1 = [[Person alloc] init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"==%@",person1);
    });
    NSLog(@"touchesBegan--withEvent");

    //立即释放
}


// 重复:
/**
 ARC下，编译器会根据情况自动将对栈区的block进行copy，拷贝到堆区。比如一下情况。
 1.block作为函数返回值时
 2.将block赋值给 __strong 指针时。(当block有强指针指向的时候)
 3. 系统API 中以 usingBlock作为方法参数的block。
 4. GCD 方法参数中的block
 */
- (void)question1 {
    Person *person1 = [[Person alloc] init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"==%@",person1);
    });
    NSLog(@"----------");
    
    // 3s 后释放。
}

@end
