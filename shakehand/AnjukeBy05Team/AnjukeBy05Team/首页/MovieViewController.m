//
//  MovieViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieData.h"
#import "movieModel.h"
#import "CinemaTableViewCell.h"
#import "AllFilmViewController.h"
#import "CinemaDetailViewController.h"
#import "FilmCinemaViewController.h"
#import "CinemaData.h"
#import "CinemaModel.h"
#import "SearchViewController.h"


@interface MovieViewController ()
{
    UIView *theTableHeadView;//头部视图
    NSMutableArray *_cinemaArry;//电影院数组
    NSMutableArray *_hotShowingArr;//热映电影数组
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation MovieViewController
-(NSMutableArray *)cinimaArry
{
    if (_cinemaArry == nil) {
        _cinemaArry = [[NSMutableArray alloc] init];
        CinemaData *cinemaD = [[CinemaData alloc] init];
        _cinemaArry = [cinemaD selectData];
    }
    return _cinemaArry;
}
/**  懒加载 电影数组 */
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"电影";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    // 隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self addNavigationBar];//导航栏添加按钮
    [self addTheTableHeadView];//添加头部视图
}
//导航栏添加按钮
-(void)addNavigationBar;
{
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [searchBtn setImage:[UIImage imageNamed:@"icon_nav_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *mapBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [mapBtn setImage:[UIImage imageNamed:@"detail_address"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(mapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightTtem1 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:mapBtn];
    self.navigationItem.rightBarButtonItems = @[rightTtem1,rightItem2];
}

//头部视图
-(void)addTheTableHeadView
{
//    添加头部视图
    theTableHeadView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*1.16)];
//    头部视图添加图片(4个按钮)
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.325)];
    imageView.image = [UIImage imageNamed:@"movie_btn"];
    [theTableHeadView addSubview:imageView];
    for (int i=0; i<4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(theWidth/4.0*i, 0, theWidth/4.0, theWidth*0.3)];
        UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singerTapAction:)];
        [imageView addSubview:view];
        view.tag = 3000+i;
        [imageView setUserInteractionEnabled:YES];
        [view addGestureRecognizer:singerTap];
    }
    
//    头部视图添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, theWidth*0.325, theWidth, theWidth*0.557)];
    scrollView.contentSize = CGSizeMake(10+self.hotShowingArr.count*(theWidth*0.266+10)+theWidth*0.266/3.5+20, 0);
    [theTableHeadView addSubview:scrollView];
    //    设置是否可以显示滚动条Indicator
    scrollView.showsHorizontalScrollIndicator = NO;
   
    movieModel *model = [[movieModel alloc]init];
    for (int i = 0; i<self.hotShowingArr.count; i++) {
        model = [self.hotShowingArr objectAtIndex:i];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10+i*(theWidth*0.266+10),10,theWidth*0.266 , theWidth*0.513-10)];
        view.tag = 4000+i;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.266, theWidth*0.383)];
        imageView.image = [UIImage imageNamed:model.movieImageName];
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, theWidth*0.383+5, theWidth*0.266, theWidth*0.065)];//电影名lb1
        lb1.font = [UIFont systemFontOfSize:14];
        lb1.text = model.movieName;
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, theWidth*0.383+theWidth*0.065, theWidth*0.266, theWidth*0.065)];//评分lb2
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textColor = [UIColor redColor];
        lb2.text = [NSString stringWithFormat:@"%.1f分", model.moviePingfen];
        //            在view上添加单击事件
        UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filmSingerTap:)];
        [view addGestureRecognizer:singerTap];
        [view addSubview:lb2];
        [view addSubview:lb1];
        [view addSubview:imageView];
        [scrollView addSubview:view];
    }
    //        添加全部电影按钮
    UIButton *allMovieBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+self.hotShowingArr.count*(theWidth*0.266+10), 10, theWidth*0.266/3.5, theWidth*0.45-10)];
    [allMovieBtn setImage:[UIImage imageNamed:@"btn_movie_more_nor"] forState:UIControlStateNormal];
    [allMovieBtn addTarget:self action:@selector(allMovieBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:allMovieBtn];
    
//    添加灰色分界线
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, theWidth*0.325+theWidth*0.557, theWidth, theWidth*0.046)];
    imgView.image = [UIImage imageNamed:@"movie_1"];
    [theTableHeadView addSubview:imgView];
    
//    添加位置
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,theWidth*1.16-theWidth*0.11 , theWidth, theWidth*0.11)];
    imgView1.image = [UIImage imageNamed:@"movie_2"];
    [theTableHeadView addSubview:imgView1];
    
    
    _theTableView.tableHeaderView = theTableHeadView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.cinimaArry.count;
}
//数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *identifier = @"myCell";
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self) {
        cell = [[CinemaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        CinemaModel *model = [[CinemaModel alloc] init];
        model = [self.cinimaArry objectAtIndex:indexPath.row];
        cell.cinemaLb1.text = model.cinemaName;
        cell.cinemaLb2.text = model.cinemaAdress;
        cell.cinemaLb4.text = [NSString stringWithFormat:@"%ld",model.cinemaLowPrice];
        cell.cinemaLb6.text = [NSString stringWithFormat:@"今日放映%ld部余%ld场",model.cinemaMovieNumb,model.cinemaSessionNumb];
        cell.cinemaLb7.text = [NSString stringWithFormat:@"(%@)",model.cinemaDistrict];
        cell.cinemaLb8.text = [NSString stringWithFormat:@"%.1fkm",model.cinemaDistance];
        
    }
    return cell;
}
#pragma mark UITableViewDelegate委托方法
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return theWidth*0.284;
}
/**cell点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%ld",indexPath.row);
    CinemaDetailViewController *cDVCtr = [[CinemaDetailViewController alloc] init];
    cDVCtr.cinemaModel = [self.cinimaArry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:cDVCtr animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 按钮事件
//地图按钮（导航栏）
-(void)mapBtnAction:(UIButton *)button
{
    NSLog(@"地图");
}
//搜索按钮（导航栏）
-(void)searchBtnAction:(UIButton *)button
{
    NSLog(@"搜索");
    SearchViewController *searchVCtr = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVCtr animated:YES];
}
//正在热映 即将上映 影院选座 影票团购 按钮
-(void)singerTapAction:(UITapGestureRecognizer *)singerTap
{
    AllFilmViewController *allFVCtr = [[AllFilmViewController alloc] init];
    switch (singerTap.view.tag) {
        case 3000:{
            [allFVCtr setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:allFVCtr animated:YES];
            
        }
            break;
        case 3001:{
            [allFVCtr setHidesBottomBarWhenPushed:YES];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"willShow"  object:nil];
            
            NSLog(@"123456788");
            allFVCtr.number = 1;
            [self.navigationController pushViewController:allFVCtr animated:YES];
            
        }
            break;
        case 3002:{
            NSLog(@"影院选座");
            [_theTableView setContentOffset:CGPointMake(0, theHeight*0.42) animated:NO];
        }
            break;
            
            
        default:{
            NSLog(@"影票团购");
            [_theTableView setContentOffset:CGPointMake(0, theHeight*0.42) animated:NO];
        }
            break;
    }

}
//电影scrollView 点击事件
-(void)filmSingerTap:(UITapGestureRecognizer *)filmSingerTap
{
       NSLog(@"%ld",filmSingerTap.view.tag);
    FilmCinemaViewController *filmCVCtr = [[FilmCinemaViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    filmCVCtr.model = [self.hotShowingArr objectAtIndex:filmSingerTap.view.tag-4000];
    [self.navigationController pushViewController:filmCVCtr animated:YES];
//    switch (filmSingerTap.view.tag) {
//        case 3000:{
//                  }
//            break;
//        case 3001:{
//             }
//            break;
//        case 3002:{
//             }
//            break;
//
//            
//        default:{
//             }
//            break;
//    }
    
}
//全部影片按钮
-(void)allMovieBtn:(UIButton *)button
{
    AllFilmViewController *allFVCtr = [[AllFilmViewController alloc] init];
    [allFVCtr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:allFVCtr animated:YES];
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
