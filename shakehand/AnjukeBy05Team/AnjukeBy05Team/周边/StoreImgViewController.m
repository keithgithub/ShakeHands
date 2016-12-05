//
//  StoreImgViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "StoreImgViewController.h"

@interface StoreImgViewController ()

@end

@implementation StoreImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.33*theHeight, theWidth, 0.33*theHeight)];
    imageView.image = _theImage;
    [self.view addSubview:imageView];
    // 添加单击手势
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapAction:)];
    [self.view addGestureRecognizer:oneTap];
}
#pragma mark 单击手势事件
-(void)oneTapAction:(UITapGestureRecognizer *)oneTap
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
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
