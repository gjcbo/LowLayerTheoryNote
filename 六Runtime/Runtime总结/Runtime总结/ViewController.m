//
//  ViewController.m
//  Runtime总结
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "HookViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, copy)  NSArray *dataArray;

@end

@implementation ViewController
#pragma mark - 一 lazy
- (UITableView *)tv{
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tv;
}

#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Runtime总结";
    [self.view addSubview:self.tv];
    
    self.dataArray = [self stimulateData];
}
- (NSArray *)stimulateData {
    
    NSString *str1 = @"钩子";
    
    return @[str1];
}


#pragma mark - 三 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        HookViewController *hookVC = [[HookViewController alloc] init];
        [self.navigationController pushViewController:hookVC animated:YES];
    }
}


#pragma mark - 一 lazy



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
