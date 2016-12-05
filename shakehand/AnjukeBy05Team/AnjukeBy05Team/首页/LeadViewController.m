//
//  LeadViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/22.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_imageArry;
}

@end

@implementation LeadViewController


-(NSMutableArray *)imageArry
{
    if (_imageArry == nil) {
        _imageArry = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"Guide%d",i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [_imageArry addObject:image];
        }
    }
    return _imageArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    scrollView.backgroundColor = [UIColor brownColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //    设置滚动视图
    scrollView.contentSize = CGSizeMake(theWidth*self.imageArry.count, 0);
    
    //    在滚动视图上加图片
    for (int i = 0; i<self.imageArry.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*theWidth, 0, theWidth, theHeight)];
        imageView.image = [self.imageArry objectAtIndex:i];
        [scrollView addSubview:imageView];
        
        
        
        //        开始体验按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(2*theWidth+135, theHeight-80, 100, 32)];
        [button setTitle:@"开始体验" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor colorWithRed:253/255.0 green:211/255.0 blue:100 /255.0 alpha:1];
        [button addTarget:self action:@selector(theBeginAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview: button];
        
    }

}
#pragma mark 按钮事件
-(void)theBeginAction:(UIButton *)button
{
    //    轻量级的文件保存
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    通过这个ThisNotFirstTime 这个key 设置状态
    [userDefault setBool:YES forKey:@"ThisNotFirstTime"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoLead" object:nil userInfo:nil];
    
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
