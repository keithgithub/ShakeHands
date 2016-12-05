//
//  HomeViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/6.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "HomeViewController.h"
#import "YouLikeTableViewCell.h"
#import "FoodData.h"
#import "Foodmodel.h"
#import "MovieData.h"
#import "movieModel.h"
#import "LSZKViewController.h"
#import "MovieViewController.h"
#import "AllFilmViewController.h"
#import "TLCityPickerController.h"
#import "FilmCinemaViewController.h"
#import "CinemaData.h"
#import "CinemaModel.h"
#import "SurroundViewController.h"
#import "StoresViewController.h"
#import "CinemaDetailViewController.h"
#import "SearchViewController.h"

#define TheBtnW theWidth*0.133
#define TheBtnH theWidth*0.213

#define TotalColums 4

@interface HomeViewController ()<WYScrollViewLocalDelegate,TLCityPickerDelegate>
{
    UIView             *_theTableHeadView;//头部视图
    NSMutableArray     *_cell0ImageArry;//cell0行按钮图片数组
    NSArray            *_cell0BtnArry;//cell0行按钮名字
    UIView             *_headView;//最上面头部view
    UIScrollView       *hootScrollView;//热映电影scrollView
    UIButton           *cityButton;
    NSMutableArray     *_hotShowingArr;//热映电影数组
    NSMutableArray     *_foodArr;//食物数据库数组
    NSMutableArray     *_cinemaArr;//电影院数组
    UIButton           *_searchBtn;
}

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation HomeViewController
/**  懒加载 按钮图片 */
-(NSMutableArray *)cell0ImageArry
{
    if (_cell0ImageArry == nil) {
        _cell0ImageArry = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            NSString *imageName = [NSString stringWithFormat:@"icon_%d",i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [_cell0ImageArry addObject:image];
        }
    }
    return _cell0ImageArry;
}
/**  懒加载 按钮名称 */
-(NSArray *)cell0BtnArry
{
    if (_cell0BtnArry ==0) {
        _cell0BtnArry = @[@"美食",@"电影",@"酒店",@"休闲娱乐",@"自助餐",@"KTV",@"蛋糕甜品",@"旅游",];
    }
    return  _cell0BtnArry;
}

/**  懒加载 热映电影数组 */
- (NSMutableArray *)hotShowingArr{
    
    if (_hotShowingArr == nil) {
        _hotShowingArr = [[NSMutableArray alloc]init];
        MovieData  *movieData = [[MovieData alloc]init];
        NSMutableArray *tempArr = [movieData selectData];
        for (movieModel *model in tempArr) {
            if (model.moviePlayTime == 6) {
                
                [_hotShowingArr addObject:model];
            }
        }
        
    }
    return _hotShowingArr;
}
/**  懒加载 美食数组 */
- (NSMutableArray *)foodArr{
    
    if (_foodArr == nil) {
        _foodArr = [[NSMutableArray alloc]init];
        FoodData  *foodData = [[FoodData alloc]init];
        _foodArr = [foodData selectData];
    }
    return _foodArr;
}

/**  懒加载 电影院数组 */
- (NSMutableArray *)cinemaArr{
    
    if ( _cinemaArr== nil) {
        _cinemaArr = [[NSMutableArray alloc]init];
        CinemaData  *cinemaData = [[CinemaData alloc]init];
        _cinemaArr = [cinemaData selectData];
    }
    return _cinemaArr;
}

//程序入口
- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor brownColor];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
 
    [self addNavigationBar];
    [self addTableHeadView];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//信息栏设为白色

    
}

//头部视图
-(void)addTableHeadView
{
    
    //    添加图片
    NSMutableArray *imageArry = [[NSMutableArray alloc] init];
    for (int i=0; i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"home_0%d.jpg",i+1];
        [imageArry addObject:imageName];

    }
//    设置头部视图
    _theTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight*0.24)];
    _theTableHeadView.backgroundColor = [UIColor purpleColor];
    
//    头部视图添加滚动视图
    WYScrollView *scrollView = [[WYScrollView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight*0.24) WithLocalImages:imageArry];
    scrollView.AutoScrollDelay = 4.0;
    scrollView.localDelagate = self;
    [_theTableHeadView addSubview:scrollView];
    _theTableView.tableHeaderView = _theTableHeadView;
    
    
}

//导航栏添加按钮（headView）
-(void)addNavigationBar;
{
    
//
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 64)];
    _headView.backgroundColor = [UIColor clearColor];
    _headView.alpha = 0.5;
    
    //    城市筛选按钮

    cityButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, theWidth*0.16, 44)];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cityButton setTitle:@"厦门市" forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [cityButton addTarget:self action:@selector(theCityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:cityButton];
    
#pragma mark 搜索栏
    //    搜索按钮
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.backgroundColor = RGB(246, 246, 246);
    [_searchBtn setTitle:@"🔍请输入商品名、品类或商圈..." forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    _searchBtn.layer.cornerRadius = 10;
    _searchBtn.layer .masksToBounds = YES;
    _searchBtn.frame = CGRectMake(theWidth*0.16+20+5,30, theWidth*0.56-10, 24);
    [_headView addSubview:_searchBtn];
    
    //    扫描二维码按钮
    UIButton *scanButton = [[UIButton alloc] initWithFrame:CGRectMake(theWidth*0.8, 20, theWidth*0.075, 44)];
    [scanButton setImage:[UIImage imageNamed:@"home_nav_scan"] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(theScanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:scanButton];
    
    
    //    个人按钮（🔔）
    UIButton *msgButton = [[UIButton alloc] initWithFrame:CGRectMake(theWidth*0.8+theWidth*0.075+5, 20,theWidth*0.075, 44)];
    [msgButton setImage:[UIImage imageNamed:@"home_nav_msg"] forState:UIControlStateNormal];
    [msgButton addTarget:self action:@selector(theMsgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:msgButton];

    [self.view addSubview:_headView];
    
}

#pragma mark搜索栏 点击事件
- (void)searchAction{
    
    SearchViewController *searchViewCtr = [[SearchViewController alloc] init];
    searchViewCtr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewCtr animated:YES];

    
}
#pragma mark  数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 7+self.foodArr.count+self.cinemaArr.count;
}
//数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (indexPath.row == 0) {
//        cell第0行 用for循环添加八个按钮
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        int spaceX = (theWidth-(TotalColums*TheBtnW))/(TotalColums+1);//x间隙
        int spaceY = 10;//y轴间隙大小
        for (int i=0; i<self.cell0ImageArry.count; i++) {
            int row = i/TotalColums;
            int col = i%TotalColums;
            ZRButton *button = [[ZRButton alloc] initWithFrame:CGRectMake(spaceX+col*(spaceX+TheBtnW), 10+row*(spaceY+TheBtnH), TheBtnW, TheBtnH)];
            button.tag = 2000+i;
            [button setTitle:[self.cell0BtnArry objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//            button.titleLabel.textColor = [UIColor blueColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [button setImage:[self.cell0ImageArry objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
//            [view addSubview:button];
            [cell.contentView addSubview:button];
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
    }
    else if (indexPath.row == 1)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth/2.0, theWidth/5.0)];
        view1.image = [UIImage imageNamed:@"home_3"];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
        [view1 setUserInteractionEnabled:YES];
        [view1 addGestureRecognizer:tap2];
        
        UIImageView *view2 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth/2.0, 0, theWidth/2.0, theWidth/5.0)];
        view2.image = [UIImage imageNamed:@"home_4"];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction3:)];
        [view2 setUserInteractionEnabled:YES];
        [view2 addGestureRecognizer:tap3];
        [cell.contentView addSubview:view1];
        [cell.contentView addSubview:view2];
        
    }else if (indexPath.row ==2)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth/2.5)];
        imageView.image = [UIImage imageNamed:@"home_5"];
        [cell.contentView addSubview:imageView];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth/3, theWidth/2.5)];
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(theWidth/3.0, 0, theWidth/3, theWidth/2.5)];
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(theWidth*2.0/3, 0, theWidth/3, theWidth/2.5)];
        [imageView addSubview:view1];
        [imageView addSubview:view2];
        [imageView addSubview:view3];
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction4:)];
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction5:)];
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction6:)];
        [view1 addGestureRecognizer:tap4];
        [view2 addGestureRecognizer:tap5];
        [view3 addGestureRecognizer:tap6];
        
        
    }else if (indexPath.row ==3)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, theWidth-20, theWidth/2.5-20)];
        imageView.image = [UIImage imageNamed:@"home_6"];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
        [imageView addGestureRecognizer:tap1];
        [imageView setUserInteractionEnabled:YES];
        [cell.contentView addSubview:imageView];
 
    }
    else if (indexPath.row ==4)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, theWidth/4, 40)];
        lb.text = @"热映电影";
        lb.textAlignment = NSTextAlignmentCenter;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(theWidth*3.0/4-theWidth*0.1, 0, theWidth/4, 40)];
        [btn setTitle:@"全部电影" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(allMovieBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:btn];
        [cell.contentView addSubview:lb];
      

    }else if (indexPath.row ==5)
    {
//        热映电影
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        hootScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theWidth/2.3)];
//        hootScrollView.backgroundColor = [UIColor orangeColor];
        hootScrollView.contentSize = CGSizeMake(10+self.hotShowingArr.count*(theWidth*0.25+10), 0);
        [cell.contentView addSubview:hootScrollView];
//    设置是否可以显示滚动条Indicator
        hootScrollView.showsHorizontalScrollIndicator = NO;
        
//      从model导入数据
//        MovieData *movieData = [[MovieData alloc]init];
//        NSArray *movieArr = [movieData selectData];
        movieModel *model = [[movieModel alloc]init];
        for (int i = 0; i<self.hotShowingArr.count; i++) {
            model = [self.hotShowingArr objectAtIndex:i];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10+i*(theWidth*0.25+10),10,theWidth*0.25 , theWidth/2.3-20)];
//            view.backgroundColor = [UIColor yellowColor];
            view.tag = 1000+i;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.25, theWidth/2.3-theWidth/2.3*0.35)];
            
            imageView.backgroundColor = [UIColor greenColor];
            imageView.image = [UIImage imageNamed:model.movieImageName];
            UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, theWidth/2.3-theWidth/2.3*0.35, theWidth*0.25, theWidth/2.3*0.35/3)];//电影名lb1
            lb1.font = [UIFont systemFontOfSize:14];
//            lb1.backgroundColor = [UIColor redColor];
            lb1.text = model.movieName;
            UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, theWidth/2.3-theWidth/2.3*0.35+theWidth/2.3*0.35/3, theWidth*0.25, theWidth/2.3*0.35/3)];//评分lb2
            lb2.font = [UIFont systemFontOfSize:14];
            lb2.textColor = [UIColor redColor];
            lb2.text = [NSString stringWithFormat:@"%.1f分", model.moviePingfen];
//            在view上添加单击事件
            UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hootFilmSingerTap:)];
            [view addGestureRecognizer:singerTap];
        
            
            [view addSubview:lb2];
            [view addSubview:lb1];
            [view addSubview:imageView];
            [hootScrollView addSubview:view];
        }
      
    }else if (indexPath.row ==6)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.107)];
        imageView.image = [UIImage imageNamed:@"home_7"];
        [cell.contentView addSubview:imageView];
    }


    else  {
        
        if (indexPath.row <= (self.foodArr.count+6)) {
            
            Foodmodel *foodModel = [[Foodmodel alloc]init];
            foodModel = [self.foodArr objectAtIndex:indexPath.row-7];
            YouLikeTableViewCell *yLCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            yLCell = [[YouLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            yLCell.likeImageView.image = [UIImage imageNamed:foodModel.imageName];
            yLCell.likeLb1.text = foodModel.foodName;
            yLCell.likeLb2.text = foodModel.pricePurchase;
            yLCell.likeLb4.text = [NSString stringWithFormat:@"%.ld",foodModel.price];
            NSString *str = [NSString stringWithFormat:@"%.0f",foodModel.price*1.4];
            //下划线
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
            yLCell.likeLb5.attributedText = attribtStr;
            yLCell.likeLb7.text = [NSString stringWithFormat:@"已售 %ld",(long)foodModel.sold];
            return  yLCell;

        }else{
            CinemaModel *model = [[CinemaModel alloc] init];
            model = [self.cinemaArr objectAtIndex:indexPath.row-7-self.foodArr.count];
            YouLikeTableViewCell *yLCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            yLCell = [[YouLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            yLCell.likeImageView.image = [UIImage imageNamed:model.cinemaImageName];
            yLCell.likeLb1.text = model.cinemaName;
            yLCell.likeLb2.text = model.cinemaAdress;
            yLCell.likeLb4.text = [NSString stringWithFormat:@"%.ld",model.cinemaLowPrice];
            NSString *str = [NSString stringWithFormat:@"%.0f",model.cinemaLowPrice*1.4];
            //下划线
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
            yLCell.likeLb5.attributedText = attribtStr;
            NSInteger sou = arc4random()%50+20;
            yLCell.likeLb7.text = [NSString stringWithFormat:@"已售 %ld",sou];
            return  yLCell;
        }
        
        
        
        
    
        
    }
   
    return cell;
}
#pragma mark UITableViewDelegate委托方法
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return theWidth/2.0;
    }else if (indexPath.row == 1)
    {
        return theWidth/5.0;
    }else if (indexPath.row == 2)
    {
        return theWidth/2.5;
    }
    else if (indexPath.row == 3)
    {
        return theWidth/2.5;
    }
    else if (indexPath.row == 4)
    {
        return theWidth*0.107;
    }
    else if (indexPath.row == 5)
    {
        return theWidth/2.3;
    }else if (indexPath.row == 6)
    {
        return theWidth*0.107;
    }

    
    else {
        return theWidth/3;
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"index = %ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Foodmodel *fModel = [[Foodmodel alloc]init];
    if (indexPath.row >= 7 && indexPath.row <=  6+self.foodArr.count) {
        
        fModel =[self.foodArr objectAtIndex:indexPath.row - 7];
        StoresViewController  *storeCtr = [[StoresViewController alloc]init];
        storeCtr.model = fModel;
        storeCtr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeCtr animated:YES];
    }
    CinemaModel *model = [[CinemaModel alloc] init];
    if (indexPath.row > 6+self.foodArr.count) {
        model = [self.cinemaArr objectAtIndex:indexPath.row-7-self.foodArr.count];
        CinemaDetailViewController *cinemaCtr = [[CinemaDetailViewController alloc]init];
        cinemaCtr.cinemaModel = model;
        cinemaCtr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cinemaCtr animated:YES];
    }
    
}

//头部ScorllView点击事件
-(void)didSelectedLocalImageAtIndex:(NSInteger)index;
{
    NSLog(@"index = %ld",(long)index);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
 
    if (scrollView.frame.size.height*0.24-25 <= scrollView.contentOffset.y ) {
        
        _headView.backgroundColor = [UIColor orangeColor];
        _headView.alpha = 1;
    }
    else{
        _headView.backgroundColor = [UIColor clearColor];
        _headView.alpha = 0.5;
    }
}
#pragma mark 按钮事件
//城市选择按钮事件
-(void)theCityButtonAction:(UIButton *)button
{
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = @"1900020000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000",@"1900020000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}
//二维码扫描
-(void)theScanButtonAction:(UIButton *)button
{
    NSLog(@"二维码");
}
//铃铛按钮
-(void)theMsgButtonAction:(UIButton *)button
{
    NSLog(@"个人登录");
}
//全部电影
-(void)allMovieBtn:(UIButton *)button
{
    
    AllFilmViewController *allFVCtr = [[AllFilmViewController alloc] init];
    [allFVCtr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:allFVCtr animated:YES];
}
//泪流满面图片点击事件
-(void)tapAction1:(UITapGestureRecognizer *)tap1
{
    LSZKViewController *lSZKViewCtr = [[LSZKViewController alloc] init];
    [lSZKViewCtr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:lSZKViewCtr animated:YES];
    
}
//拉手来夺宝
-(void)tapAction2:(UITapGestureRecognizer *)tap1
{
    NSLog(@"拉手来夺宝");
}
//啤酒撸串
-(void)tapAction3:(UITapGestureRecognizer *)tap1
{
    NSLog(@"啤酒撸串");
}
//周末去嗨
-(void)tapAction4:(UITapGestureRecognizer *)tap1
{
    NSLog(@"周末去high");
}
//欢唱－－通宵
-(void)tapAction5:(UITapGestureRecognizer *)tap1
{
    NSLog(@"欢唱－－通宵");
}
//美丽瞬间
-(void)tapAction6:(UITapGestureRecognizer *)tap1
{
    NSLog(@"美丽瞬间");
    
}
//cell0里面八个按钮
- (void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case 2000:{
            NSLog(@"美食");
            [self.tabBarController setSelectedIndex:1];
//            SurroundViewController *surroundCtr = [[SurroundViewController alloc] init];
//            surroundCtr.hidesBottomBarWhenPushed = YES;
//            
//            [self.navigationController pushViewController:surroundCtr animated:YES];
            
        }
            break;
        case 2001:{
            MovieViewController *movieVCtr = [[MovieViewController alloc] init];
            [movieVCtr setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:movieVCtr animated:YES];
        }
            break;
        case 2002:{
            NSLog(@"酒店");
        }
            break;
        case 2003:{
            NSLog(@"休闲娱乐");
        }
            break;
        case 2004:{
            NSLog(@"自助餐");
        }
            break;
        case 2005:{
            NSLog(@"KTV");
        }
            break;
        case 2006:{
            NSLog(@"蛋糕甜品");
        }
            break;
        case 2007:{
            NSLog(@"美食");
        }
            break;
        default:{
            NSLog(@"旅游");
        }
            break;
    }
    
    
}
/**热映电影点击事件*/
-(void)hootFilmSingerTap:(UITapGestureRecognizer *)singerTap
{

    FilmCinemaViewController *filmCVCtr = [[FilmCinemaViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    filmCVCtr.model = [self.hotShowingArr objectAtIndex:singerTap.view.tag-1000];
    [self.navigationController pushViewController:filmCVCtr animated:YES];

}

#pragma mark 导航栏隐藏
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden= NO;
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    [cityButton setTitle:city.cityName forState:UIControlStateNormal];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
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
