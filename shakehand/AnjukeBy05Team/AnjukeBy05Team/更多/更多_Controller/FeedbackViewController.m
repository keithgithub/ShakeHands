//
//  FeedbackViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/7.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MoreViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    UILabel *_textLabel;//设置全局变量 用于在TextView上添加这个Label可以在外部设置是否隐藏
}
@property (weak, nonatomic) IBOutlet UITextView *theFeedbackTextView;
@property (weak, nonatomic) IBOutlet UITextField *theFeedbackTextField;

- (IBAction)theFeedbackTextFieldAction:(id)sender;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航栏背景颜色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//导航栏返回按钮颜色
    
    //自定义发送按钮
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];//设置按钮标题名称
    [sendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];//设置按钮标题颜色
    sendButton.frame = CGRectMake(0, 0, 40, 20);//设置按钮大小
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];//添加按钮点击事件
    //用自定义的发送按钮 创建一个导航栏右按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    //将创建的导航栏右按钮rightBarButtonItem 添加到导航栏
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.theFeedbackTextView.tag = 6001;
    self.theFeedbackTextField.tag = 6002;
    
    // 设置TextView 边框属性
    [self.theFeedbackTextView.layer setCornerRadius:7.0];//设置圆角矩形边框
    self.theFeedbackTextView.layer.masksToBounds = YES;
    self.theFeedbackTextView.layer.borderWidth = 1.0;//设置边框粗细
    self.theFeedbackTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;//设置边框颜色
    
    self.theFeedbackTextView.clearsOnInsertion = YES;
    
    UITextView *textView = [[UITextView alloc]init];
    textView = _theFeedbackTextView;
    textView.text = @"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议";
    textView.textColor = [UIColor grayColor];
    
    textView.delegate = self;//设置代理对象
    
    
    // 在TextView 上面添加一个 Label 用于输入意见反馈内容
    //    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //    _textLabel.text = @"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议";
    //    _textLabel.textColor = [UIColor grayColor];
    //    _textLabel.textAlignment = NSTextAlignmentLeft;
    //    _textLabel.numberOfLines = 0;
    //    [textView addSubview:_textLabel];
    
    // 设置TextField 边框属性
    [self.theFeedbackTextField.layer setCornerRadius:7.0];//设置圆角矩形边框
    self.theFeedbackTextField.layer.masksToBounds = YES;
    self.theFeedbackTextField.layer.borderWidth = 1.0;//设置边框粗细
    self.theFeedbackTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;//设置边框颜色
    self.theFeedbackTextField.clearsOnBeginEditing = YES;//开始编辑是清空原来的内容
    
    UITextField *textField = (UITextField *)[_theFeedbackTextField viewWithTag:6002];
    textField.delegate = self;
    textView.editable = YES;
}

//- (void)viewDidLayoutSubviews
//{
//    _textLabel.text = @"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议";
//    _textLabel.textColor = [UIColor grayColor];
//}


// 将要离开视图的 方法
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;//将要离开视图，显示底部分栏
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

#pragma mark sendAction 发送事件

- (void)sendAction
{
    NSLog(@"发送反馈信息。");
    
    if ([_theFeedbackTextView.text isEqual: @""]||[_theFeedbackTextView.text isEqual: @"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议"]) {
        NSLog(@"内容不能为空！");
        
        //内容为空 跳出提示框
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"" message:@"内容不能为空！"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"请重新输入！");
            
            //  底部提示
            [self showMessage:@"请输入反馈内容再发送！"];
            
        }];
        //  3、显示
        [alertView showAlertWithSender:self];
        
        
    }else{
        //  底部提示
        [self showMessage:@"反馈信息发送成功！"];
        [self.navigationController popViewControllerAnimated:YES];//返回上级页面
        
    }
}

//  设置textView的placeholder
//  UITextView上如何加上类似于UITextField的placeholder呢，其实在UITextView上加上一个UILabel或者UITextView，如果用UILable的话，会出现一个问题就是当placeholder的文字过长导致换行的时候就会出现问题，而用UITextView则可以有效避免此问题。
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    if (![text isEqualToString:@""])
    //    {
    //        _textLabel.hidden = YES;
    //    }
    //
    //    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    //    {
    //        _textLabel.hidden = NO;
    //    }
    
    return YES;
    
}
//  说明如下：
//  (1) _placeholderLabel 是加在UITextView后面的UITextView，_placeholderLabel要保证和真正的输入框的设置一样，字体设置成浅灰色，然后[_placeholderLabel setEditable:NO];真正的输入框要设置背景色透明，保证能看到底部的_placeholderLabel。
//  (2) [text isEqualToString:@""] 表示输入的是退格键
//  (3) range.location == 0 && range.length == 1 表示输入的是第一个字符

// 将要进入textView开始编辑的委托方法（显示默认选中的效果 ）
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议"]) {
        textView.text = @"";
    }
    return YES;
}

// 选中textView开始编辑的委托方法（显示手动选中时的效果）
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //    textView = _theFeedbackTextView;
    //    textView.editable = YES;
    [textView.layer setCornerRadius:7.0];//设置圆角矩形边框
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 2.0f;//设置边框粗细
    textView.layer.borderColor = [UIColor orangeColor].CGColor;//设置边框颜色
    //    textView.clearsOnInsertion = YES;
    //    _textLabel.hidden = YES;
    
    if ([textView.text isEqualToString:@"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议"]) {
        textView.text = @"";
    }
}

// 已经结束编辑textView的委托方法 （显示未选中时的效果）
- (void)textViewDidEndEditing:(UITextView *)textView
{
    //    textView = _theFeedbackTextView;
    [textView.layer setCornerRadius:7.0];//设置圆角矩形边框
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 1.0f;//设置边框粗细
    textView.layer.borderColor = [UIColor darkGrayColor].CGColor;//设置边框颜色
    
    if (textView.text.length<1) {
        textView.text = @"请描述您在客户端使用中遇到的问题，我们很期待您的意见和建议";
    }
    
}


//  改变字体的行间距
- (void)textViewDidChange:(UITextView *)textView
{
    //    textview 静态改变字体的行间距
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.lineSpacing = 10;// 字体的行间距
    //
    //    NSDictionary *attributes = @{
    //                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
    //                                 NSParagraphStyleAttributeName:paragraphStyle
    //                                 };
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:@"输入你的内容" attributes:attributes];
    
    //    textview 动态改变字体的行间距
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

//点击 UITextView 输入文字时，光标都从最初点开始
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    // textView.selectedRange = NSMakeRange(textView.text.length,0);
}

// 选中textField开始编辑的委托方法（显示手动选中时的效果）
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    textField = _theFeedbackTextField;
    [textField.layer setCornerRadius:7.0];//设置圆角矩形边框
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 2.0f;//设置边框粗细
    textField.layer.borderColor = [UIColor orangeColor].CGColor;//设置边框颜色
    //  textField.clearsOnBeginEditing = YES;//开始编辑清空数据
    
}

// 已经结束编辑textField的委托方法 （显示未选中时的效果）
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField = _theFeedbackTextField;
    [textField.layer setCornerRadius:7.0];//设置圆角矩形边框
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 1.0f;//设置边框粗细
    textField.layer.borderColor = [UIColor darkGrayColor].CGColor;//设置边框颜色
    //  textField.text = @"联系电话、QQ或电子邮箱（选填）";
    //  textField.textColor = [UIColor darkGrayColor];
}

// 未选中时的 效果
- (IBAction)theFeedbackTextFieldAction:(id)sender {
    
    //    [self.theFeedbackTextField.layer setCornerRadius:7.0];//设置圆角矩形边框
    //    self.theFeedbackTextField.layer.masksToBounds = YES;
    //    self.theFeedbackTextField.layer.borderWidth = 1.0;//设置边框粗细
    //    self.theFeedbackTextField.layer.borderColor = [UIColor grayColor].CGColor;//设置边框颜色
    //    self.theFeedbackTextField.text = @"联系电话、QQ或电子邮箱（选填）";
    //    self.theFeedbackTextField.textColor = [UIColor darkGrayColor];
    
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
