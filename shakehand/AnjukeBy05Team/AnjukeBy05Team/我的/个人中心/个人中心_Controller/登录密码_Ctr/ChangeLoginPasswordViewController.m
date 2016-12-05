//
//  ChangeLoginPasswordViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ChangeLoginPasswordViewController.h"

@interface ChangeLoginPasswordViewController ()
{
    
    NSString *userLoginPasswordStr;
    
}


@property (weak, nonatomic) IBOutlet UITextField *theOldLoginPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewLoginPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theConfirmLoginPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *theSureChangeLoginPasswordBtn;

- (IBAction)sureChangeLoginPasswordAction:(id)sender;

@end

@implementation ChangeLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = @"修改登录密码";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    // 设置密码输入隐藏字符
    _theOldLoginPasswordTextField.secureTextEntry = YES;
    _theNewLoginPasswordTextField.secureTextEntry = YES;
    _theConfirmLoginPasswordTextField.secureTextEntry = YES;
    
    // 设置圆角Button按钮
    _theSureChangeLoginPasswordBtn.layer.cornerRadius = 8.0;
    
    // 测试用户登录密码
    
    NSLog(@"_userModel ddddddddddd %@",_userModel);
    userLoginPasswordStr = _userModel.userLoginPw;
    
    
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

// 确认修改登录密码 按钮点击事件
- (IBAction)sureChangeLoginPasswordAction:(id)sender {
    
    
    if ([_theOldLoginPasswordTextField.text isEqual: @""]) {
        
        [self showMessage:@"原密码不能为空，请输入原密码"];
        [self shakeAnimationForView:_theOldLoginPasswordTextField];
        
    } else if ([_theOldLoginPasswordTextField.text isEqualToString:userLoginPasswordStr] == NO && _theOldLoginPasswordTextField.text.length > 0){
        
        [self showMessage:@"原密码输入错误，请重新输入"];
        [self shakeAnimationForView:_theOldLoginPasswordTextField];
        
    } else {
        
        if ([_theNewLoginPasswordTextField.text isEqual: @""]) {
            
            [self showMessage:@"新密码不能为空，请输入新密码"];
            [self shakeAnimationForView:_theNewLoginPasswordTextField];
            
        } else if ( [self isLoginPasswordNo:_theNewLoginPasswordTextField.text] == NO ){
            
            [self showMessage:@"新密码必须为6位任意数字和字母组合，请重新输入"];
            [self shakeAnimationForView:_theNewLoginPasswordTextField.textInputView];
            
        } else {
            
            if ([_theConfirmLoginPasswordTextField isEqual: @""]) {
                
                [self showMessage:@"确认新密码不能为空，请确认新密码"];
                [self shakeAnimationForView:_theNewLoginPasswordTextField];
                
            } else if ([_theNewLoginPasswordTextField.text isEqual: _theConfirmLoginPasswordTextField.text] == NO) {
                
                [self showMessage:@"两次新密码输入不一致，请重新输入"];
                [self shakeAnimationForView:_theConfirmLoginPasswordTextField];
                [self shakeAnimationForView:_theNewLoginPasswordTextField];
                
            } else {
                
                if ([_theNewLoginPasswordTextField.text isEqual:_theOldLoginPasswordTextField.text]) {
                    
                    [self showMessage:@"新密码不能与原密码相同，请重新输入新密码"];
                    [self shakeAnimationForView:_theNewLoginPasswordTextField.textInputView];
                    
                } else if ([_theConfirmLoginPasswordTextField.text isEqual: _userModel.userPayPw]) {
                    
                    [self showMessage:@"登录密码不能与支付密码相同，请重新输入新密码"];
                    [self shakeAnimationForView:_theNewLoginPasswordTextField];
                    [self shakeAnimationForView:_theConfirmLoginPasswordTextField.textInputView];
                    
                } else {
                    
                    userLoginPasswordStr = _theConfirmLoginPasswordTextField.text;
                    NSLog(@"userLoginPasswordStr = %@ ",userLoginPasswordStr);
                    // 新密码保存到数据库
                    _userModel.userLoginPw = _theConfirmLoginPasswordTextField.text;
                    
                    UserData *userData = [[UserData alloc]init];
                    
                    [userData updateUsersData:_userModel];
                    
                    //  1、创建对象
                    ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"登录密码修改成功"];
                    
                    //  2、添加按钮
                    [alertView addBtnTitle:@"确定" action:^{
                        //  点击确定按钮的事件
                        //页面返回个人中心
                        [self.navigationController popViewControllerAnimated:YES];
                        // 底部提示
                        //                    [self showMessage:[NSString stringWithFormat:@"用户登录密码修改成功 %@",userLoginPasswordStr]];
                    }];
                    
                    //  3、显示
                    
                    [alertView showAlertWithSender:self];
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark 判断输入的密码格式
// 判断“6位或6位以上的数字和字母组合 区分大小写” 封装的 私有方法
- (BOOL)isLoginPasswordNo:(id)loginPasswordStr
{
    //手机号以13，14，15，17，18开头，加九个 \d 数字字符
    //    NSString *phoneFormat = @"^1[3,4,5,7,8]\\d{9}$";
    //    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    //    BOOL isPhone= [phoneCheck evaluateWithObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
    
    //正则表达式
    NSString *loginPwdFormat = @"^(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$";
    //使用正则表达式定义谓词 用于格式匹配判读
    NSPredicate *loginPwdCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",loginPwdFormat];
    //输入的字段与要求格式匹配对比判断
    BOOL isLoginPasswordNo= [loginPwdCheck evaluateWithObject:loginPasswordStr];
    
    return isLoginPasswordNo;//返回匹配后的值
    
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
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.5, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:4.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


@end
