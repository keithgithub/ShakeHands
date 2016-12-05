//
//  PayPasswordViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PayPasswordViewController.h"
#import "ChangeLoginPasswordViewController.h"

@interface PayPasswordViewController ()
{
    
    NSString *userPayPassword;
    
}

@property (weak, nonatomic) IBOutlet UILabel *theCurrentBindPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *theInputMessageVeriCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *theSetPayPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theConfirmPayPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *theGetMessageVeriCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *theSurePayPasswordBtn;

- (IBAction)clickInputMessageCodeTextFieldAction:(id)sender;
- (IBAction)clickSetPayPasswordTextFieldAction:(id)sender;
- (IBAction)clickCorfirmPayPasswordTextFieldAction:(id)sender;


- (IBAction)getMessageVeriCodeAction:(id)sender;
- (IBAction)surePayPasswordAction:(id)sender;

@end

@implementation PayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = @"设置支付密码";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    _theSurePayPasswordBtn.enabled = NO;
    _theSurePayPasswordBtn.backgroundColor = [UIColor grayColor];
    // 手机号中间四位 隐藏实现
    _theCurrentBindPhoneLabel.text = [_userModel.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];;
    
    //设置安全输入密码 输入字符以点号代替
    _theSetPayPasswordTextField.secureTextEntry = YES;
    _theConfirmPayPasswordTextField.secureTextEntry = YES;
    
    
    // 设置圆角Button按钮
    _theGetMessageVeriCodeBtn.layer.cornerRadius = 8.0;
    _theSurePayPasswordBtn.layer.cornerRadius = 15.0;
    
    UITapGestureRecognizer *oneTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapAction)];
    [self.view addGestureRecognizer:oneTapGes];
    
    
}
#pragma mark 点击去除键盘
- (void)oneTapAction{
    
    [_theConfirmPayPasswordTextField resignFirstResponder];
    [_theInputMessageVeriCodeTextField resignFirstResponder];
    [_theSetPayPasswordTextField resignFirstResponder];
    
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

//点击 输入短息验证码 TextField 点击事件
- (IBAction)clickInputMessageCodeTextFieldAction:(id)sender {
    
    if (_theInputMessageVeriCodeTextField.text.length == 0) {
        
        [self showMessage:@"短信验证码不能为空，请您重新输入"];
        
    }
    
    
}

//点击 设置支付密码 TextField 点击事件
- (IBAction)clickSetPayPasswordTextFieldAction:(id)sender {
    
    if (_theSetPayPasswordTextField.text.length == 0) {
        
        [self showMessage:@"支付密码不能为空，请输入支付密码"];
        
    }
    
    
}

//点击 确认支付密码 TextField 点击事件
- (IBAction)clickCorfirmPayPasswordTextFieldAction:(id)sender {
    
    if (_theConfirmPayPasswordTextField.text.length == 0) {
        
        [self showMessage:@"确认支付密码不能为空，请输入确认密码"];
        
    }
    
}

//获取验证码 按钮点击事件
- (IBAction)getMessageVeriCodeAction:(id)sender {
    
    [self showMessage:@"验证码发送成功"];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_userModel.userPhone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if(error){
            [self showMessage:@"验证码发送限制"];
        }else{
            [self setTimeToGeteCode];
        }
    }];
    
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
                [_theGetMessageVeriCodeBtn setTitle:@"重新获取"forState:UIControlStateNormal];
                _theGetMessageVeriCodeBtn.userInteractionEnabled =YES;
                _theGetMessageVeriCodeBtn.backgroundColor = [UIColor cyanColor];
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击的灰色
                _theGetMessageVeriCodeBtn.backgroundColor = [UIColor grayColor];
                _theGetMessageVeriCodeBtn.userInteractionEnabled =NO;
                //设置界面的按钮显示根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_theGetMessageVeriCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime]forState:UIControlStateNormal];
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
    _theSurePayPasswordBtn.enabled = YES;
    _theSurePayPasswordBtn.backgroundColor = [UIColor orangeColor];
}


//确认支付密码 确认按钮点击事件
- (IBAction)surePayPasswordAction:(id)sender {
    
    if (_theSetPayPasswordTextField.text.length == 0 || _theConfirmPayPasswordTextField.text.length == 0) {
        
        [self showMessage:@"支付密码不能为空，请输入6位以上的支付密码"];
        [self shakeAnimationForView:_theSetPayPasswordTextField.textInputView];
        [self shakeAnimationForView:_theConfirmPayPasswordTextField.textInputView];
        
    } else if ([self isPayPassword:_theSetPayPasswordTextField.text] == NO){
        
        [self showMessage:@"请输入6位或6位以上的数字和字母组合的支付密码"];
        [self shakeAnimationForView:_theSetPayPasswordTextField.textInputView];
        
    } else if ([_theConfirmPayPasswordTextField.text isEqual:_theSetPayPasswordTextField.text] == NO){
        
        [self showMessage:@"两次支付密码输入不一致，请重新输入"];
        [self shakeAnimationForView:_theConfirmPayPasswordTextField.textInputView];
        
    } else if ([_theConfirmPayPasswordTextField.text isEqual: _userModel.userLoginPw]){
        
        [self showMessage:@"支付密码不能与登录密码相同，请重新输入"];
        [self shakeAnimationForView:_theConfirmPayPasswordTextField.textInputView];
        [self shakeAnimationForView:_theSetPayPasswordTextField.textInputView];
        
    } else if ([_theConfirmPayPasswordTextField.text isEqual: _userModel.userPayPw]){
        
        [self showMessage:@"新支付密码不能与原支付密码相同，请重新输入"];
        [self shakeAnimationForView:_theConfirmPayPasswordTextField.textInputView];
        [self shakeAnimationForView:_theSetPayPasswordTextField.textInputView];
        
    } else {
        [SMSSDK commitVerificationCode:_theInputMessageVeriCodeTextField.text phoneNumber:_userModel.userPhone zone:@"86" result:^(NSError *error) {
            
            if (error) {
                [self showMessage:@"验证码错误"];
            }
            else{
                _userModel.userPayPw = _theConfirmPayPasswordTextField.text;
                UserData *userData = [[UserData alloc]init];
                [userData updateUsersData:_userModel];
                [self showMessage:@"支付密码设置成功"];
                [self performSelector:@selector(popCtr) withObject:nil afterDelay:1.0];
            }
        }];
        
    }
    
}

#pragma mark 延迟返回
- (void)popCtr{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 判断“6位或6位以上的数字和字母组合 区分大小写” 封装的 私有方法
- (BOOL)isPayPassword:(id)payPasswordStr
{
    //手机号以13，14，15，17，18开头，加九个 \d 数字字符
    //    NSString *phoneFormat = @"^1[3,4,5,7,8]\\d{9}$";
    //    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    //    BOOL isPhone= [phoneCheck evaluateWithObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
    
    //正则表达式 判断格式：任意 数字和字母（必须包含数字和字母）6位或6位以上
    NSString *payPwdFormat = @"^(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$";
    //使用正则表达式定义谓词 用于格式匹配判断
    NSPredicate *payPwdCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",payPwdFormat];
    //输入的字段与要求格式匹配对比判断
    BOOL isPayPassword= [payPwdCheck evaluateWithObject:payPasswordStr];
    
    return isPayPassword;//返回匹配后的值
    
}


#pragma mark 抖动动画
// 错误输入 抖动效果 提示
- (void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    [animation setAutoreverses:YES];
    
    // 设置时间
    [animation setDuration:.06];
    
    // 设置次数
    [animation setRepeatCount:3];
    
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
    
}


// 底部提示
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
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.83, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


@end
