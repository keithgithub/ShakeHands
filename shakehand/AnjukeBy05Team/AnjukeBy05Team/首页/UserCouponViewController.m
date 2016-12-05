//
//  UserCouponViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UserCouponViewController.h"

@interface UserCouponViewController ()

@end

@implementation UserCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用抵债券";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImageView *imageView  = [[ UIImageView alloc] initWithFrame:CGRectMake(0.33*theWidth, 0.3*theWidth, 0.3*theWidth, 0.4*theWidth)];
    imageView.image = [UIImage imageNamed:@"load_error"];
    [self.view addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.2*theWidth, 0.71*theWidth, 0.6*theWidth, 0.04*theWidth)];
    lable.text = @"该单没有可使用的抵债券";
    [self.view addSubview:lable];
    
}
//当界面出现时
-(void)viewWillAppear:(BOOL)animated
{
    // 隐藏导航栏 bar
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    // 自定义返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lightItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = lightItem;
    //自定义“帮助”按钮
    UIButton *helpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [helpButton setTitle:@"帮助" forState:UIControlStateNormal ];
    [helpButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal ];
//    [helpButton addTarget:self action:@selector(helpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:helpButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark backButton 按钮事件
-(void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
