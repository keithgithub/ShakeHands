//
//  MyPriceViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MyPriceViewController.h"

@interface MyPriceViewController ()

@end

@implementation MyPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    
    loadingView.remarkLabelStr = _string;
    
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
