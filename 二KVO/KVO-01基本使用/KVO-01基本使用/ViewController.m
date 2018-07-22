//
//  ViewController.m
//  KVO-01基本使用
//
//  Created by RaoBo on 2018/7/22.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  KVO: key-value observing
/**
 
 一:添加KVO监听
 [被监听者 addObserver:监听者 forKeyPath:要监听的属性是什么 options:监听新值、旧值、还是初始值 context:nil];

 [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
 
 二: 当属性的值反生改变的时候就会走的方法。
 observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 
 三: 在合适的时机移除监听
 [self.person1 removeObserver:self forKeyPath:@"age"];

 */


#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.person1 = [[Person alloc] init];
    self.person1.age = 1;
    self.person1.height = 11;
    
    
    self.person2 = [[Person alloc] init];
    self.person2.age = 2;
    self.person2.height = 20;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
    [self.person1 addObserver:self forKeyPath:@"height" options:options context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person1.age = 5;
//    self.person1.height = 13;
    
    
    self.person2.age = 20;
    self.person2.height = 25;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到:%@的%@:属性的值发生了改变:%@",keyPath,object,change);
}


//移除监听。
- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}


@end
