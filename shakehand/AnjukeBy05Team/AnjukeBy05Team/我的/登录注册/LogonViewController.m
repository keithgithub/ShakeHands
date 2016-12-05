//
//  LogonViewController.m
//  项目--我的
//
//  Created by etcxm on 16/6/8.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "LogonViewController.h"
#import "RegisterViewController.h"
#import "UserModel.h"
#import "UserData.h"

#define TheFastButton  8888
#define TheLoginButton 9999
#define TheViewTag     6666

@interface LogonViewController ()<UITextFieldDelegate>
{
    UITextField *_fastCodeTextField;
    UITextField *_fastTextField;
    UIButton *_codeButton;
}
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)LoginBtnAction:(id)sender;

@end

static int i;
static int j;

@implementation LogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    i = 0;
    j = 1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIColor *color = [[UIColor alloc]initWithWhite:0.8 alpha:0.5];
    view.backgroundColor = color;
    [self.view addSubview:view];
    
    [self.view bringSubviewToFront:_loginBtn];
    _loginBtn.backgroundColor = [UIColor orangeColor];
    //登录、注册界面
    self.title = @"登录";
    
    //注册按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style: UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 添加手势
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panAction)];
    swipGes.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGes];
    
    // 添加登录按钮
    [self addLoginButtonAction];
    
}
#pragma mark 添加平移手势
- (void)panAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 快速登录 和账号登录按钮
- (void)addLoginButtonAction{
    
    //快速登录按钮
    UIButton *fastButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, (theWidth/2-0.5), 60)];
    fastButton.tag = TheFastButton;
    fastButton.backgroundColor = [UIColor whiteColor];
    [fastButton setTitle:@"快速登录" forState: UIControlStateNormal];
    [fastButton setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
    
    [fastButton addTarget:self action:@selector(fastAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:fastButton];
    
    //快速登录与账号登录中间的分割线
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/2, 64, 1, 60)];
    imageView3.image = [UIImage imageNamed:@"bg_conditionBarItem_line"];
    [self.view addSubview:imageView3];
    
    //账号登录按钮
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake((theWidth/2+1), 64, (theWidth/2-0.5), 60)];
    loginButton.tag = TheLoginButton;
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"账号登录" forState: UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    // 快速登录输入框
    [self _fastTextField:YES andFirstPlaceholder:@"输入手机号码" andSecondFirstPlaceholder:@"输入验证码"];

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 121, theWidth/2, 3)];
    bottomView.tag = TheViewTag;
    bottomView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:bottomView];
    
}


#pragma mark 点击事件
//注册事件
-(void)rightAction
{
    RegisterViewController *registerViewCtr = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewCtr animated:YES];
}
//快速登录事件
-(void)fastAction:(UIButton *)fastButton
{
    if (i == 1) {
        [self _fastTextField:YES andFirstPlaceholder:@"输入手机号码" andSecondFirstPlaceholder:@"输入验证码"];
        _fastCodeTextField.secureTextEntry = NO;
        [fastButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        UIButton *button = [self.view viewWithTag:TheLoginButton];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *botmView = [self.view viewWithTag:TheViewTag];
        botmView.transform = CGAffineTransformMakeTranslation(0, 0);
        NSLog(@"--------%d--",j);
        j++;
        i=0;
    }
   
}
// 账号登录事件
- (void)loginButtonAction:(UIButton *)loginButton
{
    if (j == 1) {
       [self _fastTextField:NO andFirstPlaceholder:@"用户名/邮箱/手机号" andSecondFirstPlaceholder:@"输入密码"];
        [loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _fastCodeTextField.secureTextEntry = YES;
        UIButton *button = [self.view viewWithTag:TheFastButton];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *botmView = [self.view viewWithTag:TheViewTag];
        botmView.transform = CGAffineTransformMakeTranslation(theWidth/2, 0);
        NSLog(@"-----_++++++++---%d--",i);
        i++;
        j=0;
    }

}
// 快速登录输入框
- (void)_fastTextField:(BOOL)isFastOrNumb andFirstPlaceholder:(NSString *)firstPlaceholder andSecondFirstPlaceholder:(NSString *)secondPlaceholder
{
    //输入手机号输入框
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 134, theWidth, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 5;
    phoneView.layer.masksToBounds = YES;
    _fastTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, theWidth-10, 44)];
    _fastTextField.backgroundColor = [UIColor whiteColor];
    [_fastTextField becomeFirstResponder];
    _fastTextField.borderStyle = UITextBorderStyleNone;
    _fastTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _fastTextField.keyboardType = UIKeyboardTypePhonePad;
    _fastTextField.placeholder = firstPlaceholder;
    // 当textField有文字时，点击开始编辑时，将清除文字
    _fastTextField.clearsOnBeginEditing = YES;
    _fastTextField.returnKeyType = UIReturnKeyGo;
    _fastTextField.delegate = self;
    //输入验证码输入框
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 183, theWidth, 44)];
    codeView.backgroundColor = [UIColor whiteColor];
    codeView.layer.cornerRadius = 5;
    codeView.layer.masksToBounds = YES;
    _fastCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 250, 44)];
    _fastCodeTextField.placeholder = secondPlaceholder;
    _fastCodeTextField.borderStyle = UITextBorderStyleNone;
    _fastCodeTextField.keyboardType = UIKeyboardTypeDefault;
     _fastCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _fastCodeTextField.returnKeyType = UIReturnKeyGo;
    _fastCodeTextField.delegate = self;
    [codeView addSubview:_fastCodeTextField];
    [phoneView addSubview:_fastTextField];
    [self.view addSubview:codeView];
    [self.view addSubview:phoneView];
    if (isFastOrNumb) {
        UIView *codeButton = [self rightBtnAndSwitch:YES];
        [codeView addSubview:codeButton];
    }
    else{
        UIView *codeButton = [self rightBtnAndSwitch:NO];
        [codeView addSubview:codeButton];
    }


}

// 输入密码右侧的 按钮 和 开关
- (UIView *)rightBtnAndSwitch:(BOOL)isBtn{
    
    if (isBtn) {
        _codeButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 6, 110,33)];
        _codeButton.backgroundColor = [UIColor cyanColor];
        _codeButton.layer.cornerRadius = 18;
        _codeButton.layer.masksToBounds = YES;
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTintColor:[UIColor blackColor]];
        _codeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_codeButton addTarget:self action:@selector(codeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        return _codeButton;
    }
    else{
        
        UISwitch *rightSwt = [[UISwitch alloc]initWithFrame:CGRectMake(300, 6, 100,33)];
        rightSwt.on = NO;
        rightSwt.onTintColor = [UIColor redColor];
        rightSwt.tintColor = [UIColor greenColor];
        [rightSwt addTarget:self action:@selector(rightSwtAction:) forControlEvents:UIControlEventValueChanged];
        return rightSwt;
    }
    
}
// 开关事件
- (void)rightSwtAction:(UISwitch *)pwSwt{
    
    if (pwSwt.isOn) {
        
        NSLog(@"123");
        _fastCodeTextField.secureTextEntry = NO;
    }
    else{
        _fastCodeTextField.secureTextEntry = YES;
    }
    
}

//开始编辑的时候，调用的委托方法  return YES才能编辑  return NO不能输入
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    
    return YES;
}
//键盘返回按钮的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];//去键盘
    return YES;
    
}
//获取验证码事件
-(void)codeButtonAction
{
    BOOL isResult = [self checkOutIsRegister];
    if (isResult) {
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_fastTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            
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
       //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(sendCode:) userInfo:nil repeats:NO];
    //倒计时时间
    __block int timeout=60;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){//倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                [_codeButton setTitle:@"重新获取"forState:UIControlStateNormal];
                _codeButton.userInteractionEnabled =YES;
                _codeButton.backgroundColor = [UIColor cyanColor];
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击的灰色
                _codeButton.backgroundColor = [UIColor grayColor];
                _codeButton.userInteractionEnabled =NO;
                //设置界面的按钮显示根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_codeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime]forState:UIControlStateNormal];
                [UIView commitAnimations];
            });
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);

}
//定时器事件
-(void)sendCode:(NSTimer*)timer
{
    [self.view bringSubviewToFront:_loginBtn];
    _loginBtn.enabled = YES;
    _loginBtn.backgroundColor = [UIColor orangeColor];
}

- (IBAction)LoginBtnAction:(id)sender {
    
    UserData *userData = [[UserData alloc]init];
    NSMutableArray *userArr = [userData selectData];
    if ( j == 0) {
        for (UserModel *model in userArr) {
            
            if ([_fastTextField.text isEqualToString:model.userPhone] && [_fastCodeTextField.text isEqualToString:model.userLoginPw]) {
                
                NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
                [userDeafaults setObject:model.userPhone forKey:@"user"];
                [userDeafaults setInteger:1 forKey:@"login"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"成功登录" object:model];
                [self.navigationController popViewControllerAnimated:NO];
                return;
            }
        }
        [self addAlertView:@"" andMessageStr:@"账号或密码输入错误" andCancelBtn:@""];

    }
    if (i == 0) {
        [SMSSDK commitVerificationCode:_fastCodeTextField.text phoneNumber:_fastTextField.text zone:@"86" result:^(NSError *error) {
            //         打印信息   成功为空
            NSLog(@"errr = %@",error);
            if (error) {
                [self addAlertView:@"" andMessageStr:@"验证码错误" andCancelBtn:@""];
            }
            else{
                for (UserModel *model in userArr) {
                    
                    if ([_fastTextField.text isEqualToString:model.userPhone]){
                        
                        NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
                        [userDeafaults setObject:model.userPhone forKey:@"user"];
                        [userDeafaults setInteger:1 forKey:@"login"];
                        
                        [userDeafaults synchronize];
                        [self.navigationController popViewControllerAnimated:NO];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"成功登录" object:model];
                        return;
                    }
                }
            }
        }];
    }
    
  
 
}

- (void)showAlertView:(NSString *)message{
    
    ZLAlertView *zlAlertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:message];
    [zlAlertView addBtnTitle:@"好的" action:^{
        
    }];
    [zlAlertView showAlertWithSender:self];
}
#pragma mark 监测号码是否已经注册
- (BOOL)checkOutIsRegister{
    
    UserData *userData = [[UserData alloc]init];
    NSMutableArray *userArr = [userData selectData];
    for (UserModel *model in userArr) {
        
        if ([_fastTextField.text isEqualToString:model.userPhone]) {
            
            return YES;
            
        }
    }
    [self addAlertView:@"" andMessageStr:@"该号码未注册，前往注册" andCancelBtn:@"取消"];
    return NO;
}
#pragma  mark 提示框
- (void)addAlertView:(NSString *)titleStr andMessageStr:(NSString *)messageStr andCancelBtn:(NSString *)cancelStr{
    
    ZLAlertView *zlalertView = [[ZLAlertView alloc]initWithTitle:titleStr message:messageStr];
    if (cancelStr.length != 0) {
        
        [zlalertView addBtnTitle:cancelStr action:^{
            
        }];
    }
    [zlalertView addBtnTitle:@"确定" action:^{
        
        if ([messageStr isEqualToString:@"该号码未注册，前往注册"]) {
            RegisterViewController *registerCtr = [[RegisterViewController alloc]init];
            [self.navigationController pushViewController:registerCtr animated:YES];
        }
   
    }];
    
    [zlalertView showAlertWithSender:self];
}

@end
