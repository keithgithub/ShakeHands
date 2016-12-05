//
//  TicketsViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "TicketsViewController.h"

@interface TicketsViewController ()

@end

@implementation TicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"拉手券";
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    
    loadingView.remarkLabelStr = @"您当前没有可用的拉手券哦";

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
