//
//  FilmDetailViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "FilmDetailViewController.h"
#import "FilmHeadView.h"
#import "FilmCinemaViewController.h"

@interface FilmDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_theTableView;
//    UIView *_theTableHeadView;//头部视图
    int _index;
    UILabel *lb2;
    UIView * view ;
    UIImageView *imgV;
    UIView * theTableHeadView;
}
@end

@implementation FilmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _movieDatModel.movieName;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addTableView];//添加tableView
    [self addTableHeadView:NO];//添加头部视图  两种状态
   
    [self addbuyView];//添加选座购买View
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//添加选座购买按钮
-(void)addbuyView
{
    UIView *buyView = [[UIView alloc] initWithFrame:CGRectMake(0, theHeight-theWidth*0.14-64, theWidth, theWidth*0.14)];
    buyView.backgroundColor = [UIColor orangeColor];
    UILabel *buyLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.14)];
    buyLb.textAlignment = NSTextAlignmentCenter;
    buyLb.text = @"选座购买";
    buyLb.textColor = [UIColor whiteColor];
    [buyView addSubview:buyLb];
    [ self.view addSubview:buyView];
    
    UITapGestureRecognizer *buyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyTapAction:)];
    [buyView addGestureRecognizer:buyTap];
}

-(void)addTableView
{
    _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64-theWidth*0.14) style:UITableViewStylePlain];
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    [self.view addSubview:_theTableView];
}
//添加头部视图  两种状态
-(void)addTableHeadView:(BOOL)isOPen
{
    if (isOPen) {
        [self addHeadView];//添加头部视图
        CGSize size = [lb2.text boundingRectWithSize:CGSizeMake(theWidth*0.7, 2000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;//    通过字体和文字获取文字的宽和高
        lb2.frame = CGRectMake(theWidth*0.04+theWidth*0.15, theWidth*0.046+theWidth*0.5,theWidth*0.7 , size.height);
//        lb2.font = [UIFont systemFontOfSize:15];
        view.frame = CGRectMake(0, theWidth*0.046+theWidth*0.5+size.height+10, theWidth, theWidth*0.084);
        theTableHeadView.frame = CGRectMake(0, 0, theWidth, theWidth+size.height-theWidth*0.36);
        imgV.image = [UIImage imageNamed: @"all_category_up"];
        _theTableView.tableHeaderView = theTableHeadView;
        
    } else {
        [self addHeadView];//添加头部视图
        lb2.frame = CGRectMake(theWidth*0.04+theWidth*0.15, theWidth*0.046+theWidth*0.5,theWidth*0.7 , theWidth*0.36);
        view.frame = CGRectMake(0, theWidth*0.046+theWidth*0.5+theWidth*0.36+10, theWidth, theWidth*0.084);
        theTableHeadView.frame = CGRectMake(0, 0, theWidth, theWidth);
        imgV.image = [UIImage imageNamed: @"all_category_down"];
        _theTableView.tableHeaderView = theTableHeadView;
    }
}
//添加头部视图
-(void)addHeadView;
{
    theTableHeadView = [[UIView alloc] init];
    
    FilmHeadView *filmView = [[FilmHeadView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.5)];
    filmView.backImageView.image = [UIImage imageNamed:@"movie_poster_bg"];
    filmView.filmImageView.image = [UIImage imageNamed:@"movie01"];
    [theTableHeadView addSubview:filmView];
    filmView.backImageView.image = [UIImage imageNamed:@"movie_poster_bg"];
    filmView.filmImageView.image = [UIImage imageNamed:_movieDatModel.movieImageName];
    filmView.filmImageView1.image = [UIImage imageNamed:@""];
    filmView.filmLb1.text = _movieDatModel.movieName;
    filmView.filmLb2.text = [NSString stringWithFormat:@"片长:%ld分钟", _movieDatModel.movieDuration];
    filmView.filmLb3.text = [NSString stringWithFormat:@"上映:%@", _movieDatModel.movieTime];
    filmView.filmLb4.text = _movieDatModel.movieStyle;
    filmView.filmLb5.text = [NSString stringWithFormat:@"%.1f分", _movieDatModel.moviePingfen];
    filmView.filmLb6.text = _movieDatModel.movieArea;
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.046, theWidth*0.046+theWidth*0.5, theWidth*0.15, theWidth*0.04)];
    lb1.text = @"剧情：";
    lb1.textColor = [UIColor grayColor];
    [theTableHeadView addSubview:lb1];
    
    
    lb2 = [[UILabel alloc] init];
    UIFont *theFont = [UIFont systemFontOfSize:16];
    lb2.font = theFont;
    lb2.numberOfLines = 0;
    lb2.textColor = [UIColor grayColor];
    lb2.text = _movieDatModel.movieIntroduce;
    
    view = [[UIView alloc] init];
    
    imgV= [[UIImageView alloc] initWithFrame:CGRectMake((theWidth-30)/2, (theWidth*0.084-15)/2, 30, 15)];
    [view addSubview:imgV];
    UITapGestureRecognizer *xialaTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(theTapAction:)];
    [view addGestureRecognizer:xialaTap];
    [theTableHeadView addSubview:lb2];
    [theTableHeadView addSubview:view];
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
    return 5;
}
//数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row ==0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:242/255.0 alpha:1];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
    }else if (indexPath.row ==1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.037, theWidth*0.037, theWidth*0.15, theWidth*0.065)];
        lb.text = @"剧照";
        lb.font = [UIFont systemFontOfSize:20];
        [cell.contentView addSubview:lb];
       
        
        NSArray *arrayStagePho = [NSKeyedUnarchiver unarchiveObjectWithData:_movieDatModel.movieStagePhotoArr];
       //    添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, theWidth*0.149, theWidth, theWidth*0.2)];
        scrollView.contentSize = CGSizeMake(10+arrayStagePho.count*(theWidth*0.2+10), 0);
        
        //    设置是否可以显示滚动条Indicator
        scrollView.showsHorizontalScrollIndicator = NO;
//        //      从model导入数据
        
        for (int i = 0; i<arrayStagePho.count; i++) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*(theWidth*0.2+10),0,theWidth*0.2 , theWidth*0.2)];
            imgView.image = [UIImage imageNamed:[arrayStagePho objectAtIndex:i]];
            [scrollView addSubview:imgView];
        }
        [cell.contentView addSubview:scrollView];
        
        
        
    }else if (indexPath.row ==2) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:242/255.0 alpha:1];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
    }else if (indexPath.row ==3) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
        cell.textLabel.text = @"评价";
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    else {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;//cell设置为无法点击
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth, theWidth*0.1)];
        lb.text = @"暂无评论";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lb];
      
    }
    
    

    
    return cell;
}
#pragma mark UITableViewDelegate委托方法
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return theWidth*0.047;
    }
    if (indexPath.row == 1) {
        return theWidth*0.37;
    }
    if (indexPath.row == 2) {
        return theWidth*0.047;
    }else{
        return theWidth*0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%ld",indexPath.row);
    
}

#pragma mark 点击事件
-(void)buyTapAction:(UITapGestureRecognizer *)buyTap
{
//    FilmCinemaViewController *film = [[FilmCinemaViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)theTapAction:(UITapGestureRecognizer *)tap
{
    
    if (_index%2 == 0) {
        NSLog(@"下拉");
        [self addTableHeadView:YES];
        
//        [_theTableView reloadData];
    }else{
        NSLog(@"上拉");
        [self addTableHeadView:NO];
//        lb2.frame = CGRectMake(theWidth*0.04+theWidth*0.15, theWidth*0.046+theWidth*0.5,theWidth*0.7 , theWidth*0.36);
//        view.frame = CGRectMake(0, theWidth*0.046+theWidth*0.5+theWidth*0.36+10, theWidth, theWidth*0.084);
//        _theTableHeadView.frame = CGRectMake(0, 0, theWidth, theWidth);
//        imgV.image = [UIImage imageNamed: @"all_category_down"];
//        [_theTableView reloadData];
    }
    _index++;
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
