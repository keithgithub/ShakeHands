//
//  CinemaDetailViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CinemaDetailViewController.h"
#import "MovieData.h"
#import "movieModel.h"
#import "XuanzuoTableViewCell.h"
#import "FilmView.h"
#import "FilmScrollView.h"
#import "CinemaData.h"
#import "CinemaModel.h"
#import "ChooseSeatViewController.h"
#import "GoodsPayViewController.h"
#import "UserModel.h"
#import "LogonViewController.h"

@interface CinemaDetailViewController ()<UITableViewDataSource,UITableViewDelegate,FilmScrollViewDelegate,FilmScrollViewDataSource>
{
    FilmView *mView;
    NSMutableArray *images;
    NSString *coverString;
    NSInteger mIndex;
    NSMutableArray *_cinimaArry;
    NSMutableArray *_hotShowingArr;
    UILabel *cell3Lb1;
    UILabel *cell3Lb2;
    UILabel *cell3Lb3;
    NSString   *textStr;
    UserModel  *_userModel;
    
}


@end

static BOOL isLogin;

@implementation CinemaDetailViewController
/**懒加载 电影院数组*/
-(NSMutableArray *)cinimaArry
{
    if (_cinimaArry == nil) {
        _cinimaArry = [[NSMutableArray alloc] init];
        CinemaData *cinemaD = [[CinemaData alloc] init];
        _cinimaArry = [cinemaD selectData];
    }
    return _cinimaArry;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mIndex = 0;
    self.title = @"影院详情";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self addTableView];
    
    _userModel = [[UserModel alloc]init];
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
    NSLog(@"-------%d",isLogin);
    isLogin = [userDeafaults integerForKey:@"login"] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableView
{
    _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight) style:UITableViewStylePlain];
    _theTableView.delegate = self;
    _theTableView.dataSource = self;
//    _theTableView.allowsSelection = NO;
    [self.view addSubview:_theTableView];
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
    return 7;
}
//数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (indexPath.row == 0) {
        //        cell第0行 用for循环添加八个按钮
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.037, theWidth*0.037, theWidth*0.254, theWidth*0.254)];
        imgView.image = [UIImage imageNamed:_cinemaModel.cinemaImageName];
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.33, theWidth*0.056, theWidth*0.5, theWidth*0.056)];
        lb1.text = _cinemaModel.cinemaName;
        lb1.font = [UIFont systemFontOfSize:18];
        
        UIImageView *imgview1 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.334, theWidth*0.19, theWidth*0.25, theWidth*0.05)];
        imgview1.image = [UIImage imageNamed:@"movie_wuxing"];
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.345, theWidth*0.16, theWidth*0.2, theWidth*0.23)];
        lb2.text = @"停车场";
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:lb1];
        [cell.contentView addSubview:lb2];
        [cell.contentView addSubview:imgview1];
        
        
    }else if (indexPath.row ==1){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, theWidth*0.056, theWidth*0.04, theWidth*0.056)];
        imgView.image = [UIImage imageNamed:@"detail_address_pic"];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.09, (theWidth*0.16-theWidth*0.116)/2, theWidth*0.75, theWidth*0.116)];
        lb.text = _cinemaModel.cinemaAdress;
        lb.numberOfLines = 0;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(theWidth*0.9, theWidth*0.045, theWidth*0.06, theWidth*0.06)];
        [btn setImage:[UIImage imageNamed:@"detail_phone"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(theCallBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:lb];
        [cell.contentView addSubview:btn];
    }else if (indexPath.row ==2){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        movieModel *model = [[movieModel alloc]init];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i = 0;i < _cinemaModel.cinemaMovieNumb;i++) {
            
             model = [self.hotShowingArr objectAtIndex:i];
            [arr addObject:model];
        }
        FilmView *view = [self addBackImgae:arr];
        [cell.contentView addSubview:view];
        
    }else if (indexPath.row ==3){
        
        cell.tag = 06201411;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        //添加电影名lb
        movieModel *model = [[movieModel alloc]init];
        model = [self.hotShowingArr objectAtIndex:0];
        textStr = model.movieName;
        CGSize size =[textStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];//通过字体大小和个数获取label的长宽
        cell3Lb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.058, theWidth*0.037, size.width+10,size.height)];
        cell3Lb1.text = textStr;
        cell3Lb1.font = [UIFont boldSystemFontOfSize:20];
//        添加评分lb
        cell3Lb2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.058+size.width+5, theWidth*0.037, theWidth*0.14,size.height )];
        cell3Lb2.text = [NSString stringWithFormat:@"%.1f分", model.moviePingfen];
        cell3Lb2.textColor = [UIColor orangeColor];
        
        cell3Lb3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.058, theWidth*0.11, theWidth*0.3, theWidth*0.042)];
        cell3Lb3.text = [NSString stringWithFormat:@"片长：%ld分钟", model.movieDuration];
        cell3Lb3.textColor = [UIColor lightGrayColor];
        cell3Lb3.font = [UIFont systemFontOfSize:14];
        
        [cell.contentView addSubview:cell3Lb1];
        [cell.contentView addSubview:cell3Lb2];
        [cell.contentView addSubview:cell3Lb3];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }else if (indexPath.row ==4){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UILabel *labTime = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, theWidth/4, theWidth*0.09)];
        labTime.text = [NSString stringWithFormat:@"今天 %@",[self dateStringWithDate:[NSDate date] DateFormat:@"MM.dd"]];
        labTime.font = [UIFont systemFontOfSize:15.0];
        labTime.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:labTime];
        
    }else if (indexPath.row ==5){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.11)];
        imgView.image = [UIImage imageNamed:@"movie_wxts"];
        [cell.contentView addSubview:imgView];
        
    }else{
        
        XuanzuoTableViewCell *xuanzuoCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        xuanzuoCell = [[XuanzuoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        xuanzuoCell.xuanLb5.text = [NSString stringWithFormat:@"¥%ld",_cinemaModel.cinemaLowPrice];
        xuanzuoCell.xuanLb6.text = [NSString stringWithFormat:@"影院价%.2f",_cinemaModel.cinemaLowPrice*1.5];
        
        
        return xuanzuoCell;
    }
    
        return cell;
        
   
}
#pragma mark 转为日期选择格式
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

#pragma mark UITableViewDelegate委托方法
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row ==0) {
        return theWidth*0.32;
    }else if(indexPath.row == 1){
        return theWidth*0.16;
    }else if(indexPath.row == 2){
        return theWidth*0.446;
    }else if(indexPath.row == 3){
        return theWidth*0.2;
    }else if(indexPath.row == 4){
        return theWidth*0.09;
    }else if(indexPath.row == 5){
        return theWidth*0.11;
    }else{
        return theWidth*0.19;
    }
}
/**cell点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (isLogin) {
        
        if (indexPath.row >= 6) {
            
            GoodsPayViewController *payView = [[GoodsPayViewController alloc] init];
            payView.mModel = images[mIndex];
            payView.cinemaModel = _cinemaModel;
            [self.navigationController pushViewController:payView animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }else{
        LogonViewController *loginCtr = [[LogonViewController alloc]init];
        loginCtr.isNormalLogin = NO;
        [self.navigationController pushViewController:loginCtr animated:YES];
    }
}
#pragma mark 按钮事件
-(void)theCallBtnAction:(UIButton *)btn
{
    NSLog(@"电话");
}



#pragma mark 添加电影滚动背景
- (FilmView *)addBackImgae:(NSMutableArray *)imageArr
{
    images = [NSMutableArray arrayWithCapacity:10];
    //滚动电影图
    mView = [[FilmView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, theWidth*0.446)];
    mView.pageScrollView.dataSource = self;
    mView.pageScrollView.delegate = self;
    mView.pageScrollView.padding = 20;
    mView.pageScrollView.leftRightOffset = 0;
    mView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -100)/2, 10, 100, theWidth*0.446);
    images = imageArr;
    if (images.count > 0) {
        movieModel *mModel = images[0];
        coverString = mModel.movieImageName;
    }
    [mView.pageScrollView reloadData];
    return mView;
    //    [self.view addSubview:mView];
}
#pragma mark - scrollView delegate,电影滚动图
- (NSInteger)numberOfPageInPageScrollView:(FilmScrollView*)pageScrollView{
    return [images count];
}
- (UIView*)pageScrollView:(FilmScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 100)];
    cell.tag = 40000+index;
//    cell.backgroundColor = [UIColor purpleColor];
    UIImageView *netImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    netImageView.tag = 30000+index;
    movieModel *mModel = images[index];
    netImageView.image = [UIImage imageNamed:mModel.movieImageName];
    
    [cell addSubview:netImageView];
    if (index == 0) {
        cell.frame = CGRectMake(-5, -15, 90, 120);
        netImageView.frame = CGRectMake(-5, -15, cell.frame.size.width, cell.frame.size.height);
        netImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        netImageView.layer.borderWidth = 5;
    }
    return cell;
}
- (CGSize)sizeCellForPageScrollView:(FilmScrollView*)pageScrollView
{
    return CGSizeMake(80, 100);
}
/**点击*/
- (void)pageScrollView:(FilmScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    mIndex = index;
    UIView *cell = (UIView *)[mView viewWithTag:40000+index];
    UIImageView *netImageView = (UIImageView *)[cell viewWithTag:30000+index];
    netImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    netImageView.layer.borderWidth = 5;
    [UIView animateWithDuration:0.3 animations:^{
        netImageView.frame = CGRectMake(-5, -15, 90, 120);
         movieModel *mModel = images[index];
        coverString = mModel.movieImageName;
    }];
    for (int i = 0; i < images.count; i++) {
        if (i != index) {
            UIView *cell = (UIView *)[mView viewWithTag:40000+i];
            UIImageView *netImageView = (UIImageView *)[cell viewWithTag:30000+i];
            netImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            netImageView.layer.borderWidth = 0;
            [UIView animateWithDuration:0.3 animations:^{
                netImageView.frame = CGRectMake(0, -5, 80, 100);
            }];
        }
    }
    //    _selectMovieTag = 30000+index;
    //
    //    NSNumber *movieNumb = [NSNumber numberWithInteger:30000+index];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"选中某个电影" object:movieNumb];
    NSLog(@"30000+index = %ld",30000+index);
//    UITableViewCell *myCell = [_theTableView viewWithTag:06201411];
    movieModel *mModel = images[index];
//    cell3Lb1.text = mModel.movieName;
    textStr = mModel.movieName;
    cell3Lb1.text = textStr;
    CGSize size =[textStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];//通过字体大小和个数获取label的长宽
    cell3Lb1.frame = CGRectMake(theWidth*0.058, theWidth*0.037, size.width+10,size.height);
    cell3Lb2.text = [NSString stringWithFormat:@"%.1f分",mModel.moviePingfen];
    cell3Lb2.frame = CGRectMake(theWidth*0.058+size.width+5, theWidth*0.037, theWidth*0.14,size.height );
    cell3Lb3.text = [NSString stringWithFormat:@"片长：%ld分钟",mModel.movieDuration];
    
//    [_theTableView.indexPathForSelectedRow reloadData];
    NSLog(@"%@",images[index]);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    NSLog(@"mIndex  = %ld",mIndex);
    mIndex = index;
    UIView *cell = (UIView *)[mView viewWithTag:40000+index];
    UIImageView *netImageView = (UIImageView *)[cell viewWithTag:30000+index];
    netImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    netImageView.layer.borderWidth = 5;
    [UIView animateWithDuration:0.3 animations:^{
        netImageView.frame = CGRectMake(-5, -15, 90, 120);
        movieModel *mModel = images[index];
        coverString = mModel.movieImageName;
    }];
    for (int i = 0; i < images.count; i++) {
        if (i != index) {
            UIView *cell = (UIView *)[mView viewWithTag:40000+i];
            UIImageView *netImageView = (UIImageView *)[cell viewWithTag:30000+i];
            netImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            netImageView.layer.borderWidth = 0;
            [UIView animateWithDuration:0.3 animations:^{
                netImageView.frame = CGRectMake(0, -5, 80, 100);
            }];
        }
    }
    //    _selectMovieTag = 30000+index;
    //    NSNumber *movieNumb = [NSNumber numberWithInteger:30000+index];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"选中某个电影" object:movieNumb];
    NSLog(@"30000+index = %ld",30000+index);
    movieModel *mModel = images[index];
    textStr = mModel.movieName;
//    cell3Lb1.text = mModel.movieName;
    cell3Lb1.text = textStr;
    CGSize size =[textStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];//通过字体大小和个数获取label的长宽
    cell3Lb1.frame = CGRectMake(theWidth*0.058, theWidth*0.037, size.width+10,size.height);
    cell3Lb2.text = [NSString stringWithFormat:@"%.1f分",mModel.moviePingfen];
    cell3Lb2.frame = CGRectMake(theWidth*0.058+size.width+5, theWidth*0.037, theWidth*0.14,size.height );
    cell3Lb3.text = [NSString stringWithFormat:@"片长：%ld分钟",mModel.movieDuration];
    
//    [_theTableView reloadData];

}
#pragma mark视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
    isLogin = [userDeafaults integerForKey:@"login"] ;
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
