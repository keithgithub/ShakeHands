//
//  EditNickNameViewController.m
//  AnjukeBy05Team
//
//  Created by 刘泉 on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "EditNickNameViewController.h"

@interface EditNickNameViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *theEditNickNameTextField;//编辑昵称文本框

@property (weak, nonatomic) IBOutlet UIButton *theSaveNickNameBtn;//保存昵称按钮

- (IBAction)saveEditNickNameAction:(id)sender;//保存昵称按钮事件

@end

@implementation EditNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 添加单击手势 用于取消TextField第一响应者 （光标从TextField离开）
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapAction:)];
    [self.view addGestureRecognizer:oneTap];
    
    // 设置标题
    self.title = @"编辑昵称";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    _theSaveNickNameBtn.layer.cornerRadius = 8.0;//设置圆角button
    _theEditNickNameTextField.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _theEditNickNameTextField.tag = 2101;
    _theEditNickNameTextField.delegate = self;
    
    
    
    // 设置TextField 边框属性
    if (_editModel.userName != nil) {
        self.theEditNickNameTextField.text = _editModel.userName;
    }
    [self.theEditNickNameTextField.layer setCornerRadius:7.0];//设置圆角矩形边框
    self.theEditNickNameTextField.layer.masksToBounds = YES;
    self.theEditNickNameTextField.layer.borderWidth = 1.0;//设置边框粗细
    self.theEditNickNameTextField.layer.borderColor = [UIColor grayColor].CGColor;//设置边框颜色
    self.theEditNickNameTextField.textColor = [UIColor darkGrayColor];
    
    //  self.theEditNickNameText.clearsOnBeginEditing = YES;//开始编辑是清空原来的内容
    
    //  UITextField *textField = (UITextField *)[_theEditNickNameText viewWithTag:2101];
    //  textField.delegate = self;
    
}

#pragma mark oneTapAction 单击触摸事件
//单击手势
- (void)oneTapAction:(UIGestureRecognizer *)oneTap{
    
    NSLog(@"单击触摸了");
    [self.theEditNickNameTextField resignFirstResponder];//编辑昵称TextField 失去第一响应者
    
}

// 将要离开视图的 方法
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;//将要离开视图，显示底部分栏
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

//#warning 修改用户昵称的TextField中 如何实现 限制和判断输入字符串的长度
//  TextField限制只能输入一定长度的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{   //string就是此时输入的那个字符串，textField就是此时正在输入的那个输入框，返回YES就是可以改变输入框的值，NO相反
    
    /*  if ([string isEqualToString:@"\n"]) //按回车可以改变
     {
     return YES;
     }
     
     NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
     
     if (_theEditNickNameTextField == textField)   //判断是否是我们想要限定的那个输入框
     {
     if ([toBeString length] > 15) { //如果输入框内容 大于15 则弹出警告
     
     textField.text = [toBeString substringToIndex:15];
     
     //     + (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;
     
     //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入昵称超过最大长度，请输入2-15个字符的昵称" preferredStyle:UIAlertControllerStyleActionSheet];
     
     //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你输入昵称超过最大长度，请输入2-15个字符的昵称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     //
     //        [alert show];
     
     [self showMessage:@"你输入昵称超过最大长度，请输入2-15个字符的昵称"];
     
     return NO;
     
     }else if ([toBeString length] < 2) { //如果输入框内容 小于2 则弹出警告
     
     textField.text = [toBeString substringToIndex:2];
     
     //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入昵称超过最大长度，请输入2-15个字符的昵称" preferredStyle:UIAlertControllerStyleActionSheet];
     
     
     //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你输入昵称小于最小长度，请输入2-15个字符的昵称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     
     //            [alert show];
     
     [self showMessage:@"你输入昵称小于最小长度，请输入2-15个字符的昵称"];
     
     return NO;
     
     }
     }
     
     return YES;
     */
    NSLog(@"string = %@",string);
    if (_theEditNickNameTextField.text.length >= 15) {
        
        return NO;
    }
    return YES;
    
}


#pragma mark - UITextFieldDelegate 委托代理方法

// 获取第一响应者时调用
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    textField.layer.cornerRadius = 8.0;//设置圆角矩形边框
//    textField.layer.masksToBounds = YES;
//    textField.layer.borderWidth = 2.0f;//设置边框粗细
//    textField.layer.borderColor = [UIColor redColor].CGColor;//设置边框颜色
//
//    return YES;
//}

// 选中textField开始编辑的委托方法（显示手动选中时的效果）
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    textField.text = _editModel.userName;
    [textField.layer setCornerRadius:7.0];//设置圆角矩形边框
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 2.0f;//设置边框粗细
    textField.layer.borderColor = [UIColor orangeColor].CGColor;//设置边框颜色
    
    
}

// 已经结束编辑textField的委托方法 （显示未选中时的效果）
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    //    [textField resignFirstResponder];
    [textField.layer setCornerRadius:7.0];//设置圆角矩形边框
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 1.0f;//设置边框粗细
    textField.layer.borderColor = [UIColor darkGrayColor].CGColor;//设置边框颜色
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// 保存编辑昵称按钮点击事件
- (IBAction)saveEditNickNameAction:(id)sender {
    
    if ([_theEditNickNameTextField.text isEqual: @""]) {
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"来自“http://m.lashou.com”的提示" message:@"昵称不符合规则，请重新输入！"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定。");
            // 底部提示
            [self showMessage:@"昵称不能为空，请您重新输入2-15个字符的昵称"];
            [self shakeAnimationForView:_theEditNickNameTextField.textInputView];
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        [self shakeAnimationForView:_theEditNickNameTextField];
        
        
    } else if (_theEditNickNameTextField.text.length < 2){
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"来自“http://m.lashou.com”的提示" message:@"你的昵称字符长度小于2，请您重新输入2-15个字符的昵称！"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定。");
            // 底部提示
            [self showMessage:@"昵称字符长度太短，请您重新输入2-15个字符的昵称"];
            [self shakeAnimationForView:_theEditNickNameTextField.textInputView];
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        [self shakeAnimationForView:_theEditNickNameTextField];
        
        
    } else if (_theEditNickNameTextField.text.length > 15){
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"来自“http://m.lashou.com”的提示" message:@"你的昵称字符长度大于15，请您重新输入2-15个字符的昵称！"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定。");
            // 底部提示
            [self showMessage:@"昵称字符长度太长，请您重新输入2-15个字符的昵称"];
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
        
    } else {
        
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"来自“http://m.lashou.com”的提示" message:[NSString stringWithFormat:@"你输入的昵称符合规则，昵称名称为：%@",_theEditNickNameTextField.text]];
        
        NSLog(@"------++++++++=======%@", _theEditNickNameTextField.text);
        _editModel.userName = _theEditNickNameTextField.text;
        
        UserData *userData = [[UserData alloc]init];
        
        [userData updateUsersData:_editModel];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            
            //  点击确定按钮的事件
            NSLog(@"确定。");
            // 底部提示
            [self showMessage:[NSString stringWithFormat:@"昵称修改成功，昵称名称为：%@",_theEditNickNameTextField.text]];
            
            // 页面消失 返回个人中心
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
    }
    
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
