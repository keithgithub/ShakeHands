//
//  RechargeViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()//<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumb;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
- (IBAction)rechargeBtnAction:(id)sender;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值";
    

    _money.keyboardType = UIKeyboardTypeNumberPad;
    _money.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumb.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumb.keyboardType = UIKeyboardTypeNumberPad;
    _passWord.secureTextEntry = YES;
    _passWord.returnKeyType = UIReturnKeyDone;
    
    _rechargeBtn.enabled = NO;
    _rechargeBtn.backgroundColor = [UIColor grayColor];
 
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    
    [_passWord resignFirstResponder];
    _rechargeBtn.enabled = YES;
    _rechargeBtn.backgroundColor = [UIColor orangeColor];
    return YES;
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
#pragma mark 充值按钮
- (IBAction)rechargeBtnAction:(id)sender {
    
    self.navigationItem.hidesBackButton = YES;

    UserData *userData = [[UserData alloc]init];
    if ([_userModel.userPhone isEqualToString:_phoneNumb.text] && [_userModel.userLoginPw isEqualToString:_passWord.text] && ([_money.text floatValue] > 0) && ([_money.text floatValue] < 10000)) {
        
        _userModel.userMoney = [_money.text floatValue] +  _userModel.userMoney;
        [userData updateUsersData:_userModel];
        
        [self addActView];
        /** 将充值记录写入到文件*/
        NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",_userModel.userPhone];
        
        NSString *recordStr = [NSString stringWithFormat:@"%@ \n支付宝账号: %@ 成功充值: %.2f元",[self dateStringWithDate:[NSDate date] DateFormat:@"yyyy-MM-dd  HH:mm:ss"],_userModel.userPhone,[_money.text floatValue]];
        // 读取 数据  转为可变
        NSMutableArray *recordArr = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
        // 在最后添加数据
        [recordArr addObject:recordStr];
        //写入文件
        [recordArr writeToFile:filePath atomically:NO];
        return;
    } 
    ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"充值错误，检查输入内容"];
    [alertView addBtnTitle:@"好的" action:^{
        
    }];
    [alertView showAlertWithSender:self];

}
#pragma mark 转为日期选择格式
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}
#pragma mark 定时器
- (void)stopActView:(NSTimer *)timer{
    
    UIActivityIndicatorView *actView = timer.userInfo;
    if ([actView isAnimating]) {
        
        [actView stopAnimating];
        ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"充值成功"];
        [alertView addBtnTitle:@"好的" action:^{
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView showAlertWithSender:self];
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
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopActView:) userInfo:activityView repeats:YES];
    [self.view addSubview:activityView];
}

@end
