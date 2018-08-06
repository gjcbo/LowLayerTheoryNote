//
//  HookViewController.m
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  Hook : 钩子，交换系统方法。

#import "HookViewController.h"

@interface HookViewController ()

@end

@implementation HookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Hook";
    //使用hook的效果：命名传的是redColor。实际变成了绿色。
    self.view.backgroundColor = [UIColor redColor];
    
    [self demo1ArrayAddNilObj];
}


//向数组中添加 nil 元素导致奔溃。
- (void)demo1ArrayAddNilObj {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *str = nil;
    [arr addObject:str];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
