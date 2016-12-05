//
//  LSZKViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "LSZKViewController.h"

@interface LSZKViewController ()

@end

@implementation LSZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"拉手周刊";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    
    [self addScrollView];
    
    
}
-(void)addScrollView;
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    scrollView.backgroundColor = [UIColor orangeColor];
    
    scrollView.contentSize = CGSizeMake(0, (theHeight-64)*7+(theHeight-64)*2/3.0);
//    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i=0; i<7; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,(theHeight-64)*i, theWidth, theHeight-64)];
        NSString *imageStr = [NSString stringWithFormat:@"lszk_%d",i+1];
        imageView.image = [UIImage imageNamed:imageStr];
        [scrollView addSubview:imageView];
    }
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,(theHeight-64)*7, theWidth, (theHeight-64)*2/3.0)];

    imageView1.image = [UIImage imageNamed:@"lszk_8"];
    [scrollView addSubview:imageView1];
    
    [self.view addSubview:scrollView];
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
