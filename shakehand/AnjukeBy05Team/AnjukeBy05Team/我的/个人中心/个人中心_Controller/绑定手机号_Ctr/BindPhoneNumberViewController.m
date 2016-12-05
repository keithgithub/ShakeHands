//
//  BindPhoneNumberViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "BindPhoneNumberViewController.h"


@interface BindPhoneNumberViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *theOldPhoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPhoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *theMessageCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *theGetMessageCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *theConfirmBindBtn;


- (IBAction)inPutOldPhoneNoTextFieldAction:(id)sender;

- (IBAction)inPutNewPhoneNoTextFieldAction:(id)sender;

- (IBAction)inPutMessageCodeTextFieldAction:(id)sender;


- (IBAction)getVerificationCodeAction:(id)sender;

- (IBAction)confirmBindPhoneNoAction:(id)sender;


@end

@implementation BindPhoneNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = @"绑定手机号";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    // 设置圆角幅度 和 边框线
    _theConfirmBindBtn.layer.masksToBounds = YES;
    _theConfirmBindBtn.layer.cornerRadius = 15.0;
    _theGetMessageCodeBtn.layer.masksToBounds = YES;
    _theGetMessageCodeBtn.layer.cornerRadius = 5.0;
    
    
    _theOldPhoneNoTextField.delegate = self;
    _theNewPhoneNoTextField.delegate = self;
    _theMessageCodeTextField.delegate = self;
    
    
    _theConfirmBindBtn.enabled = NO;
    _theConfirmBindBtn.backgroundColor = [UIColor grayColor];
    
    //  _theConfirmBindBtn.layer.borderWidth = 0.5;
    //    _theConfirmBindBtn.userInteractionEnabled = NO;
    
    //    NSInteger i;
    //    i = _theOldPhoneNoTextField.text.length;
    //    NSLog(@"长度 i = %ld " , i);
    
    
    //更改 确定button按钮 可否点击 和 颜色 透明度
    
    //    if(_theOldPhoneNoTextField.text.length == 0) {
    //
    //        [self changeIsCanClickButton:_theConfirmBindBtn andButtonEnabled:NO andButtonColor:[UIColor grayColor] andButtonAlpha:0.4];
    //
    //    }else if(_theOldPhoneNoTextField.text.length == 11) {
    
    [self changeIsCanClickButton:_theConfirmBindBtn andButtonEnabled:YES andButtonColor:[UIColor orangeColor] andButtonAlpha:1.0];
    
    //    }
    
    //更改 获取验证码button按钮 可否点击 和 颜色 透明度
    
    //    if (_theOldPhoneNoTextField.text.length == 11) {
    //
    //        [self changeIsCanClickButton:_theGetMessageCodeBtn andButtonEnabled:NO andButtonColor:[UIColor grayColor] andButtonAlpha:0.4];
    //
    //    } else if(_theOldPhoneNoTextField.text.length != 0){
    
    //if ([self isPhoneNo:_theOldPhoneNoTextField.text] && [self isPhoneNo:_theNewPhoneNoTextField.text])
    [self changeIsCanClickButton:_theGetMessageCodeBtn andButtonEnabled:YES andButtonColor:[UIColor colorWithRed:50/255.0 green:240/255.0 blue:225/255.0 alpha:1.0] andButtonAlpha:1.0];
    
    //    }
    
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
//
////原绑定手机号的TextField点击事件
//- (IBAction)inPutOldPhoneNoTextFieldAction:(id)sender {
//
//    //键盘设置
//    _theOldPhoneNoTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
//    _theOldPhoneNoTextField.keyboardType = UIKeyboardTypeNumberPad;
//    _theOldPhoneNoTextField.returnKeyType = UIReturnKeyDefault;
//
//
//
////    BOOL isPhone = [self isPhoneNo:_theOldPhoneNoTextField.text];
//
//    if ([_theOldPhoneNoTextField.text isEqual: @""]) {
//
//        [self showMessage:@"请输入原手机号"];
//
//    }else if ( _theOldPhoneNoTextField.text.length > 0) {
//
//        if ([self isPhoneNo:_theOldPhoneNoTextField.text] == NO && _theOldPhoneNoTextField.text.length != 11) {
//
//            [self showMessage:@"原手机号格式错误，请重新输入"];
//
//        }else if (![_theOldPhoneNoTextField.text isEqual: _userModel.userPhone] && _theOldPhoneNoTextField.text.length == 11) {
//
//            [self showMessage:@"原手机号输入有误，请重新输入"];
//        }
//
//    }
//}

////新绑定手机号的TextField点击事件
//- (IBAction)inPutNewPhoneNoTextFieldAction:(id)sender {
//
//    //键盘设置
//    _theNewPhoneNoTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
//    _theNewPhoneNoTextField.keyboardType = UIKeyboardTypeNumberPad;
//    _theNewPhoneNoTextField.returnKeyType = UIReturnKeyDefault;
//
//    BOOL newisPhone= [self isPhoneNo:_theNewPhoneNoTextField.text];
////  BOOL oldisPhone= [self isPhoneNo:_theOldPhoneNoTextField.text];
//
//    if ([_theNewPhoneNoTextField.text isEqual:@""]) {
//
//        [self showMessage:@"请填写您的手机号"];
//
//    }else if ( _theNewPhoneNoTextField.text.length > 0) {
//
//        if (newisPhone == NO) {
//
//            [self showMessage:@"新手机号格式错误，请重新输入"];
//        }
//
//    }
//
//    else if (![_theOldPhoneNoTextField.text isEqual: @"18805920099"] && _theOldPhoneNoTextField.text.length > 0) {
//
//        if (_theOldPhoneNoTextField.text.length == 11 ) {
//
//            if (oldisPhone == NO) {
//
//                 [self showMessage:@"原手机号输入有误，请重新输入"];
//            }
//
//        }else {
//
//            [self showMessage:@"原手机号位数有误，请重新输入11位原手机号"];
//
//        }
//
//    }

//}
//
////短信验证码的TextField点击事件
//- (IBAction)inPutMessageCodeTextFieldAction:(id)sender {
//
//    //键盘设置
//    _theMessageCodeTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
//    _theMessageCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
//    _theMessageCodeTextField.returnKeyType = UIReturnKeyDefault;
//
//
//    if(_theMessageCodeTextField.text.length == 0){
//
//        [self showMessage:@"请输入您收到的短信验证码"];
//    }
//
//
//}


//获取短信验证码 按钮点击事件
- (IBAction)getVerificationCodeAction:(id)sender {
    
    if (![_theOldPhoneNoTextField.text isEqual:_userModel.userPhone]) {
        
        [self showMessage:@"原手机号码输入错误"];
        [self shakeAnimationForView:_theOldPhoneNoTextField];
        
    }  else if ([_theNewPhoneNoTextField.text isEqual:_userModel.userPhone]) {
        // _theOldPhoneNoTextField.text 原绑定手机号 需要一个属性传值 此处测试使用一个写死的数据 18805920099
        
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"获取验证码" message:[NSString stringWithFormat:@"新手机号码：%@ 已被绑定，无需重新绑定，请重新输入！",_theNewPhoneNoTextField.text]];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定。");
            // 底部提示
            [self showMessage:@"请输入没有被绑定的手机号"];
            [self shakeAnimationForView:_theNewPhoneNoTextField];
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        [self shakeAnimationForView:_theNewPhoneNoTextField.textInputView];
        
        
    } else {
        
        [self showMessage:[NSString stringWithFormat:@"验证码已发送至你的新手机号：%@",_theNewPhoneNoTextField.text]];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_theNewPhoneNoTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                [self showMessage:[NSString stringWithFormat:@"获取验证码失败 %@",error]];
                
            }else{
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
                [_theGetMessageCodeBtn setTitle:@"重新获取"forState:UIControlStateNormal];
                _theGetMessageCodeBtn.userInteractionEnabled =YES;
                _theGetMessageCodeBtn.backgroundColor = [UIColor cyanColor];
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击的灰色
                _theGetMessageCodeBtn.backgroundColor = [UIColor grayColor];
                _theGetMessageCodeBtn.userInteractionEnabled =NO;
                //设置界面的按钮显示根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_theGetMessageCodeBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime]forState:UIControlStateNormal];
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
    _theConfirmBindBtn.enabled = YES;
    _theConfirmBindBtn.backgroundColor = [UIColor orangeColor];
}

#pragma mark 绑定手机号确定按钮 点击事件
// 新手机号的 确认绑定 按钮点击事件
- (IBAction)confirmBindPhoneNoAction:(id)sender {
    
    if (_theOldPhoneNoTextField.text.length == 0) {
        
        if (_theNewPhoneNoTextField.text.length == 0 ) {
            
            [self showMessage:@"你没有输入手机号，请输入绑定手机号"];
            [self shakeAnimationForView:_theNewPhoneNoTextField];
            [self shakeAnimationForView:_theOldPhoneNoTextField];
            
            
        } else {
            
            [self showMessage:@"你未输入原绑定手机，请输入原绑定手机号"];
            [self shakeAnimationForView:_theOldPhoneNoTextField];
            
        }
        
    } else if (_theOldPhoneNoTextField.text.length > 0 ) {
        
        if (_theNewPhoneNoTextField.text.length == 0 ) {
            
            [self showMessage:@"你未输入新手机号，请输入新绑定手机号"];
            [self shakeAnimationForView:_theNewPhoneNoTextField];
            
        } else if (_theNewPhoneNoTextField.text.length > 0) {
            
            if ([self isPhoneNo:_theOldPhoneNoTextField.text] == NO) {
                
                if ([self isPhoneNo:_theNewPhoneNoTextField.text] == NO) {
                    
                    [self showMessage:@"手机号格式错误，请输入正确的手机号"];
                    [self shakeAnimationForView:_theNewPhoneNoTextField.textInputView];
                    [self shakeAnimationForView:_theOldPhoneNoTextField.textInputView];
                    
                }  else {
                    
                    [self showMessage:@"原绑定手机号格式错误，请输入原绑定手机号"];
                    [self shakeAnimationForView:_theOldPhoneNoTextField.textInputView];
                    
                }
                
            } else if ([self isPhoneNo:_theOldPhoneNoTextField.text] == YES) {
                
                if ([self isPhoneNo:_theNewPhoneNoTextField.text] == NO) {
                    
                    [self showMessage:@"新绑定手机号格式错误，请输入正确的新手机号"];
                    [self shakeAnimationForView:_theNewPhoneNoTextField.textInputView];
                    
                }  else if ([_theOldPhoneNoTextField isEqual:_theOldPhoneNoTextField.text ]) {
                    
                    [self showMessage:@"输入的手机号已经绑定，请重新输入新手机号"];
                    [self shakeAnimationForView:_theNewPhoneNoTextField.textInputView];
                    
                } else if (_theMessageCodeTextField.text.length == 0 ) {
                    
                    [self showMessage:@"验证码为空，请输入四位数验证码"];
                    [self shakeAnimationForView:_theNewPhoneNoTextField];
                    
                }
                
            }
        }
        
    }
    
    
    
    [SMSSDK commitVerificationCode:_theMessageCodeTextField.text phoneNumber:_theNewPhoneNoTextField.text zone:@"86" result:^(NSError *error) {
        
        if (error) {
            //            [self showMessage:@"验证码错误"];
            [self shakeAnimationForView:_theMessageCodeTextField];
        }
        else{
            UserModel *newModel = [[UserModel alloc]init];
            UserData *userData = [[UserData alloc]init];
            
            [userData deleteUser:_userModel];
            NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_userModel.userPhone];
            UIImage *tempImage = [UIImage imageWithContentsOfFile:filePath];
            NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.5);
            
            
            NSString *filePathTxt = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",_userModel.userPhone];
            NSArray *tempArr = [NSArray arrayWithContentsOfFile:filePathTxt];
            
            newModel = _userModel;
            newModel.userPhone = _theNewPhoneNoTextField.text;
            
            
            [userData insertUsersData:newModel];
            NSString *fileNewPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",newModel.userPhone];
            [imageData writeToFile:fileNewPath atomically:NO];
            
            NSString *fileNewPathTxt = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",newModel.userPhone];
            [tempArr writeToFile:fileNewPathTxt atomically:NO];
            
            [self showMessage:@"手机绑定成功"];
            
            NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
            [userDeafaults setObject:newModel.userPhone forKey:@"user"];
            [userDeafaults setInteger:1 forKey:@"login"];
            
            [self performSelector:@selector(popCtr) withObject:nil afterDelay:1.0];
        }
    }];
    
    
        
}
#pragma mark 延迟返回
- (void)popCtr{
    
    [self.navigationController popViewControllerAnimated:YES];
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

// 判断手机号 封装的 私有方法
- (BOOL)isPhoneNo:(id)phoneNo
{
    //手机号以13，14，15，17，18开头，加九个 \d 数字字符
    //    NSString *phoneFormat = @"^1[3,4,5,7,8]\\d{9}$";
    //    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    //    BOOL isPhone= [phoneCheck evaluateWithObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
    
    //正则表达式 判断是否是手机号
    NSString *phoneFormat = @"^1[3,4,5,7,8]\\d{9}$";
    //使用正则表达式定义谓词 用于手机号匹配判读
    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    //输入的手机号字段与手机格式匹配对比判断
    BOOL isPhone= [phoneCheck evaluateWithObject:phoneNo];
    
    return isPhone;//返回匹配后的值
    
}

// 更改button按钮的可否点击和颜色显示 封装的 私有方法
- (void)changeIsCanClickButton:(UIButton *)button andButtonEnabled:(BOOL)isEnable andButtonColor:(UIColor *)color andButtonAlpha:(CGFloat)alpha
{
    [button setEnabled:isEnable];//设置button按钮是否可以被点击
    button.backgroundColor = color;//改变button按钮背景颜色
    button.alpha = alpha;//改变button按钮的透明度
}



@end
