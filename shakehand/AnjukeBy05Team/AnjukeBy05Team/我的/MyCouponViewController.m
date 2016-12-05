//
//  MyCouponViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MyCouponViewController.h"

@interface MyCouponViewController ()

@end

@implementation MyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的抵用券";
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    
    loadingView.remarkLabelStr = @"您还没有抵用券";
    
    [self.view addSubview:loadingView];
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
