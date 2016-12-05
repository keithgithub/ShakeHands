//
//  PayDetialViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PayDetialViewController.h"
#import "HomeViewController.h"

@interface PayDetialViewController ()

@end

@implementation PayDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    
//    上面灰色view
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.154)];
    view1.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view1];
    
    //    绿色打勾
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.077/2, theWidth*0.077/2, theWidth*0.075, theWidth*0.075)];
    imgView.image = [UIImage imageNamed:@"goods_detail_icon_feature"];
    [view1 addSubview:imgView];
    
    //    支付成功
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.077/2+theWidth*0.075+10, theWidth*0.077/2, theWidth*0.3, theWidth*0.075)];
    lb1.textColor = [UIColor colorWithRed:98/255.0 green:206/255.0 blue:103/255.0 alpha:1];
    lb1.text = @"支付成功";
    lb1.font = [UIFont boldSystemFontOfSize:18];
    [view1 addSubview:lb1];
    
    //    店名详细lb
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, theWidth*0.21, theWidth, theWidth*0.06)];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.text = [NSString stringWithFormat:@"%@ 数量%ld",_foodModel.foodName ? _foodModel.foodName :_mModel.movieName,_number];


    //    价格lb
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(0, theWidth*0.3, theWidth, theWidth*0.14)];
    lb3.textAlignment = NSTextAlignmentCenter;
    lb3.font = [UIFont boldSystemFontOfSize:40];
    lb3.text = [NSString stringWithFormat:@"¥%ld", (_foodModel.price ? _foodModel.price : _cinemaModel.cinemaLowPrice)*_number];
    [self.view addSubview:lb2];
    [self.view addSubview:lb3];
    
    //    灰色线
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0,theWidth*0.48, theWidth, theWidth*0.01)];
    view2.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view2];
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(20, theWidth*0.51, theWidth*0.2, theWidth*0.06)];
    lb4.textColor = [UIColor grayColor];
    lb4.font = [UIFont systemFontOfSize:14];
    lb4.text = @"商       品";
    [self.view addSubview:lb4];
    
    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(20, theWidth*0.51+theWidth*0.06, theWidth*0.2, theWidth*0.06)];
    lb5.textColor = [UIColor grayColor];
    lb5.font = [UIFont systemFontOfSize:14];
    lb5.text = @"交易时间";
    [self.view addSubview:lb5];
    
    UILabel *lb6 = [[UILabel alloc]initWithFrame:CGRectMake(20, theWidth*0.51+theWidth*0.06*2, theWidth*0.2, theWidth*0.06)];
    lb6.textColor = [UIColor grayColor];
    lb6.font = [UIFont systemFontOfSize:14];
    lb6.text = @"支付方式";
    [self.view addSubview:lb6];
    
    UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(20, theWidth*0.51+theWidth*0.06*3, theWidth*0.2, theWidth*0.06)];
    lb7.textColor = [UIColor grayColor];
    lb7.font = [UIFont systemFontOfSize:14];
    lb7.text = @"交易单号";
    [self.view addSubview:lb7];
    
//    传入店面
    UILabel *lb8 = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.33, theWidth*0.51, theWidth*0.63, theWidth*0.06)];
    lb8.textAlignment = NSTextAlignmentRight;
    lb8.textColor = [UIColor grayColor];
    lb8.font = [UIFont systemFontOfSize:14];
    lb8.text = lb2.text;
    [self.view addSubview:lb8];
    
//    生成时间
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr = [df stringFromDate:dateNow];
    UILabel *lb9 = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.33, theWidth*0.51+theWidth*0.06, theWidth*0.63, theWidth*0.06)];
    lb9.textAlignment = NSTextAlignmentRight;
    lb9.textColor = [UIColor grayColor];
    lb9.font = [UIFont systemFontOfSize:14];
    lb9.text = timeStr;
    [self.view addSubview:lb9];
    
//    支付方式（微信）
    UILabel *lb10 = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.33, theWidth*0.51+theWidth*0.06*2, theWidth*0.63, theWidth*0.06)];
    lb10.textAlignment = NSTextAlignmentRight;
    lb10.textColor = [UIColor grayColor];
    lb10.font = [UIFont systemFontOfSize:14];
    lb10.text = @"网络支付";
    [self.view addSubview:lb10];
//    订单号
  
    [df setDateFormat:@"yyyyMMddHH"];
    timeStr = [df stringFromDate:dateNow];
    UILabel *lb11 = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.33, theWidth*0.51+theWidth*0.06*3, theWidth*0.63, theWidth*0.06)];
    lb11.textAlignment = NSTextAlignmentRight;
    lb11.textColor = [UIColor grayColor];
    lb11.font = [UIFont systemFontOfSize:14];
    lb11.text = timeStr;
    [self.view addSubview:lb11];
    
    //    下面灰色view
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0,theWidth*0.51+theWidth*0.06*4.5,theWidth,theWidth)];
    view3.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view3];
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backBtn setTitle:@"完成" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:98/255.0 green:206/255.0 blue:103/255.0 alpha:1] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    
    
}
-(void)backBtnAction:(UIButton *)button
{
//    HomeViewController *homeVCtr = [[HomeViewController alloc] init];
//    [homeVCtr setHidesBottomBarWhenPushed:NO];

//    [self presentViewController:homeVCtr animated:YES completion:^{
        //[self setHidesBottomBarWhenPushed:NO];
//    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
