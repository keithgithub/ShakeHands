//
//  RegisterViewController.m
//  项目--我的
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZLAlertView.h"
#import <SMS_SDK/SMSSDK.h>
#import "MyViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    
    UIButton * _receiveCheckNumButton;//验证码倒计时按钮
    UITextField *_codeTextField;//验证码
    UITextField *_passWordTextField;//密码
    UITextField *_passWordTextField1; //  确认密码
    UITextField *_phoneNumTextField;  // 手机号码输入框
}

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)registerBtnAction:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIColor *color = [[UIColor alloc]initWithWhite:0.8 alpha:0.5];
    view.backgroundColor = color;
    [self.view addSubview:view];
    
    [self.view bringSubviewToFront:_registerBtn];
    _registerBtn.enabled = YES;
    _registerBtn.backgroundColor = [UIColor orangeColor];

    self.title = @"注册";
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //输入手机号输入框
    UIView *PhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 25, 375, 44)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    _phoneNumTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, 260, 44)];
    _phoneNumTextField.backgroundColor = [UIColor whiteColor];
    [_phoneNumTextField becomeFirstResponder];
    _phoneNumTextField.borderStyle = UITextBorderStyleNone;
    _phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumTextField.placeholder = @"  输入手机号";
     _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTextField.returnKeyType = UIReturnKeyGo;
    _phoneNumTextField.delegate = self;
    //获取验证码 按钮
    _receiveCheckNumButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 110, 33)];
    _receiveCheckNumButton.backgroundColor = [UIColor grayColor];
    _receiveCheckNumButton.enabled = NO;
    [_receiveCheckNumButton setTitle: @"获取验证码" forState:UIControlStateNormal];
    [_receiveCheckNumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _receiveCheckNumButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _receiveCheckNumButton.layer.cornerRadius =18;
    _receiveCheckNumButton.layer.masksToBounds =YES;
    [_receiveCheckNumButton addTarget:self action:@selector(receiveCheckNumButtonAction)forControlEvents:UIControlEventTouchUpInside];
    
    [PhoneView addSubview:_phoneNumTextField];
    [PhoneView addSubview:_receiveCheckNumButton];
    //输入短信验证码输入框
    _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 70, 375, 44)];
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextField.placeholder = @"  输入短信验证码";
//    [_codeTextField becomeFirstResponder];
    _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _codeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    _codeTextField.clearsOnBeginEditing = YES;
    _codeTextField.returnKeyType = UIReturnKeyGo;
//    fastCodeTextField.delegate = self;
    //设置登录密码
    UIView *passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, 375, 44)];
    passWordView.backgroundColor = [UIColor whiteColor];
    _passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, 300, 44)];
    _passWordTextField.placeholder = @"  请设置登录密码";
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.borderStyle = UITextBorderStyleNone;
    _passWordTextField.keyboardType = UIKeyboardTypeDefault;
    _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWordTextField.returnKeyType = UIReturnKeyGo;
    //开关按钮
    UISwitch *rightSwt = [[UISwitch alloc]initWithFrame:CGRectMake(300, 5, 100,44)];
    rightSwt.on = YES;
    rightSwt.onTintColor = [UIColor greenColor];
    rightSwt.tintColor = [UIColor grayColor];
    [rightSwt addTarget:self action:@selector(rightSwtAction:) forControlEvents:UIControlEventValueChanged];
    
    [passWordView addSubview:_passWordTextField];
    [passWordView addSubview:rightSwt];
    //确认登录密码
    _passWordTextField1 = [[UITextField alloc]initWithFrame:CGRectMake(0, 160, 375, 44)];
    _passWordTextField1.placeholder = @"  确认登录密码";
    _passWordTextField1.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField1.keyboardType = UIKeyboardTypeDefault;
    _passWordTextField1.secureTextEntry = YES;
    _passWordTextField1.returnKeyType = UIReturnKeyGo;
    _passWordTextField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview: PhoneView];
    [self.view addSubview:_codeTextField];
    [self.view addSubview: passWordView];
    [self.view addSubview:_passWordTextField1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取验证码点击事件
-(void)receiveCheckNumButtonAction{

    BOOL isResult = [self checkOutIsRegister];
    if (isResult) {
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            
            NSLog(@"error -= %@",error);  //         打印信息   成功为空
            if (error) {
                NSLog(@"----");
                [self addAlertView:@"" andMessageStr:@"请输入正确的手机号码" andCancelBtn:@""];
            }
            else{
                [self setTimeToGeteCode];
            }
        }];
    }
}
#pragma mark 添加获取验证码的定时器
- (void)setTimeToGeteCode{
    NSLog(@"++--");
    
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(sendCode:) userInfo:nil repeats:NO];
    //倒计时时间
    __block int timeout = 60;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){//倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                [_receiveCheckNumButton setTitle:@"重新获取"forState:UIControlStateNormal];
                _receiveCheckNumButton.userInteractionEnabled =YES;
                _receiveCheckNumButton.backgroundColor = [UIColor cyanColor];
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击的灰色
                _receiveCheckNumButton.backgroundColor = [UIColor grayColor];
                _receiveCheckNumButton.userInteractionEnabled =NO;
                //设置界面的按钮显示根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_receiveCheckNumButton setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime]forState:UIControlStateNormal];
                [UIView commitAnimations];
            });
            timeout--;
        }
        
    });
    dispatch_resume(_timer);

}


// 开关事件
- (void)rightSwtAction:(UISwitch *)pwSwt{
    if (pwSwt.isOn) {
 
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField1.secureTextEntry = YES;
    }
    else{
        
        _passWordTextField.secureTextEntry = NO;
        _passWordTextField1.secureTextEntry = NO;
    }
    
}
//定时器事件
-(void)sendCode:(NSTimer*)timer
{
    [self.view bringSubviewToFront:_registerBtn];
    _registerBtn.enabled = YES;
    _registerBtn.backgroundColor = [UIColor orangeColor];
}

#pragma mark 手机输入框的委托
- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    NSLog(@"string = %@",string);
    NSString *checkString;
    if (range.location == 11) {
        return NO;
    }else{
        
        if (![string isEqualToString:@""]) {
            
            checkString=[_phoneNumTextField.text stringByAppendingString:string];
        }else{
            
            checkString=[_phoneNumTextField.text stringByDeletingLastPathComponent];
        }
        
        if (checkString.length == 11) {

            _receiveCheckNumButton.enabled= YES;
            _receiveCheckNumButton.backgroundColor = [UIColor cyanColor];
      
            
        }else{
            
            _receiveCheckNumButton.enabled= NO;
            _receiveCheckNumButton.backgroundColor = [UIColor grayColor];
        }
        return YES;
    }

 

 
    return YES;
}
#pragma  mark 提示框
- (void)addAlertView:(NSString *)titleStr andMessageStr:(NSString *)messageStr andCancelBtn:(NSString *)cancelStr{
    
    ZLAlertView *zlalertView = [[ZLAlertView alloc]initWithTitle:titleStr message:messageStr];
    if (cancelStr.length != 0) {
        
        [zlalertView addBtnTitle:cancelStr action:^{
            
        }];
    }
    [zlalertView addBtnTitle:@"确定" action:^{
        
    }];

    [zlalertView showAlertWithSender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerBtnAction:(id)sender {
   
    
    NSLog(@"````````````` %ld",_phoneNumTextField.text.length);
    if (_phoneNumTextField.text.length != 11) {
        
         [self addAlertView:@"" andMessageStr:@"请输入正确手机号码" andCancelBtn:@""];
    }
    else{
        
        if([_passWordTextField.text isEqualToString:_passWordTextField1.text]){
            
            if( _passWordTextField.text.length < 6){
                
                [self addAlertView:@"" andMessageStr:@"密码位数必须大于6位" andCancelBtn:@""];
            }
            else{
                [SMSSDK commitVerificationCode:_codeTextField.text phoneNumber:_phoneNumTextField.text zone:@"86" result:^(NSError *error) {
                    //         打印信息   成功为空
                    NSLog(@"errr = %@",error);
                    if (error) {
                        [self addAlertView:@"" andMessageStr:@"验证码错误" andCancelBtn:@""];
                    }
                    else{
                        
                        [self addActView];
                        [self performSelector:@selector(performAction) withObject:nil afterDelay:3.0];
                       
                        
                    }
                }];
            }
        }
        else{
            
            [self addAlertView:@"" andMessageStr:@"两次输入的密码不一样" andCancelBtn:@""];
            
        
        }
        
    }
}
#pragma mark 延迟调用
- (void)performAction{
    
    UserData *userData = [[UserData alloc]init];
    UserModel *useModel = [[UserModel alloc]init];
    useModel.userPhone = _phoneNumTextField.text;
    useModel.userLoginPw = _passWordTextField.text;
    [userData insertUsersData:useModel];
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    [userDeafaults setObject:useModel.userPhone forKey:@"user"];
    [userDeafaults setInteger:1 forKey:@"login"];
    [userDeafaults synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"成功登录" object:useModel];
}


#pragma mark 监测号码是否可以注册
- (BOOL)checkOutIsRegister{
    
    UserData *userData = [[UserData alloc]init];
    NSMutableArray *userArr = [userData selectData];
    for (UserModel *model in userArr) {
        
        if ([_phoneNumTextField.text isEqualToString:model.userPhone]) {
            
            [self addAlertView:@"" andMessageStr:@"该号码已注册，可直接登录" andCancelBtn:@""];
            return NO;
            
        }
    }
    return YES;
}
#pragma mark 定时器
- (void)stopActView:(NSTimer *)timer{
    
    UIActivityIndicatorView *actView = timer.userInfo;
    if ([actView isAnimating]) {
        
        [actView stopAnimating];
        ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"注册成功"];
        [alertView addBtnTitle:@"好的" action:^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alertView showAlertWithSender:self];
    }
}
#pragma mark 添加菊花
- (void)addActView{
    
    self.navigationItem.hidesBackButton = YES;
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











