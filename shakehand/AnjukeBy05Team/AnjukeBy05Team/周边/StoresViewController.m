//
//  StoresViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "StoresViewController.h"
#import "StoreMoreViewController.h"
#import "StoreImgViewController.h"
#import "GoodsViewController.h"
#import "CellStyleAddres.h"
#import "CellStyleTime.h"
#import "CellStyleGroup.h"
#import "LogonViewController.h"

#pragma mark  06.22 update
#import "UserModel.h"
//#import "AddCtrsViewController.h"
#define ButtonSize 36
#define theScreenWidth [UIScreen mainScreen].bounds.size.width
#define theScreenHeight [UIScreen mainScreen].bounds.size.height

@interface StoresViewController ()
{
    UIScrollView *transView;
    UIButton *backButton;
    UIButton *transButton;
    UIButton *collectButton;
    UIButton *moreButton;
    UIButton *button; //组头1的按钮
#pragma mark  06.22 update
    UserModel *userModel;
    BOOL      isLogin;
    
}

@end

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家详情";
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITableView *tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64) style: UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}
//当界面出现时
-(void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏的自带返回按钮
    self.navigationItem.hidesBackButton = YES;

    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    userModel = [[UserModel alloc]init];
    userModel.userPhone = [userDeafaults objectForKey:@"user"];
    isLogin = [userDeafaults integerForKey:@"login"] ;
    // 自定义Items
    //返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    backButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:  UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    //转发 按钮
    transButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    transButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [transButton setImage:[UIImage imageNamed:@"shopIcon_share"] forState:  UIControlStateNormal];
    [transButton addTarget:self action:@selector(transButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *transItem = [[UIBarButtonItem alloc] initWithCustomView:transButton];

    // 收藏按钮
    collectButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    collectButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [collectButton setImage:[UIImage imageNamed:@"shopIcon_collect"] forState:  UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    
    
    #pragma mark  06.22 update
    //--------->>>>>
    /** 判断收藏按钮是否点亮 */
    // 文件路径
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",userModel.userPhone];
    // 取出文件中的字典
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    NSString *isLoadStr = [[recordDic objectForKey:self.model.foodName] lastObject];
    if ([isLoadStr integerValue]) {
        [collectButton setImage:[UIImage imageNamed:@"shopIcon_collected"] forState:UIControlStateNormal];
        [collectButton setTitle:@"1" forState:UIControlStateNormal];
    }else
    {
        [collectButton setImage:[UIImage imageNamed:@"shopIcon_collect"] forState:UIControlStateNormal];
        [collectButton setTitle:@"2" forState:UIControlStateNormal];
    }
    //-------->>>
    #pragma mark  06.22 update
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    // 更多按钮
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    moreButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [moreButton setImage:[UIImage imageNamed:@"shopIcon_more"] forState:  UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItems = @[moreItem,collectItem,transItem];

}

//收藏按钮事件
#pragma mark  06.22 update
//--------->>>>
-(void)collectButtonAction:(UIButton *)sender
{
    
    if (!isLogin) {
        LogonViewController *loginCtr = [[LogonViewController alloc]init];
        [self.navigationController pushViewController:loginCtr animated:YES];
        return;
    }
    if ([collectButton.titleLabel.text isEqualToString: @"1"]) {//collectButton.selected == YES,
        collectButton.selected = NO;
        [collectButton setTitle:@"2" forState:UIControlStateNormal];
        [collectButton setImage:[UIImage imageNamed:@"shopIcon_collect"] forState:  UIControlStateNormal];
        [self showMessage:@"取消收藏"];
        NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",userModel.userPhone];
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]] ;
        [recordDic removeObjectForKey:self.model.foodName];
        [recordDic writeToFile:filePath atomically:NO];
        
        
    }else
    {
        collectButton.selected = YES;
        [collectButton setTitle:@"1" forState:UIControlStateNormal];
        [collectButton setImage:[UIImage imageNamed:@"shopIcon_collected"] forState:UIControlStateNormal];
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
//-------->>
#pragma mark  06.22 update


#pragma mark 表视图的数据源、委托事件
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 1;
    }else if(section == 1)
    {
        return 3;
    }else
    {
        return 3;
    }
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0 ) {
            return 0.16*theWidth;
    }else if(indexPath.section == 1)
    {
        return 0.2*theWidth;
    }else
    {
        return 0.2*theWidth;
    }
}
//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"myCell";
    static NSString *identifier1 = @"myCell1";
    static NSString *identifier2 = @"myCell2";
    if (indexPath.section == 0) {
        CellStyleAddres *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[CellStyleAddres alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.theLabel.text = self.model.address;
        cell.theDetailLabel.text = @"463m";
        cell.theImageView.image = [UIImage imageNamed:@"shop_address"];
//        cell.theLabel.text = @"厦门福建思明区软件园二期观日路22号113单元";
//        cell.theDetailLabel.text = @"463m";
//        cell.theImageView.image = [UIImage imageNamed:@"shop_address"];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else if (indexPath.section == 1)
    {
        CellStyleGroup *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[CellStyleGroup alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row == 0) {
            cell.theImageView.image = [UIImage imageNamed:@"commonIcon_group"];
        }
        cell.theLable.text= self.model.pricePurchase;
        cell.theMoneyLable.text = [NSString stringWithFormat:@"￥%ld",self.model.price];
        cell.theLinyLable.text =[NSString stringWithFormat:@"￥%ld",self.model.price*2];
        cell.theDetailLable.text =[NSString stringWithFormat:@"已售 %ld",self.model.sold];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else     {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        cell.textLabel.text = self.model.pingjia;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines= 0;
        return cell;
    }
    
}

// 点击单元格事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        GoodsViewController *goodsViewCtr = [[GoodsViewController alloc] init];
        goodsViewCtr.hidesBottomBarWhenPushed =YES;
        goodsViewCtr.model = self.model;// 向下一界面（GoodsViewController）传值
        goodsViewCtr.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:goodsViewCtr animated:YES];
    }
}
// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0.4*theWidth;
    }else if (section == 1)
    {
        return 0.024*theWidth;
    }else
    
    {
        return 0.12*theWidth;
    }
   
}
// 组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0.12*theWidth;
    }else if (section == 1){
         return 0.024*theWidth;
    }else
    {
        return 0.05*theWidth;
    }
    
}
// 组头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        // 第一组组头
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.2*theWidth)];
        imageview.image = [UIImage imageNamed:self.model.imageName];
        imageview.alpha = 0.5;
        [view addSubview:imageview];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.04*theWidth, 0.11*theWidth, 0.19*theWidth, 0.19*theWidth) ;
        [button setImage:[UIImage imageNamed:self.model.imageName] forState:UIControlStateNormal];
        button.layer.cornerRadius = 0.02*theWidth;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(bigerAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.26*theWidth, 0.03*theWidth, 0.66*theWidth, 0.2*theWidth)];
        lable.numberOfLines = 0;
        lable.textColor = [UIColor whiteColor];
        lable.text = self.model.foodName;
        [view addSubview:lable];
        
        UIImageView *stareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.26*theWidth, 0.21*theWidth, 0.24*theWidth, 0.06*theWidth)];
        stareImageView.image = [UIImage imageNamed:@"stare.jpg"];
        [view addSubview:stareImageView];
        
        UILabel *styleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.265*theWidth, 0.25*theWidth, 0.2*theWidth, 0.06*theWidth)];
        styleLable.alpha = 0.5;
        styleLable.text =self.model.style;
        styleLable.font = [UIFont systemFontOfSize:12];
        [view addSubview:styleLable];
        
        UILabel *pjLable = [[UILabel alloc] initWithFrame:CGRectMake(0.55*theWidth, 0.2*theWidth, 0.2*theWidth, 0.06*theWidth)];
        pjLable.font = [UIFont systemFontOfSize:12];
        pjLable.text = [NSString stringWithFormat:@"%ld人评价",self.model.pjNum];
        [view addSubview:pjLable];
        
        return view;
    }else if (section == 2){
        // 第三组组头
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth,0.04*theWidth, 0.25*theWidth, 0.04*theWidth)];//(0.04*theWidth, 0.07*theWidth, theWidth, 0.5*theWidth)]
        label.text  = @"评论";
        [view addSubview:label];
        return view;
    }
    else{
        return NULL;
    }
   
}


// 组尾
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.12*theWidth)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView* theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.042*theWidth, 0.036*theWidth, 0.036*theWidth)];
        theImageView.image = [UIImage imageNamed:@"shop_time"] ;
        [view addSubview:theImageView];
        
        UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.12*theWidth, 0.042*theWidth, 0.45*theWidth, 0.036*theWidth)];
        theLable.font = [UIFont systemFontOfSize:13];
        theLable.text = [NSString stringWithFormat:@"营业时间：%@",self.model.time ];
        [view addSubview:theLable];
        
        UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0.74*theWidth, 0.03*theWidth, 1, 0.06*theWidth)];
        theView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:theView];
        
        UIButton *callButton = [[UIButton alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.03*theWidth, 0.06*theWidth, 0.06*theWidth)];
        [callButton setImage:[UIImage imageNamed:@"shopIcon_call"] forState:UIControlStateNormal] ;
        [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:callButton];
        
        return view;
    }else if(section == 1)
    {
        return NULL;
    }else
    {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.12*theWidth)];
//        return view;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.02*theWidth, 0.4*theWidth, 0.2*theWidth, 0.03*theWidth)];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = @"加载更多...";
        return lable;
    }
}

#pragma mark 组头1的按钮事件
-(void)bigerAction:(UIButton *)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"BigerNotification" object:NULL userInfo:nil];
    StoreImgViewController *storeImgViewCtr = [[StoreImgViewController alloc] init];
    storeImgViewCtr.theImage = button.imageView.image;
    [self presentViewController:storeImgViewCtr animated:NO completion:^{
        
    }];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Items 按钮事件
    //返回按钮事件
-(void)backButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
    //转发按钮事件
-(void)transButtonAction:(UIButton *)sender
{
    // 按钮不能点击
    backButton.enabled = NO;
    transButton.enabled = NO;
    collectButton.enabled = NO;
    moreButton.enabled = NO;
    // 在主视图下边 添加新视图
    transView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0.5*theScreenHeight-64, theScreenWidth, 0.5*theScreenHeight)];
    transView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:transView];
    // 在新视图上添加 按钮
    [self addCtrs];
//    AddCtrsViewController *addCtrViewCtr = [[AddCtrsViewController alloc] init];
//    [addCtrViewCtr addctr]
    // 在主视图上边 添加透明灰色按钮
    UIButton *graybutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, theScreenWidth, 0.5*theScreenHeight-64)];
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
    SMSButton.frame = CGRectMake(theScreenWidth*0.075, transView.frame.size.height/15, theScreenWidth*0.18,transView.frame.size.height*0.289);
    [SMSButton setTitle:@"短信" forState: UIControlStateNormal];
    [SMSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SMSButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [SMSButton setImage:[UIImage imageNamed:@"share_logo_sms"] forState:UIControlStateNormal];
    [transView addSubview:SMSButton];
    // 微信转发按钮
    ZRButton *WXButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WXButton.frame = CGRectMake(theScreenWidth*0.405, transView.frame.size.height/15, theScreenWidth*0.18,transView.frame.size.height*0.289);
    [WXButton setTitle:@"微信" forState: UIControlStateNormal];
    [WXButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WXButton setImage:[UIImage imageNamed:@"share_logo_weixin"] forState:UIControlStateNormal];
    [transView addSubview:WXButton];
    // 微信朋友圈转发按钮
    ZRButton *WXFriendsButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WXFriendsButton.frame = CGRectMake(theScreenWidth*0.735, transView.frame.size.height/15, theScreenWidth*0.18,transView.frame.size.height*0.289);
    [WXFriendsButton setTitle:@"朋友圈" forState: UIControlStateNormal];
    [WXFriendsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXFriendsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WXFriendsButton setImage:[UIImage imageNamed:@"share_logo_weixinFriends"] forState:UIControlStateNormal];
    [transView addSubview:WXFriendsButton];
    // 新浪微博转发按钮
    ZRButton *WBXLButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WBXLButton.frame = CGRectMake(theScreenWidth*0.075, transView.frame.size.height*0.422, theScreenWidth*0.18,transView.frame.size.height*0.289);
    [WBXLButton setTitle:@"微博" forState: UIControlStateNormal];
    [WBXLButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WBXLButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WBXLButton setImage:[UIImage imageNamed:@"share_logo_xinlang"] forState:UIControlStateNormal];
    [transView addSubview:WBXLButton];
    // 腾讯微博转发按钮
    ZRButton *WBTXButton = [ZRButton buttonWithType: UIButtonTypeCustom ];
    WBTXButton.frame =CGRectMake(theScreenWidth*0.405, transView.frame.size.height*0.422, theScreenWidth*0.18,transView.frame.size.height*0.289);
    [WBTXButton setTitle:@"腾讯微博" forState: UIControlStateNormal];
    [WBTXButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WBTXButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [WBTXButton setImage:[UIImage imageNamed:@"share_logo_tengxun"] forState:UIControlStateNormal];
    [transView addSubview:WBTXButton];
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType: UIButtonTypeCustom ];
    cancelButton.frame =CGRectMake(theScreenWidth*0.075, transView.frame.size.height*0.788, theScreenWidth*0.85,transView.frame.size.height*0.155);
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
    moreButton.enabled = YES;
    
}


    //更多按钮事件
-(void)moreButtonAction:(UIButton *)sender
{
    // 创建提示框
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加取消提示栏
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    // 添加拨打电话提示栏
    UIAlertAction *telAction = [UIAlertAction  actionWithTitle:@"联系拉手客服（8:00~22:00）" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击单元格 选中的单元格变灰恢复

            //创建自定义提示框对象
            ZLAlertView *zlAlerview = [[ZLAlertView alloc] initWithTitle:@"400-051-7317" message:@""];
            // 添加按钮
            [zlAlerview addBtnTitle:@"取消" action:^{
                
            }];
            // 添加按钮
            [zlAlerview addBtnTitle:@"确定" action:^{
                NSString *str = @"400-051-7317";
                NSString *string =[NSString stringWithFormat:@"tel://%@",str];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
            }];
            [zlAlerview showAlertWithSender:self];
        
    }];
    // 添加报错提示栏
    UIAlertAction *errAction = [UIAlertAction actionWithTitle:@"商家信息报错" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StoreMoreViewController *StoreMoreViewCtr = [[StoreMoreViewController alloc] init];
        [self.navigationController pushViewController:StoreMoreViewCtr animated:YES];
    }];
    [alertCtr addAction:cancelAction];
    [alertCtr addAction:errAction];
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
