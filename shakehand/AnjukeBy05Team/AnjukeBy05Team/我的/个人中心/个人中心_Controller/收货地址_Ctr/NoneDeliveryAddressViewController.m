//
//  NoneDeliveryAddressViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/16.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "NoneDeliveryAddressViewController.h"
#import "AddUserAddressViewController.h"

@interface NoneDeliveryAddressViewController ()

- (IBAction)addOneDeliveryAddressAction:(id)sender;


@end

@implementation NoneDeliveryAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    // 设置标题
    self.title = @"我的收货地址";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    //  隐藏返回按钮文字，只留图标 （此效果作用于：下一级页面）
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    // 创建系统自带的导航栏按钮Item
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDeliveryAddressAction)];
    
    rightBarBtn.tintColor = [UIColor orangeColor];//设置按钮颜色
    self.navigationItem.rightBarButtonItem = rightBarBtn;//添加到导航栏右按钮


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


//  增加收货地址
- (void)addDeliveryAddressAction
{
    
    [self showMessage:@"增加收货地址"];
    
    AddUserAddressViewController *addUserAddressViewCtr = [[AddUserAddressViewController alloc] init];
    [self.navigationController pushViewController:addUserAddressViewCtr animated:YES];
    
}

//  增加收货地址
- (IBAction)addOneDeliveryAddressAction:(id)sender {
    
    [self showMessage:@"增加收货地址"];
    
    AddUserAddressViewController *addUserAddressViewCtr = [[AddUserAddressViewController alloc] init];
    [self.navigationController pushViewController:addUserAddressViewCtr animated:YES];
    

}


// 底部提示
- (void)showMessage:(NSString *)message
{
    //UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 13.0f;
    showview.layer.masksToBounds = YES;
    //[window addSubview:showview];
    [self.view addSubview:showview];
    
    UILabel *label = [[UILabel alloc] init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize: CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    //设置底部提示视图位置和大小
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.83, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


@end
