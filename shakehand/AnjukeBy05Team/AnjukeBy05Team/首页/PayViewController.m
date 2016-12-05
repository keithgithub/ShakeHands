//
//  PayViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PayViewController.h"
#import "PayDetialViewController.h"
#import "PayPasswordViewController.h"
#import "RechargeViewController.h"

#define ThePriceTag       _foodModel.price ? _foodModel.price : _cinemaModel.cinemaLowPrice
#define TheNameTag        _foodModel.foodName ? _foodModel.foodName :_mModel.movieName
#define TheImageTag       _cinemaModel.cinemaImageName ? _cinemaModel.cinemaImageName:_foodModel.imageName
#define TheEvaluateScore  _mModel.moviePingfen ?  _mModel.moviePingfen:_foodModel.pingfen

@interface PayViewController ()
{
    UITextField  *_payPWTextField;
    UserModel    *_userModel;
}

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认交易";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.33)];
    view1.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, theWidth*0.474, theWidth, theWidth*1.14)];
    view2.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view2];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, theWidth*0.06, theWidth, theWidth*0.06)];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.text = [NSString stringWithFormat:@"%@ 数量%ld",TheNameTag,_number];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, theWidth*0.14, theWidth, theWidth*0.14)];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.font = [UIFont boldSystemFontOfSize:40];
    lb2.text = [NSString stringWithFormat:@"¥%ld",ThePriceTag*_number];
    [view1 addSubview:lb1];
    [view1 addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.046, theWidth*0.3+0.07*theWidth, theWidth*0.14, theWidth*0.06)];
    lb3.text = @"收款方";
    lb3.textColor = [UIColor grayColor];
    [self.view addSubview:lb3];
    
    UILabel *lb4 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.82, theWidth*0.3+0.07*theWidth, theWidth*0.14, theWidth*0.06)];
    lb4.text = @"拉手网";
    [self.view addSubview:lb4];
    
    UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(theWidth*0.09/2, theWidth*0.52+theWidth*0.09+20, theWidth*0.91, theWidth*0.134)];
    [payBtn setImage:[UIImage imageNamed:@"pay_now"] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    
    _payPWTextField = [[UITextField alloc] initWithFrame:CGRectMake(theWidth*0.64/2, theWidth*0.52, theWidth*0.34, theWidth*0.09)];
    _payPWTextField.backgroundColor = [UIColor whiteColor];
    _payPWTextField.secureTextEntry = YES;
    _payPWTextField.textAlignment = NSTextAlignmentCenter;
    _payPWTextField.placeholder = @"请输入支付密码";
    
    [self.view addSubview:_payPWTextField];
    
    
}

-(void)payBtnAction:(UIButton *)button
{
    if (_userModel.userPayPw == nil) {
        
        [self addAlertView:@"提示" andMessageStr:@"您还未设置支付密码，前往设置" andCancelBtn:@""];
    }
    else{
        if ([_payPWTextField.text isEqualToString:_userModel.userPayPw]) {
            
            [self addActView];
            
            [self performSelector:@selector(delayAction) withObject:nil afterDelay:3.0];
        }
        else{
            [self showMessage:@"密码输入错误"];
        }
       
    }
    
}
#pragma mark 延迟调用
- (void)delayAction{
    
    /** 判断余额够不够*/
    if ((_foodModel.price ? _foodModel.price : _cinemaModel.cinemaLowPrice)*_number > _userModel.userMoney) {
        
          [self addAlertView:@"提示" andMessageStr:@"您的余额不足" andCancelBtn:@"前往充值"];
    }
    else{
         /** 用户扣钱 存档*/
        _userModel.userMoney =   _userModel.userMoney - ((_foodModel.price ? _foodModel.price : _cinemaModel.cinemaLowPrice)*_number);
        
       [[[UserData alloc]init] updateUsersData:_userModel];
        /** 将用户已选商品记录 从未付款中删除*/
        [self deleteWaitPay];
        
         /** 添加到已经付款文件*/
        [self addHadPay];
        
        /**添加未评价*/
        
        
        
        
    }
}
/** 添加文件到 未评价*/
- (void)addNoEvaluate{
    
    /** 将用户要评价的单子 写到文件*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@未评价.txt",_userModel.userPhone];
    NSDictionary *tempDic = @{@"已经付款订单号":[self dateStringWithDate:[NSDate date] DateFormat:@"yyyyMMddHH"],@"图片名称":TheImageTag,@"商品名":TheNameTag,@"总价":[NSNumber numberWithFloat:ThePriceTag*_number],@"数量":[NSNumber numberWithInteger:_number],@"当前评分":[NSNumber numberWithFloat:TheEvaluateScore]};
    
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 在最后添加数据
    [recordDic setObject:tempDic forKey:TheNameTag];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];
    
}
/** 添加到已经付款文件*/
- (void)addHadPay{
    
    /** 将用户已选商品记录写入到文件*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@已付款.txt",_userModel.userPhone];
    NSDictionary *tempDic = @{@"已经付款订单号":[self dateStringWithDate:[NSDate date] DateFormat:@"yyyyMMddHH"],@"图片名称":TheImageTag,@"商品名":TheNameTag,@"总价":[NSNumber numberWithFloat:ThePriceTag*_number],@"数量":[NSNumber numberWithInteger:_number]};
    
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 在最后添加数据
    [recordDic setObject:tempDic forKey:TheNameTag];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];

    
}
#pragma mark 转为日期选择格式
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

/** 将用户已选商品记录 从未付款中删除*/
- (void)deleteWaitPay{
    
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@待支付.txt",_userModel.userPhone];
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 在最后添加数据
    [recordDic removeObjectForKey:_foodModel.foodName ? _foodModel.foodName :_mModel.movieName];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];
}
#pragma mark 底部提示
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
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.73, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel = [[UserModel alloc]init];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
    [self selectModel];
}

- (void)selectModel{
    
    UserData *useData = [[UserData alloc]init];
    for (UserModel *model in [useData selectData]) {
        
        if ([model.userPhone isEqualToString:_userModel.userPhone]) {
            _userModel = model;
            break;
        }
    }
}

#pragma  mark 提示框
- (void)addAlertView:(NSString *)titleStr andMessageStr:(NSString *)messageStr andCancelBtn:(NSString *)cancelStr{
    
    ZLAlertView *zlalertView = [[ZLAlertView alloc]initWithTitle:titleStr message:messageStr];
    if (cancelStr.length != 0) {
        
        [zlalertView addBtnTitle:cancelStr action:^{
            if ([messageStr isEqualToString:@"您的余额不足"]) {                
                RechargeViewController *rechargeCtr = [[RechargeViewController alloc]init];
                rechargeCtr.userModel = _userModel;
                [self.navigationController pushViewController:rechargeCtr animated:YES];
            }
            
        }];
    }
    [zlalertView addBtnTitle:@"确定" action:^{
        
        if ([messageStr isEqualToString:@"您还未设置支付密码，前往设置"]) {
            PayPasswordViewController *payPassCtr = [[PayPasswordViewController alloc]init];
            payPassCtr.userModel = _userModel;
            [self.navigationController pushViewController:payPassCtr animated:YES];
        }
        
    }];
    [zlalertView showAlertWithSender:self];
}
#pragma mark 定时器
- (void)stopActView:(NSTimer *)timer{
    
    UIActivityIndicatorView *actView = timer.userInfo;
    if ([actView isAnimating]) {
        
        [actView stopAnimating];
        
        if ((_foodModel.price ? _foodModel.price : _cinemaModel.cinemaLowPrice)*_number <= _userModel.userMoney){
            ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"支付成功"];
            [alertView addBtnTitle:@"好的" action:^{
                
                 PayDetialViewController *payDetailVCtr = [[PayDetialViewController alloc] init];
                 payDetailVCtr.foodModel = _foodModel;
                 payDetailVCtr.number = _number;
                 payDetailVCtr.mModel = _mModel;
                 payDetailVCtr.cinemaModel = _cinemaModel;
                 [self.navigationController pushViewController:payDetailVCtr animated:YES];
            }];
            [alertView showAlertWithSender:self];
        }
    }
}
#pragma mark 添加菊花
- (void)addActView{
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.backgroundColor = [UIColor grayColor];
    activityView.alpha = 0.5;
    activityView.hidesWhenStopped = YES;
    activityView.frame = CGRectMake(0, 0, theWidth, theHeight);
    [activityView startAnimating];
    self.navigationItem.hidesBackButton = YES;
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopActView:) userInfo:activityView repeats:YES];
    [self.view addSubview:activityView];
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
