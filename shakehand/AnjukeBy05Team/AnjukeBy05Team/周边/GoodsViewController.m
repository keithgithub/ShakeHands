//
//  GoodsViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsPayViewController.h"
#import "StrikeThroughLabel.h"
#import "LogonViewController.h"
#import "UserModel.h"


#define ButtonSize 29

@interface GoodsViewController ()
{
    UIView *headView;// 顶部的导航视图
    UILabel *headViewLable;// 顶部的导航视图上的Lable
    UIButton *collectButton;// 收藏按钮
    UIButton *transButton ;// 转发按钮
    UITableView *theTableView;// 表视图
    UIScrollView *theScrollView;
    UIButton *backButton; // 返回按钮
    UIView *transView;//// 在主视图下边 添加新视图
    
#pragma mark  06.22 update
    UserModel *userModel;
    
    
    NSMutableArray *_foodArry;// 临时的三张图片
}

@end

#pragma mark  06.22 update
static BOOL isLogin;

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
   

    
    //底部的“立即购买”视图--->SectionFooter
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, theHeight-0.15*theWidth, theWidth, 0.15*theWidth)];
    //_footView.backgroundColor = [UIColor grayColor];
    [self addCtrToFootView:footView];
    [self.view addSubview:footView];
    // 表视图
    theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight -0.15*theWidth) style:UITableViewStyleGrouped ];
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [self.view addSubview:theTableView];
    
    // 顶部的导航视图
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 64)];
    headView.backgroundColor = [UIColor clearColor];
    //headView.alpha = 0.5;
    [self addCtrToHeadView:headView];
    [self.view addSubview:headView];
}
#pragma mark视图即将出现


//当界面出现时
-(void)viewWillAppear:(BOOL)animated
{
    // 隐藏导航栏 bar
    self.navigationController.navigationBarHidden = YES;
    
#pragma mark  06.22 update
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    userModel = [[UserModel alloc]init];
    userModel.userPhone = [userDeafaults objectForKey:@"user"];
    isLogin = [userDeafaults integerForKey:@"login"] ;
}
//当界面消失时
-(void)viewWillDisappear:(BOOL)animated
{
    // 放开导航栏 bar
    self.navigationController.navigationBarHidden = NO;
    
}

// 向底部视图 footView 添加内容
-(void)addCtrToFootView:(UIView *)view
{
    // 立即购买按钮
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(0.61*theWidth, 0, 0.39*theWidth, view.frame.size.height);
    [payButton setTitle:@"立即购买" forState:UIControlStateNormal];
    payButton.backgroundColor = [UIColor orangeColor];
    [payButton addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:payButton];
    // 价格Lable
    UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.02*theWidth, 0.25*theWidth, 0.12*theWidth)];
    theLable.text = [NSString stringWithFormat:@"￥%ld",self.model.price];
    theLable.textColor = [UIColor orangeColor];
    theLable.font = [UIFont boldSystemFontOfSize:23];
    [view addSubview:theLable];
    // 划线价格
    StrikeThroughLabel *strikeThLable = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(0.3*theWidth, 0.05*theWidth, 0.15*theWidth, 0.04*theWidth)];
    strikeThLable.alpha = 0.7;
    strikeThLable.font = [UIFont systemFontOfSize:10];
    strikeThLable.text =[NSString stringWithFormat:@"￥%0.0f",self.model.price*1.5];
    strikeThLable.strikeThroughEnabled = YES;
    [view addSubview:strikeThLable];
    // 门店价
    UILabel *theDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.31*theWidth, 0.08*theWidth, 0.15*theWidth, 0.04*theWidth)];
    theDetailLable.alpha = 0.7;
    theDetailLable.font = [UIFont systemFontOfSize:10];
    theDetailLable.text = @"门市价";
    [view addSubview:theDetailLable];
    
}
// 向顶部的导航视图 添加内容
-(void)addCtrToHeadView:(UIView *)view
{
    // 返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.04*theWidth, ButtonSize, ButtonSize, ButtonSize);
    [backButton setImage:[UIImage imageNamed:@"goodsDetail_custom_back_btn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
    
    // 收藏按钮
    
    collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0.75*theWidth, ButtonSize, ButtonSize, ButtonSize);
    
    [collectButton addTarget:self action:@selector(collectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark  06.22 update
//---------->>>>>>
    /** 判断收藏按钮是否点亮 */
    // 文件路径
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",userModel.userPhone];
    // 取出文件中的字典
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    NSString *isLoadStr = [[recordDic objectForKey:self.model.foodName] lastObject];
    [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal ];
    if ([isLoadStr integerValue]) {
        [collectButton setImage:[UIImage imageNamed:@"goodsDetail_custom_like_btn_selected"] forState:UIControlStateNormal];
        [collectButton setTitle:@"1" forState:UIControlStateNormal];
    }else
    {
        [collectButton setImage:[UIImage imageNamed:@"goodsDetail_custom_like_btn_normal"] forState:UIControlStateNormal];
        [collectButton setTitle:@"2" forState:UIControlStateNormal];
    }
//---------->>>>>>
    [view addSubview:collectButton];
    // 转发按钮
    transButton = [UIButton buttonWithType:UIButtonTypeCustom];
    transButton.frame = CGRectMake(0.87*theWidth, ButtonSize, ButtonSize, ButtonSize);
    [transButton setImage:[UIImage imageNamed:@"goodsDetail_custom_share_btn"] forState:UIControlStateNormal];
    [transButton addTarget:self action:@selector(transBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    [view addSubview:transButton];;
    
}
#pragma mark backButton 返回按钮事件
-(void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark collectButton 收藏按钮事件
//收藏按钮事件

#pragma mark  06.22 update
// -------->>>>
-(void)collectBtnAction:(UIButton *)sender
{
    if (!isLogin) {
        LogonViewController *loginCtr = [[LogonViewController alloc]init];
        [self.navigationController pushViewController:loginCtr animated:YES];
        return;
    }
    
    if ([collectButton.titleLabel.text isEqualToString:@"1"]) {
        collectButton.selected = NO;
        [collectButton setTitle:@"2" forState:UIControlStateNormal];
        [collectButton setImage:[UIImage imageNamed:@"goodsDetail_custom_like_btn_normal"] forState:  UIControlStateNormal];
        [self showMessage:@"取消收藏"];
        NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",userModel.userPhone];
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]] ;
        
        [recordDic removeObjectForKey:self.model.foodName];
        [recordDic writeToFile:filePath atomically:NO];
        
        
    }else
    {
        collectButton.selected = YES;
        [collectButton setTitle:@"1" forState:UIControlStateNormal];
        [collectButton setImage:[UIImage imageNamed:@"goodsDetail_custom_like_btn_selected"] forState:UIControlStateNormal];
        [self showMessage:@"收藏成功"];
        /** 将收藏记录写入到文件*/
        NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",userModel.userPhone];
    
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]] ;
        NSString *str = @"1";
        /** FoodModel 中的商品名称，imageName，图片名称，地址，类型 */
        NSArray *FoodModelArray = @[self.model.foodName,self.model.style,self.model.address,self.model.imageName,str];
        [recordDic setValue:FoodModelArray forKey:self.model.foodName];
        [recordDic writeToFile:filePath atomically:NO];
        
    }
}
// 底部提示
- (void)showMessage:(NSString *)message
{
    //UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor]; showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 13.0f;
    showview.layer.masksToBounds = YES;
    //[window addSubview:showview];
    [self.view addSubview:showview];
    
    UILabel *label = [[UILabel alloc] init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize: CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];   label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;   label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];    //设置底部提示视图位置和大小
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.83-64, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
//----------->>>
#pragma mark  06.22 update


#warning 没有完成封装
#pragma mark 转发按钮事件
-(void)transBtnAction:(UIButton *)sender
{
    
    // 按钮不能点击
    collectButton.enabled = NO;
    transButton.enabled = NO;
    backButton.enabled = NO;
 

        // 在主视图下边 添加新视图
        transView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0.5*theHeight, theWidth, 0.5*theHeight)];
        transView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:transView];
        // 在新视图上添加 按钮
        [self addCtrs];
        //    AddCtrsViewController *addCtrViewCtr = [[AddCtrsViewController alloc] init];
        //    [addCtrViewCtr addctr]
        // 在主视图上边 添加透明灰色按钮
        UIButton *graybutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.5*theHeight)];
        graybutton.backgroundColor = [UIColor blackColor];
        graybutton.alpha = 0.2;
        graybutton.tag =101;
        [graybutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:graybutton];
    }
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
        UIButton *cancelButton = [UIButton buttonWithType: UIButtonTypeCustom ];
        cancelButton.frame =CGRectMake(theWidth*0.075, transView.frame.size.height*0.788, theWidth*0.85,transView.frame.size.height*0.155);
        [cancelButton setTitle:@"取消" forState: UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor lightGrayColor];
        cancelButton.alpha = 0.5;
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        cancelButton.layer.cornerRadius = 0.02*cancelButton.frame.size.width;
        cancelButton.layer.masksToBounds = YES;
        [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside];
        [transView addSubview:cancelButton];
        
    }


// 在主视图上边 添加透明灰色按钮 事件
-(void)buttonAction:(UIButton *)sender
{
    UIButton *graybutton = [self.view viewWithTag:101];
    [graybutton removeFromSuperview];
    [transView removeFromSuperview];
    backButton.enabled = YES;
    transButton.enabled = YES;
    collectButton.enabled = YES;
    
    
}
#pragma mark  transView.graybutton 事件按钮
-(void)buttonAction
{
    collectButton.enabled = YES;
    transButton.enabled = YES;
    backButton.enabled = YES;
    [transView removeFromSuperview];
    
}

#pragma mark payButton 购买按钮事件
-(void)payBtnAction:(UIButton *) sender
{
    if (isLogin) {
        GoodsPayViewController *goodsPayViewCtr = [[GoodsPayViewController alloc] init];
        goodsPayViewCtr.model = self.model;
        [self.navigationController pushViewController:goodsPayViewCtr animated:YES];

    }else
    {
        LogonViewController *logonVCtr = [[LogonViewController alloc] init];
        [self.navigationController pushViewController:logonVCtr animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark 表视图的委托和数据源事件
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 4;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 1;
    
    }else if (section == 2)
    {
        return 2;
    }else
    {
        return 2;
    }
}

// 创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if (indexPath.section == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *theImageView1 = [[UIImageView alloc]initWithFrame: CGRectMake(0.04*theWidth, 0.04*theWidth, 0.04*theWidth, 0.04*theWidth)];
            theImageView1 .image = [UIImage imageNamed:@"evaluateSuccess"];
            [cell.contentView addSubview:theImageView1];
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0.085*theWidth, 0.045*theWidth, 0.1*theWidth, 0.03*theWidth)];
            lable1.alpha = 0.6;
            lable1.font = [UIFont systemFontOfSize:10];
            lable1.text = @"随时退";
            [cell.contentView addSubview:lable1];
            UIImageView *theImageView2 = [[UIImageView alloc]initWithFrame: CGRectMake(0.235*theWidth, 0.04*theWidth, 0.04*theWidth, 0.04*theWidth)];
            theImageView2 .image = [UIImage imageNamed:@"evaluateSuccess"];
            [cell.contentView addSubview:theImageView2];
            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0.28*theWidth, 0.045*theWidth, 0.1*theWidth, 0.03*theWidth)];
            lable2.alpha = 0.6;
            lable2.font = [UIFont systemFontOfSize:10];
            lable2.text = @"过期退";
            [cell.contentView addSubview:lable2];
        }else if (indexPath.section == 1)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i = 0; i < 5; i ++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.04*theWidth+0.045*theWidth*i, 0.04*theWidth, 0.04*theWidth, 0.04*theWidth)];
                imageView.image = [UIImage imageNamed:@"evaluate_star_grey"];
                [cell.contentView addSubview:imageView];
            }
            UILabel *detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.6*theWidth, 0.045*theWidth, 0.35*theWidth, 0.03*theWidth)];
            detailLable.alpha = 0.6;
            detailLable.font = [UIFont systemFontOfSize:12];
            detailLable.text = [NSString stringWithFormat:@"%ld人评价",self.model.pjNum];
            detailLable.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:detailLable];
            
        }else if (indexPath.section == 2)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.035*theWidth, 0.03*theWidth, 0.2*theWidth, 0.06*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.text = @"商家信息";
                [cell.contentView addSubview:theLable];
            }else
            {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.04*theWidth, 0.3*theWidth, 0.06*theWidth)];
            lable1.font = [UIFont systemFontOfSize:14];
            lable1.text = self.model.foodName;
            [cell.contentView addSubview:lable1];
            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.13*theWidth, 0.68*theWidth, 0.03*theWidth)];
            lable2.font = [UIFont systemFontOfSize:10];
            lable2.text =self.model.address;
            [cell.contentView addSubview:lable2];
            UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.19*theWidth, 0.68*theWidth, 0.03*theWidth)];
            lable3.font = [UIFont systemFontOfSize:10];
            lable3.text = [ NSString stringWithFormat:@"营业时间：%@",self.model.time];
            [cell.contentView addSubview:lable3];
            UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.25*theWidth, 0.68*theWidth, 0.03*theWidth)];
            lable4.font = [UIFont systemFontOfSize:10];
            lable4.text =[ NSString stringWithFormat:@"%ldm",self.model.sold*95];
            [cell.contentView addSubview:lable4];
            UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0.78*theWidth, 0.04*theWidth, 0.5, 0.22*theWidth)];
            theView.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:theView];
            UIButton *callButton = [[UIButton alloc] initWithFrame:CGRectMake(0.84*theWidth, 0.13*theWidth, 0.09*theWidth, 0.09*theWidth)];
            [callButton setImage:[UIImage imageNamed:@"shopIcon_call"] forState:UIControlStateNormal] ;
            [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:callButton];
        }
        }else
        {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.035*theWidth, 0.03*theWidth, 0.2*theWidth, 0.06*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.text = @"温馨提示";
                [cell.contentView addSubview:theLable];
            }else
            {
                UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.91*theWidth, 1.36*theWidth)];
                imageView1.image = [UIImage imageNamed:@"IMG_0064.jpg"];
                [cell.contentView addSubview:imageView1];
                UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0*theWidth, 1.36*theWidth, 0.91*theWidth, 0.35*theWidth)];
                imageView2.image = [UIImage imageNamed:@"IMG_0065.jpg"];
                [cell.contentView addSubview:imageView2];
            }
        }
    }
    return cell;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        return 0.12*theWidth;
    }else if (indexPath.section == 1)
    {
        return 0.12*theWidth;
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            return 0.1*theWidth;
        }else
        {
            return 0.3*theWidth;
        }
    }else{
        if (indexPath.row == 0) {
            return 0.1*theWidth;
        }else
        {
            return 1.7*theWidth;
        }
    }
}
// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0.74*theWidth;
    }else
    {
        return 0.01;
    }
    
}
// 组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    if (section == 3) {
        return 0.01;
    }else
    {
        return 0.03*theWidth;
    }
}
//懒加载 加载图片 ---> 临时
-(NSMutableArray *)foodArry
{
    if (_foodArry == nil) {
        _foodArry = [[NSMutableArray alloc] init];
        for (int i= 0; i <4 ; i++) {
            NSString *nameStr = [NSString stringWithFormat:@"food000%d",i +1];
            UIImage *image = [UIImage imageNamed:nameStr];
            [_foodArry addObject:image];
        }
    }
    return _foodArry;
}
// 组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.backgroundColor = [UIColor whiteColor];
        //视图上加 ---->UIScrollView
        theScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth,0.56*theWidth)];
        theScrollView.backgroundColor = [UIColor yellowColor];
        theScrollView.pagingEnabled = YES;
        theScrollView.showsHorizontalScrollIndicator = NO;
        theScrollView.delegate = self;
        // 设置 scrollView 内容大小
        theScrollView.contentSize = CGSizeMake(3*theWidth, 0);
        [view addSubview:theScrollView];
        //    在滚动视图UIScrollView添加3张图片 --->临时
        UIImageView *theimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.56*theWidth)];
        theimageView.image =[UIImage imageNamed:_model.imageName];
        [theScrollView addSubview:theimageView];
        for (int i = 1; i < 3; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*theWidth, 0, theWidth, 0.56*theWidth)];
            imageView.image =[self.foodArry objectAtIndex:i];
            [theScrollView addSubview:imageView];
        }
        //视图上加 ---->UILable
        UILabel *thelable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.59*theWidth, 0.4*theWidth, 0.06*theWidth)];
        thelable.font = [UIFont systemFontOfSize:17];
        thelable.text =_model.foodName;
        [view addSubview:thelable];
        UILabel *thedetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.66*theWidth, 0.4*theWidth, 0.05*theWidth)];
        thedetailLable.font = [UIFont systemFontOfSize:13];
        thedetailLable.alpha = 0.6;
        thedetailLable.text =self.model.pricePurchase;
        [view addSubview:thedetailLable];
        UILabel *thedetailLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0.6*theWidth, 0.66*theWidth, 0.35*theWidth, 0.05*theWidth)];
        thedetailLable1.font = [UIFont systemFontOfSize:13];
        thedetailLable1.alpha = 0.6;
        thedetailLable1.textAlignment = NSTextAlignmentRight;
        thedetailLable1.text = [ NSString stringWithFormat:@"已售%ld",self.model.sold];
        [view addSubview:thedetailLable1];
        return view;
    }else
        return NULL;
    
    
}
#pragma mark UIScrollView 委托事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if (scrollView.frame.size.height*0.28 <= scrollView.contentOffset.y) {
        if (headViewLable == nil) {
            headViewLable = [[UILabel alloc] initWithFrame:CGRectMake(0.35*theWidth, 35, 0.3*theWidth, 25)];
            headViewLable.text = self.model.foodName;
            headViewLable.font = [UIFont boldSystemFontOfSize:18];
            headViewLable.textAlignment = NSTextAlignmentCenter;
            [headView addSubview:headViewLable];
        }
        headViewLable.hidden = NO;
        
    }else if (scrollView.contentOffset.y <= 0)
    {
        headViewLable.hidden = YES;
        headView.backgroundColor = [UIColor clearColor];
        headView.alpha = 1;
    }
    else
    {
        headViewLable.hidden = YES;
        headView.backgroundColor = [UIColor whiteColor];
        float index =  scrollView.contentOffset.y /(scrollView.frame.size.height*0.6);
        headView.alpha = index+0.6;
    }
        
//    float index = theScrollView.contentOffset.y /(0.56*theWidth);
//    headView.alpha = index;
}
//// 组尾视图
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;


#pragma mark  打电话事件
-(void)callButtonAction:(UIButton *)sender
{
    // 创建提示框
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加取消提示栏
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    // 添加拨打电话提示栏
    UIAlertAction *telAction = [UIAlertAction  actionWithTitle:@"400-051-7317" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *str = @"400-051-7317";
        NSString *string =[NSString stringWithFormat:@"tel://%@",str];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
        
        
    }];
    [alertCtr addAction:cancelAction];
    
    [alertCtr addAction:telAction];
    [self presentViewController:alertCtr animated:YES completion:^{
        
    }];
    
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
