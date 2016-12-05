//
//  MyViewController.m
//  项目--我的
//
//  Created by etcxm on 16/6/6.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "MyViewController.h"
#import "ZRButton.h"
#import "LogonViewController.h"
#import "DairlyViewController.h"
#import "UserModel.h"
#import "PersonalCenterViewController.h"
#import "TicketsViewController.h"
#import "CollectViewController.h"
#import "WaitPayViewController.h"
#import "HadPayViewController.h"
#import "MyTreasureViewController.h"
#import "MyBalanceViewController.h"
#import "MyCouponViewController.h"
#import "MyPriceViewController.h"


#define theWidth           [UIScreen mainScreen].bounds.size.width
#define theHeight          [UIScreen mainScreen].bounds.size.height
#define TheHeadVIewTag     10908
#define TheNotLoginVIewTag 80901
#define theLogViewTag      90909
@interface MyViewController ()
{
    NSArray *_listArray;
    UITableView *_theTableView;  // 我的界面- 表视图
    UIButton *_userCenterBtn;
    UIImageView *_userImageView;  //用户头像
    UIView *_headView;
    UIView *notLoginV;
    UIView *theLogView;
    UILabel *_notLoginlabel;
    UIButton *_loginButton;
    UIButton *_rightBtn;
    UILabel *_balanceLabel;
    UILabel *_collectLabel;
}
@property(nonatomic,strong )UserModel *userModel;

@end

static NSInteger _successIndex  = 0;

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    _userModel = [[UserModel alloc]init];
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
    
    [self selcetModel];
    
    _successIndex = [[userDeafaults objectForKey:@"login"] integerValue];
//    NSLog(@"--------------------------------_uyserModel = %@",_userModel.userPhone);
    self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0];

    [self setTableView];
    
//    添加 登录 观察者   和 退出 观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(successLoginAction:) name:@"成功登录" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitAction:) name:@"退出当前账号" object:nil];
//    添加更改头像的观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeImageAction:) name:@"更改了头像" object:nil];

    
}

- (void)selcetModel{
    
    UserData *userData = [[UserData alloc]init];
    for (UserModel *model in [userData selectData]) {
        if ([model.userPhone isEqualToString:_userModel.userPhone]) {
            
            _userModel = model;
        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark successLoginAction 成功登录 通知事件
- (void)successLoginAction:(NSNotification *)notification{
    
    _successIndex = 1;
    _userModel = notification.object;
    _userImageView.hidden = NO;
    _userCenterBtn.hidden = NO;
    _rightBtn.hidden = NO;
    _notLoginlabel.hidden = YES;
    _loginButton.hidden = YES;
    _balanceLabel.text =  [NSString stringWithFormat:@"%.2f元",_userModel.userMoney];

}
#pragma mark exitAction t退出 通知事件
- (void)exitAction:(NSNotification *)notification{
    
    _successIndex = 0;
    _userImageView.hidden = YES;
    _userCenterBtn.hidden = YES;
    _rightBtn.hidden = YES;
    _notLoginlabel.hidden = NO;
    _loginButton.hidden = NO;
    _balanceLabel.text =  @"0.00元";
    _collectLabel.text =  @"0";
}
#pragma mark 更改用户头像
- (void)changeImageAction:(NSNotification *)notification{
    
    _userImageView.image = [UIImage imageWithContentsOfFile:notification.object];
}
#pragma mark 表视图创建
- (void)setTableView
{
    //创建表视图
    _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight) style:UITableViewStyleGrouped];
    
    _theTableView.separatorColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0];
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    
    //1、添加头部视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight/4.447)];
    //   a、 头部视图中添加背景图片

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight/4.44)];
    imageView.image = [UIImage imageNamed:@"account_beijing"];
    [_headView addSubview:imageView];
     notLoginV = [self getHeadView:nil andUserName:_userModel.userName andUserPhone:_userModel.userPhone];
    [_headView addSubview:notLoginV];
    
    //    d、添加头部视图下方的其他三个按钮
    //拉手券按钮
    UIButton *shakeButton = [[UIButton alloc]initWithFrame:CGRectMake(theWidth/13.5, theHeight*0.135, theWidth*0.247, theHeight/13.3)];
    [shakeButton setTitle:@"拉手券" forState: UIControlStateNormal];
    [shakeButton addTarget:self action:@selector(shakeBrnAction) forControlEvents: UIControlEventTouchUpInside];
    //    shakeButton.backgroundColor = [UIColor blackColor];
    [_headView addSubview:shakeButton];
    //收藏按钮
    UIButton *collectButton = [[UIButton alloc]initWithFrame:CGRectMake((theWidth*(1-0.247))/2, theHeight*0.135, theWidth*0.247, theHeight/13.3)];
    [collectButton setTitle:@"收藏" forState: UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectBrnAction) forControlEvents: UIControlEventTouchUpInside];
    //    collectButton.backgroundColor = [UIColor redColor];
    [_headView addSubview:collectButton];
    //最近浏览按钮
    UIButton *scanButton = [[UIButton alloc]initWithFrame:CGRectMake(theWidth*0.71, theHeight*0.135, theWidth*0.247, theHeight/13.3)];
    [scanButton setTitle:@"最近浏览" forState: UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scanBrnAction) forControlEvents: UIControlEventTouchUpInside];
    //    scanButton.backgroundColor = [UIColor greenColor];
    [_headView addSubview:scanButton];
    
    // e、添加头部视图下方的两条分隔线
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(theWidth*0.329,theHeight*0.156,0.5, theHeight/22.2)];
    view1.backgroundColor = [UIColor whiteColor];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(theWidth*0.682, theHeight*0.156, 0.5, theHeight/22.2)];
    view2.backgroundColor = [UIColor whiteColor];
    
    [_headView addSubview:view1];
    [_headView addSubview:view2];
    
    _theTableView.tableHeaderView = _headView;
    
    //f、头部视图中添加label--->传值
    //拉手券下的label
    UILabel *shakeLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.18, theHeight*0.17, theWidth*0.411, theHeight/16.6)];
    shakeLabel.text = @"0";
    shakeLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:shakeLabel];
    
    //收藏下的label
    _collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.48, theHeight*0.17, theWidth*0.411, theHeight/16.6)];
    _collectLabel.text = [NSString stringWithFormat:@"%ld",[self readFileDetail].count];
    _collectLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:_collectLabel];
    //最近浏览下的label
    UILabel *scanLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.81, theHeight*0.17, theWidth*0.411,theHeight/16.6)];
    scanLabel.text = @"0";
    scanLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:scanLabel];
    
    
    [self.view addSubview:_theTableView];
    
    //数组
    _listArray = @[@"   我的订单",@"   我的资产",@"   每日推荐",@"   我的评价",@"   我的抽奖",@"   我是商家(即将入住提升收入)"];
}

#pragma mark读取收藏的文件
#pragma mark 加载文件
-(NSDictionary *)readFileDetail
{
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",_userModel.userPhone];
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return tempDic;
}

#pragma mark UITableViewDataSource事件
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 6;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section ==0) {
        return 2;
    }else if(section ==1){
        return 2;
    }else if (section ==2){
        return 1;
    }else if (section ==3){
        return 1;
    }else if (section ==4){
        return 1;
    }else{
        return 1;
    }
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identify = @"myCell";
    UITableViewCell *tabViewCell = nil;
    tabViewCell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (tabViewCell == nil){
        tabViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    NSString *cellString = [_listArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        tabViewCell.textLabel.text = cellString;
    }
    if (indexPath.section ==0) {//我的订单
        tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/73, theHeight/55.5, theWidth/18.2, theHeight/33.3)];
            imageView1.image = [UIImage imageNamed:@"account_dingdan"];
            [tabViewCell.contentView addSubview:imageView1];
        }
        else{
            //待付款
            ZRButton *waitPayButton = [[ZRButton alloc]initWithFrame:CGRectMake(theWidth*0.125, theHeight/66.7, theWidth*0.115, theHeight/11)];
            [waitPayButton setImage:[UIImage imageNamed:@"account_daifukuan"] forState:UIControlStateNormal];
//            waitPayButton.titleLabel.font = [UIFont systemFontOfSize:12];
            waitPayButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [waitPayButton setTitle:@"待付款" forState:UIControlStateNormal];
            [waitPayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [waitPayButton addTarget:self action:@selector(waitPayAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:waitPayButton];
            //已付款
            ZRButton *alreadyPayButton = [[ZRButton alloc]initWithFrame:CGRectMake(theWidth*0.35, theHeight/66.7, theWidth*0.115, theHeight/11)];
            [alreadyPayButton setImage:[UIImage imageNamed:@"account_yifukuan"] forState:UIControlStateNormal];
            [alreadyPayButton setTitle:@"已付款" forState:UIControlStateNormal];
            alreadyPayButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [alreadyPayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [alreadyPayButton addTarget:self action:@selector(alreadyPayAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:alreadyPayButton];
            //待评价
            ZRButton *waitEvaluateButton = [[ZRButton alloc]initWithFrame:CGRectMake(theWidth*0.57, theHeight/66.7, theWidth*0.115, theHeight/11)];
            [waitEvaluateButton setImage:[UIImage imageNamed:@"account_daipingjia"] forState:UIControlStateNormal];
            [waitEvaluateButton setTitle:@"待评价" forState:UIControlStateNormal];
            waitEvaluateButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [waitEvaluateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [waitEvaluateButton addTarget:self action:@selector(waitEvaluateAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:waitEvaluateButton];
            
            //夺宝单
            ZRButton *searchTreasureButton = [[ZRButton alloc]initWithFrame:CGRectMake(theWidth*0.782, theHeight/66.7, theWidth*0.115, theHeight/11)];
            [searchTreasureButton setImage:[UIImage imageNamed:@"account_duobaodan"] forState:UIControlStateNormal];
            searchTreasureButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [searchTreasureButton setTitle:@"夺宝单" forState:UIControlStateNormal];
            [searchTreasureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [searchTreasureButton addTarget:self action:@selector(searchTreasureAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:searchTreasureButton];
      
        }
        
        
    }else if (indexPath.section ==1){//我的资产
         tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row ==0) {
            UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/73, theHeight/51, theWidth/18, theHeight/33)];
            imageView2.image = [UIImage imageNamed:@"account_zichan"];
            [tabViewCell.contentView addSubview:imageView2];
        }
        else {
            //余额
            UIButton *balanceButton = [[UIButton alloc]initWithFrame:CGRectMake(theWidth*0.10,theHeight/66.7, theWidth*0.151, theHeight*0.05)];
            [balanceButton setTitle:@"余额" forState:UIControlStateNormal];
            [balanceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            balanceButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [tabViewCell addSubview:balanceButton];
            [balanceButton addTarget:self action:@selector(balanceAction) forControlEvents: UIControlEventTouchUpInside];
            
            //抵用券
            UIButton *serveButton = [[UIButton alloc]initWithFrame:CGRectMake(theWidth*0.427, theHeight/66.7,theWidth*0.151, theHeight*0.05)];
            [serveButton setTitle:@"抵用券" forState:UIControlStateNormal];
            [serveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [serveButton addTarget:self action:@selector(serveAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:serveButton];
           
            
            //夺宝币
            UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(theWidth*0.781, theHeight/66.7, theWidth*0.151, theHeight*0.05)];
            [searchButton setTitle:@"夺宝币" forState:UIControlStateNormal];
            [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
            [tabViewCell addSubview:searchButton];
            
            //添加 我的资产 中的分割线
            UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth*0.329, theHeight/66.7, theWidth/365, theHeight/16.6)];
            imageView3.image = [UIImage imageNamed:@"bg_conditionBarItem_line"];
            
            UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth*0.692, theHeight/66.7, theWidth/365, theHeight/16.6)];
            imageView4.image = [UIImage imageNamed:@"bg_conditionBarItem_line"];
            
            [tabViewCell addSubview:imageView3];
            [tabViewCell addSubview:imageView4];
            
            //添加我的资产中的label----》传值
            //余额上的label
            _balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.056,theHeight/16.6, theWidth*0.23, theHeight*0.05)];
             _balanceLabel.textAlignment = NSTextAlignmentCenter;
            _balanceLabel.textColor = [UIColor redColor];
            _balanceLabel.text =  [NSString stringWithFormat:@"%.2f元",_userModel.userMoney];
            [tabViewCell addSubview:_balanceLabel];
            
            //抵用券上的label
            UILabel *serveLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.427,theHeight/16.6, theWidth*0.167,theHeight*0.05)];
            serveLabel.text = @"0张";
            serveLabel.textAlignment = NSTextAlignmentCenter;
            serveLabel.textColor = [UIColor blackColor];
            [tabViewCell addSubview:serveLabel];
            
            //夺宝币上的label
            UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*0.781,theHeight/16.6, theWidth*0.167,  theHeight*0.05)];
            searchLabel.textAlignment = NSTextAlignmentCenter;
            searchLabel.text = @"0个";
            searchLabel.textColor = [UIColor blackColor];
            [tabViewCell addSubview:searchLabel];




        }
       

    }else if (indexPath.section ==2){//每日推荐
        UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/71.6, theHeight/51.3,theWidth/18.2, theHeight/33.3)];
        imageView3.image = [UIImage imageNamed:@"account_tuijian"];
        tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tabViewCell.contentView addSubview:imageView3];
         tabViewCell.accessoryType = UITableViewCellStyleValue1;
    }else if (indexPath.section ==3){//我的评价
        UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/71.6, theHeight/51.3, theWidth/18.2, theHeight/33.3)];
        imageView4.image = [UIImage imageNamed:@"account_pingjia"];
        tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tabViewCell.contentView addSubview:imageView4];
         tabViewCell.accessoryType = UITableViewCellStyleValue1;
    }else if (indexPath.section ==4){//我的抽奖
        UIImageView *imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/71.6, theHeight/51.3, theWidth/18.2, theHeight/33.3)];
        imageView5.image = [UIImage imageNamed:@"account_choujiang"];
        tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tabViewCell.contentView addSubview:imageView5];
         tabViewCell.accessoryType = UITableViewCellStyleValue1;
    }else if (indexPath.section ==5){//我是商家
        UIImageView *imageView6= [[UIImageView alloc]initWithFrame:CGRectMake(theWidth/71.6, theHeight/51.3,theWidth/18.2, theHeight/33.3)];
        imageView6.image = [UIImage imageNamed:@"account_kaidian"];
        tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tabViewCell.contentView addSubview:imageView6];
         tabViewCell.accessoryType = UITableViewCellStyleValue1;
    }
    
    return tabViewCell;
}
#pragma mark UITableViewDelegate事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    if (indexPath.section == 2) {
        
        [self.tabBarController setSelectedIndex:1];
    }
    if (indexPath.section == 3) {
        if (!_successIndex) {
            
            [self showLoginCtr];
        }
        else{
         
            NSLog(@"我的评价");
        }
    }
    if (indexPath.section == 4) {
        if (!_successIndex) {
            
            [self showLoginCtr];
        }
        else{
    
            MyPriceViewController *myPriceCtr = [[MyPriceViewController alloc]init];
            myPriceCtr.string = @"您还没有抽奖过哦";
            [myPriceCtr setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myPriceCtr animated:YES];

        }
    }
    if (indexPath.section == 5) {
        
            MyPriceViewController *myPriceCtr = [[MyPriceViewController alloc]init];
            myPriceCtr.string = @"敬请期待.....";
            [myPriceCtr setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myPriceCtr animated:YES];

        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section ==0&&indexPath.row ==1) {
        
        return 88;
    }else if(indexPath.section ==1&&indexPath.row ==1){
        return 80;
    }else {
        return 44;
    }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    UIView *sectionFootView = [[UIView alloc]initWithFrame:CGRectZero];

    return sectionFootView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}


#pragma mark 判断是否登录返回头部的视图
- (UIView *)getHeadView:(NSData *)userImageData andUserName:(NSString *)userName andUserPhone:(NSString *)userPhone{
    
    UIView *notLoginVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight/4.447*2/3)];
    notLoginVIew.backgroundColor = [UIColor clearColor];
        //    b、头部视图中添加label
        _notLoginlabel =[[UILabel alloc] initWithFrame:CGRectMake((theWidth*0.534)/2,theHeight/46, theWidth*0.493, theHeight/16.6)];
        _notLoginlabel.tag = 06201733;
        _notLoginlabel.text = @"您还没有登录哦";
        _notLoginlabel.textAlignment =  NSTextAlignmentCenter;
        [notLoginVIew addSubview:_notLoginlabel];
        
        //    c、头部视图中添加用户登录按钮
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake((theWidth*0.534)/2,theHeight/13.3, theWidth*0.493, theHeight/16.6)];
        _loginButton.tag = 06201734;
        [_loginButton setImage:[UIImage imageNamed:@"account_login"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginBrnAction) forControlEvents:UIControlEventTouchUpInside ];
        [notLoginVIew addSubview:_loginButton];
 
        // 用户头像
        _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 60, 60)];
        _userImageView.layer.cornerRadius = 30;
        _userImageView.layer.masksToBounds = YES;
        NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_userModel.userPhone];
        _userImageView.image = [UIImage imageWithContentsOfFile:filePath];
        if (_userImageView.image == nil) {
            
            _userImageView.image = [UIImage imageNamed:@"user_head"];
        }
        // 点击进入修改个人信息
         _userCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _userCenterBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_userCenterBtn addTarget:self action:@selector(modifyUserCenter:) forControlEvents:UIControlEventTouchUpInside];
         _userCenterBtn.frame = CGRectMake(100, 40, 230, 30);
//        _userCenterBtn.backgroundColor = [UIColor blueColor];
        if (userName.length != 0) {
            
            [_userCenterBtn setTitle:userName forState:UIControlStateNormal];
            _userCenterBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        }else{
            [_userCenterBtn setTitle:userPhone forState:UIControlStateNormal];
            _userCenterBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        }
//         _userCenterBtn.backgroundColor = [UIColor whiteColor];
        //添加按钮
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(340, 45, 20,20);
        [_rightBtn setImage:[UIImage imageNamed:@"goToUserCenter"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(modifyUserCenter:) forControlEvents:UIControlEventTouchUpInside];
        [notLoginVIew addSubview:_userImageView];
        [notLoginVIew addSubview:_rightBtn];
        [notLoginVIew addSubview:_userCenterBtn];
    if (userPhone == nil) {
        _userImageView.hidden = YES;
        _userCenterBtn.hidden = YES;
        _rightBtn.hidden = YES;
    }
    else{
        _notLoginlabel.hidden = YES;
        _loginButton.hidden = YES;

    }
        return notLoginVIew;
   
}
#pragma mark modifyUserCenter 修改用户名进入个人中心修改信息
- (void)modifyUserCenter:(UIButton *)button{

    PersonalCenterViewController *personalViewCtr = [[PersonalCenterViewController alloc] init];
    personalViewCtr.userModel = _userModel;
    [personalViewCtr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:personalViewCtr animated:YES];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 点击事件
-(void)loginBrnAction;
{
    [self showLoginCtr];
}
-(void)shakeBrnAction;
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        
        TicketsViewController *ticketCtr = [[TicketsViewController alloc]init];
        [ticketCtr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:ticketCtr animated:YES];

     }
}
-(void)collectBrnAction;
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
           
        CollectViewController *collectCtr = [[CollectViewController alloc]init];
        [collectCtr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:collectCtr animated:YES];
    }
}
-(void)scanBrnAction;
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        
        NSLog(@"最近浏览按钮被点击了");

    }
    
}
-(void)waitPayAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        WaitPayViewController *waitCtr = [[WaitPayViewController alloc]init];
        waitCtr.userModel = _userModel;
        [waitCtr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:waitCtr animated:YES];
 

    }
}
-(void)alreadyPayAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        
        HadPayViewController *HadPayCtr = [[HadPayViewController alloc]init];
        [HadPayCtr setHidesBottomBarWhenPushed:YES];
        HadPayCtr.userModel = _userModel;
        HadPayCtr.selectIndex = 0;
        [self.navigationController pushViewController:HadPayCtr animated:YES];
    }
}
-(void)waitEvaluateAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{

        HadPayViewController *HadPayCtr = [[HadPayViewController alloc]init];
        [HadPayCtr setHidesBottomBarWhenPushed:YES];
         HadPayCtr.userModel = _userModel;
        HadPayCtr.selectIndex = 1;
        [self.navigationController pushViewController:HadPayCtr animated:YES];
    }
}
-(void)searchTreasureAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        NSLog(@"寻宝单按钮被点击了");

    }
}
-(void)balanceAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
        
        MyBalanceViewController *myBalanceCtr = [[MyBalanceViewController alloc]init];
        myBalanceCtr.userModel = _userModel;
        [myBalanceCtr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myBalanceCtr animated:YES];

    }
}
-(void)serveAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
  
        MyCouponViewController *myCouponCtr = [[MyCouponViewController alloc]init];
        [myCouponCtr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myCouponCtr animated:YES];
 
    }
}
-(void)searchAction
{
    if (!_successIndex) {
        
        [self showLoginCtr];
    }
    else{
      NSLog(@"夺宝币按钮被点击了");
    }
}
#pragma mark 登录界面显示
- (void)showLoginCtr{
    
    LogonViewController *logonViewCtr = [[LogonViewController alloc]init];
    [logonViewCtr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:logonViewCtr animated:NO];
}

#pragma mark 消失和出现本视图的时间
- (void)viewWillAppear:(BOOL)animated;
{
    UserData *useData = [[UserData alloc]init];
    for (UserModel *model in [useData selectData]) {
        
        if ([model.userPhone isEqualToString:_userModel.userPhone]) {
            _userModel = model;
            break;
        }
    }
    if (_userModel.userName != nil) {
        
        [_userCenterBtn setTitle:_userModel.userName forState:UIControlStateNormal];
    }
    else{
        
        [_userCenterBtn setTitle:_userModel.userPhone forState:UIControlStateNormal];

    }
    if (_successIndex) {
        
        _balanceLabel.text =  [NSString stringWithFormat:@"%.2f元",_userModel.userMoney];
        _collectLabel.text = [NSString stringWithFormat:@"%ld",[self readFileDetail].count];
    }
    self.navigationController.navigationBarHidden = YES;
    
    

}
- (void)viewWillDisappear:(BOOL)animated;
{
     self.navigationController.navigationBarHidden = NO;
}

@end
