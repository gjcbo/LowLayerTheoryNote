//
//  ViewController.m
//  KVO-01基本使用
//
//  Created by RaoBo on 2018/7/22.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  KVO: key-value observing


#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>


@interface ViewController ()
@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;

@end

@implementation ViewController

#pragma mark - 一 打印一个Class的所有方法。
/**
 传不同的对象 打印不同的结果
 传:class对象，类对象 就打印所有的对象方法(-号方法)
 获取class对象（类对象) [Person class]; [self.person1 class]; object_getClass(self.person1)
 
 
 传:meta-class对象(元类对象)，就打印类方法(+号方法)
 获取meta-class对象(元类对象): object_getClass(请传class对象)
 */
- (void)printAllMethodOfClass:(Class)cls {
    
    unsigned int count = 0;
    
    //获取Method数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    //存储方法名
    NSMutableString *methodNamesM = [NSMutableString string];
    
    for(int i=0; i<count; i++) {
        //获取方法
        Method method = methodList[i];
        
        //获取方法名
       NSString *methodName = NSStringFromSelector(method_getName(method));
        
        [methodNamesM appendString:methodName];
        [methodNamesM appendString:@" , "];
    }
    
    //释放
    free(methodList);
    
    NSLog(@"%@",methodNamesM);
}

#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.person1 = [[Person alloc] init];
    self.person1.age = 1;
 
    self.person2 = [[Person alloc] init];
    self.person2.age = 2;
 
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    
    
    //一 类对象
//    NSLog(@"添加KVO监听之前: %@ %@",
//          object_getClass(self.person1),
//          object_getClass(self.person1));
    
    //二 方法的实现IMP
//    IMP p1SetAgeIMP1 = [self.person1 methodForSelector:@selector(setAge:)];
//    IMP p2SetAgeIMP1 = [self.person2 methodForSelector:@selector(setAge:)];
//    NSLog(@"添加KVO监听之前 %p--%p",p1SetAgeIMP1,p2SetAgeIMP1);

    
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    IMP p1SetAgeIMP2 = [self.person1 methodForSelector:@selector(setAge:)];
    IMP p2SetAgeIMP2 = [self.person2 methodForSelector:@selector(setAge:)];
    NSLog(@"添加KVO监听之前 %p--%p",p1SetAgeIMP2,p2SetAgeIMP2);
    NSLog(@"1111");

//    NSLog(@"添加KVO监听之后: %@ %@",
//          object_getClass(self.person1),
//          object_getClass(self.person1));
    
   
    //  使用lldb 指令查看方法名  p (IMP)方法IMP的地址
    //  p (IMP) 0x10381d6c4
    // (IMP) $0 = 0x00000001070976c4 (Foundation`_NSSetIntValueAndNotify)
 
    
//    Class person1Class = object_getClass(self.person1);
//    Class person2Class = object_getClass(self.person2);
//    NSLog(@"类对象 %p(%@)   --  %p(%@)",
//          person1Class,person1Class,
//          person1Class,person2Class);
//
//
//    Class person1MetaClass = object_getClass(object_getClass(self.person1));
//    Class person2MetaClass = object_getClass(object_getClass(self.person2));
//    NSLog(@"元类对象 %p(%@)  --  %p(%@)",
//          person1MetaClass,person1MetaClass,
//          person2MetaClass,person2MetaClass);
    
    
    
    
    
    
    // 四 : 打印对象内部的所有方法。
    [self printAllMethodOfClass:object_getClass(self.person1)];
    [self printAllMethodOfClass:object_getClass(self.person2)];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
//    self.person1.age = 20;
//    self.person2.age = 22;
    
    //疑问:都是调用setter方法为什么person2没有被监听？
    // p self.person1->isa  NSKVONotifying_Person
    [self.person1 setAge:20];
    // self.person2->isa    Person
    [self.person2 setAge:22];
    
}

#pragma mark - 二 KVO监听

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到:%@的%@:属性的值发生了改变:%@",keyPath,object,change);
    
    NSLog(@"%s--%d",__FUNCTION__,__LINE__);
}


//移除监听。
- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}


@end
