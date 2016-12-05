//
//  FilmCinemaViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "FilmCinemaViewController.h"
#import "CinemaTableViewCell.h"
#import "FilmHeadView.h"
#import "FilmDetailViewController.h"
#import "PicRightButton.h"
#import "CLMainSelectedView.h"
#import "CinemaData.h"
#import "CinemaModel.h"
#import "CinemaDetailViewController.h"

@interface FilmCinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     CLMainSelectedView *_mainView;
     UIView *_theTableHeadView;
     NSMutableArray *_cinemaArry;//电影院数组
}
@property(nonatomic,strong)UITableView *theTableView;

@end

@implementation FilmCinemaViewController
-(NSMutableArray *)cinimaArry
{
    if (_cinemaArry == nil) {
        _cinemaArry = [[NSMutableArray alloc] init];
        CinemaData *cinemaD = [[CinemaData alloc] init];
        _cinemaArry = [cinemaD selectData];
    }
    return _cinemaArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _model.movieName;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    // 隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self addTableView];
    [self addTableHeadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTableView
{
    _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight) style:UITableViewStylePlain];
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    [self.view addSubview:_theTableView];
}
-(void)addTableHeadView
{
    _theTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.736)];
    _theTableView.tableHeaderView =_theTableHeadView;
    
    FilmHeadView *filmView = [[FilmHeadView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.5)];
    filmView.backImageView.image = [UIImage imageNamed:@"movie_poster_bg"];
    filmView.filmImageView.image = [UIImage imageNamed:_model.movieImageName];
    filmView.filmImageView1.image = [UIImage imageNamed:@"icon_account_head_arrow"];
    filmView.filmLb1.text = _model.movieName;
    filmView.filmLb2.text = [NSString stringWithFormat:@"片长:%ld分钟", _model.movieDuration];
    filmView.filmLb3.text = [NSString stringWithFormat:@"上映:%@", _model.movieTime];
    filmView.filmLb4.text = _model.movieStyle;
    filmView.filmLb5.text = [NSString stringWithFormat:@"%.1f分", _model.moviePingfen];
    filmView.filmLb6.text = _model.movieArea;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, theWidth*0.5+theWidth*0.125, theWidth, theWidth*0.236-theWidth*0.125)];
    imageView.image = [UIImage imageNamed:@"movie_2"];
    [_theTableHeadView addSubview:imageView];

    [_theTableHeadView addSubview:filmView];
    UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singerTapAction:)];
    [filmView addGestureRecognizer:singerTap];
    
    [self addPickView];
    
    
    
    
}
-(void)addPickView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"selection" object:nil];
    _mainView = [CLMainSelectedView show];
    _mainView.backgroundColor = [UIColor whiteColor];//colorWithRed:203/255.0 green:216/255.0 blue:203/255.0 alpha:0.5];
    _mainView.leftMenuSubViewHeight = 50;
    _mainView.middleMenuSubViewHeight = 50;
    _mainView.rightMenuSubViewHeight = 50;
    _mainView.leftMenuArrray = @[@"全部分类",@"美食",@"电影"];
    _mainView.middleMenuArray = @[@"全城",@"集美区",@"思明区",@"海沧区",@"湖里区"];
    _mainView.rightMenuArray = @[@"随机排序",@"评分最高",@"价格最低",@"价格最高"];
    _mainView.frame = CGRectMake(0, theWidth*0.5, theWidth, theWidth*0.125);
    _mainView.viewFrame = CGRectMake(0, _mainView.frame.origin.y+50, theWidth, theHeight);
    NSLog(@"%lf", _mainView.frame.origin.y);
    [_theTableHeadView addSubview:_mainView];


//    UIView *pickView = [[UIView alloc] initWithFrame:CGRectMake(0, theWidth*0.5, theWidth, theWidth*0.125)];
//    pickView.backgroundColor = [UIColor yellowColor];
//    [_theTableHeadView addSubview:pickView];
//    
//    PicRightButton *picRBtn = [[PicRightButton alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.13, theWidth*0.125/2)];
//    //    picRBtn.backgroundColor = [UIColor yellowColor];
//    [picRBtn setTitle:@"全城" forState:UIControlStateNormal];
//    [picRBtn setImage:[UIImage imageNamed:@"icon_conditionBarArrow_normal"] forState:UIControlStateNormal];
//    [pickView addSubview:picRBtn];
}
#pragma mark 获取选择的类别通知
- (void)notification:(NSNotification *)notifica{
    
    
    if ([_mainView.leftMenuArrray containsObject:notifica.object]) {
        
        [_mainView.leftButton setTitle:notifica.object forState:UIControlStateNormal];
    }
    if ([_mainView.middleMenuArray containsObject:notifica.object]) {
        
        [_mainView.middleButton setTitle:notifica.object forState:UIControlStateNormal];
    }
    else if ([_mainView.rightMenuArray containsObject:notifica.object]) {
        
        [_mainView.rightButton setTitle:notifica.object forState:UIControlStateNormal];
    }
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
        cell.cinemaLb6.text = @"今天14:10|15.05|16:50";
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CinemaDetailViewController *cinemaDatailVCtr = [[CinemaDetailViewController alloc] init];
    cinemaDatailVCtr.cinemaModel = [self.cinimaArry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:cinemaDatailVCtr animated:YES];
    
}

#pragma mark 点击事件
-(void)singerTapAction:(UITapGestureRecognizer *)singerTap
{
    FilmDetailViewController *filmDVCtr = [[FilmDetailViewController alloc] init];
    filmDVCtr.movieDatModel = _model;
    
    [self.navigationController pushViewController:filmDVCtr animated:YES];
    
}
#pragma mark 视图消失
- (void)viewWillDisappear:(BOOL)animated;{
    
    [_mainView removeMenu];
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
