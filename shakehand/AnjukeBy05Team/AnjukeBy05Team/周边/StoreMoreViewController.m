//
//  StoreMoreViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "StoreMoreViewController.h"

#define ButtonSize 36
@interface StoreMoreViewController ()
{
    NSInteger _index;
}

@end

@implementation StoreMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家信息报错";
    //隐藏导航栏的自带返回按钮
    self.navigationItem.hidesBackButton = YES;
    // 自定义Item
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    backButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:  UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    // 创建表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, theWidth, theHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark 表视图数据源、委托事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSArray *array = @[@"商家已关闭",@"重复商家",@"地图位置错误",@"电话空号/错误"];
        cell.textLabel.text = array[indexPath.row];
    }
       return cell;
}
// 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 点击单元格 选中的单元格变灰恢复
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        //创建自定义提示框对象
        ZLAlertView *zlAlerview = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"确定商家已倒闭？"];
        // 添加按钮
        [zlAlerview addBtnTitle:@"取消" action:^{
            
        }];
        // 添加按钮
        [zlAlerview addBtnTitle:@"确定" action:^{
            [self eorrButton];
        }];
        [zlAlerview showAlertWithSender:self];
    }else if(indexPath.row == 1)
    {
        //创建自定义提示框对象
        ZLAlertView *zlAlerview = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"确定是重复商家？"];
        // 添加按钮
        [zlAlerview addBtnTitle:@"取消" action:^{
            
        }];
        // 添加按钮
        [zlAlerview addBtnTitle:@"确定" action:^{
            [self eorrButton];
        }];
        [zlAlerview showAlertWithSender:self];
    }else if(indexPath.row == 2)
    {
        //创建自定义提示框对象
        ZLAlertView *zlAlerview = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"确定商家地图位置错误？"];
        // 添加按钮
        [zlAlerview addBtnTitle:@"取消" action:^{
            
        }];
        // 添加按钮
        [zlAlerview addBtnTitle:@"确定" action:^{
            [self eorrButton];
        }];
        [zlAlerview showAlertWithSender:self];
    }else if(indexPath.row == 3)
    {
        //创建自定义提示框对象
        ZLAlertView *zlAlerview = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"确定商家电话空号/错误？"];
        // 添加按钮
        [zlAlerview addBtnTitle:@"取消" action:^{
            
        }];
        // 添加按钮
        [zlAlerview addBtnTitle:@"确定" action:^{
            [self eorrButton];
        }];
        [zlAlerview showAlertWithSender:self];
    }
}
// 添加 “反馈成功”按钮 函数
-(void)eorrButton
{
    _index = 0; // 全局变量
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(theWidth*0.35, 0.90*theHeight, 0.3*theWidth, 0.05*theHeight);
    button.layer.cornerRadius = 0.1*button.frame.size.width;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"反馈成功" forState:UIControlStateNormal];
    [self.view addSubview:button];
    //计时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:button repeats:YES];
  
}
#pragma mark 定时器事件
-(void)timerAction:(NSTimer *)timer
{
    _index ++;
    if (_index == 3) {
        UIButton *button = timer.userInfo;
        // 按钮从视图消失
        [button removeFromSuperview];
        _index = 0;
    }
}


#pragma mark Items 按钮事件
//返回按钮事件
-(void)backButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
