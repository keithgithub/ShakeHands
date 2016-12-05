//
//  TransView.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/17.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "TransView.h"

@implementation TransView
{
    UIView *transView;
    
    UIButton *backButton;
    UIButton *transButton;
    UIButton *collectButton;
    UIButton *moreButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    self = [super init];
    if (self) {
        // 在主视图下边 添加新视图
        transView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0.5*theHeight, theWidth, 0.5*theHeight)];
        //    transView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64)];
        transView.backgroundColor = [UIColor whiteColor];
        [self addSubview:transView];
        // 在新视图上添加 按钮
        [self addCtrs];
        //    AddCtrsViewController *addCtrViewCtr = [[AddCtrsViewController alloc] init];
        //    [addCtrViewCtr addctr]
        // 在主视图上边 添加透明灰色按钮
        _graybutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.5*theHeight-64)];
        _graybutton.backgroundColor = [UIColor blackColor];
        _graybutton.alpha = 0.2;
        
//        [_graybutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_graybutton];
    }
    return self;
}
//-(void)doTrans;
//{
//    // 按钮不能点击
//    backButton.enabled = NO;
//    transButton.enabled = NO;
//    collectButton.enabled = NO;
//    moreButton.enabled = NO;
//    // 在主视图下边 添加新视图
//    transView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0.5*theHeight, theWidth, 0.5*theHeight)];
////    transView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64)];
//    transView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:transView];
//    // 在新视图上添加 按钮
//    [self addCtrs];
//    //    AddCtrsViewController *addCtrViewCtr = [[AddCtrsViewController alloc] init];
//    //    [addCtrViewCtr addctr]
//    // 在主视图上边 添加透明灰色按钮
//    UIButton *graybutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.5*theHeight-64)];
//    graybutton.backgroundColor = [UIColor blackColor];
//    graybutton.alpha = 0.2;
//    graybutton.tag =101;
//    [graybutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:graybutton];
//    
//}
//
// 在新视图上添加按钮 函数
-(void)addCtrs
{
    // 短信转发按钮
    ZRButton *SMSButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    SMSButton.frame = CGRectMake(theWidth*0.075, transView.frame.size.height/15, theWidth*0.18,transView.frame.size.height*0.289);
    [SMSButton setTitle:@"短信" forState: UIControlStateNormal];
    [SMSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SMSButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [SMSButton setImage:[UIImage imageNamed:@"share_logo_sms"] forState:UIControlStateNormal];
    [transView addSubview:SMSButton];
    // 微信转发按钮
    ZRButton *WXButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WXButton.frame = CGRectMake(theWidth*0.405, transView.frame.size.height/15, theWidth*0.18,transView.frame.size.height*0.289);
    [WXButton setTitle:@"微信" forState: UIControlStateNormal];
    [WXButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WXButton setImage:[UIImage imageNamed:@"share_logo_weixin"] forState:UIControlStateNormal];
    [transView addSubview:WXButton];
    // 微信朋友圈转发按钮
    ZRButton *WXFriendsButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WXFriendsButton.frame = CGRectMake(theWidth*0.735, transView.frame.size.height/15, theWidth*0.18,transView.frame.size.height*0.289);
    [WXFriendsButton setTitle:@"朋友圈" forState: UIControlStateNormal];
    [WXFriendsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXFriendsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WXFriendsButton setImage:[UIImage imageNamed:@"share_logo_weixinFriends"] forState:UIControlStateNormal];
    [transView addSubview:WXFriendsButton];
    // 新浪微博转发按钮
    ZRButton *WBXLButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WBXLButton.frame = CGRectMake(theWidth*0.075, transView.frame.size.height*0.422, theWidth*0.18,transView.frame.size.height*0.289);
    [WBXLButton setTitle:@"微博" forState: UIControlStateNormal];
    [WBXLButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WBXLButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WBXLButton setImage:[UIImage imageNamed:@"share_logo_xinlang"] forState:UIControlStateNormal];
    [transView addSubview:WBXLButton];
    // 腾讯微博转发按钮
    ZRButton *WBTXButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WBTXButton.frame =CGRectMake(theWidth*0.405, transView.frame.size.height*0.422, theWidth*0.18,transView.frame.size.height*0.289);
    [WBTXButton setTitle:@"腾讯微博" forState: UIControlStateNormal];
    [WBTXButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WBTXButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WBTXButton setImage:[UIImage imageNamed:@"share_logo_tengxun"] forState:UIControlStateNormal];
    [transView addSubview:WBTXButton];
    
    // 取消按钮
    _cancelButton = [UIButton buttonWithType: UIButtonTypeCustom ];
    _cancelButton.frame =CGRectMake(theWidth*0.075, transView.frame.size.height*0.788, theWidth*0.85,transView.frame.size.height*0.155);
    [_cancelButton setTitle:@"取消" forState: UIControlStateNormal];
    _cancelButton.backgroundColor = [UIColor lightGrayColor];
    _cancelButton.alpha = 0.5;
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    _cancelButton.layer.cornerRadius = 0.02*_cancelButton.frame.size.width;
    _cancelButton.layer.masksToBounds = YES;
    
    [_cancelButton addTarget:self action:@selector(buttonAction) forControlEvents: UIControlEventTouchUpInside];
    [transView addSubview:_cancelButton];
    
}

// 在主视图上边 添加透明灰色按钮 事件
-(void)buttonAction
{
  
    [_graybutton removeFromSuperview];
    [transView removeFromSuperview];
    
//    backButton.enabled = YES;
//    transButton.enabled = YES;
//    collectButton.enabled = YES;
//    moreButton.enabled = YES;
    
}


@end
