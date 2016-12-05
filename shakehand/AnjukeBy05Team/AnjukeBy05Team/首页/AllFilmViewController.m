//
//  AllFilmViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "AllFilmViewController.h"
#import "CinemaTableViewCell.h"
#import "HotShowingTableViewCell.h"
#import "MovieData.h"
#import "FilmCinemaViewController.h"
#import "movieModel.h"
#import "CinemaData.h"
#import "CinemaModel.h"

@interface AllFilmViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *leftTableview;
    UITableView *rightTableview;
    UIScrollView *scrollView;
    NSMutableArray *_hotShowingArr;
    NSMutableArray *_willShowArr;
    NSMutableArray *_cinemaArry;//电影院数组
}

@end

@implementation AllFilmViewController
-(NSMutableArray *)cinemaArry
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
//                NSLog(@"hot = %@",_hotShowingArr);
            }
        }
       
    }
    return _hotShowingArr;
}
/** 即将上映*/
- (NSMutableArray *)willShowArr{
    
    if (_willShowArr == nil) {
        
        _willShowArr = [[NSMutableArray alloc]init];
        MovieData  *movieData = [[MovieData alloc]init];
        NSMutableArray *tempArr = [movieData selectData];
        for (movieModel *model in tempArr) {
            if (model.moviePlayTime == 7 || model.moviePlayTime == 8 ) {
                
                [_willShowArr addObject:model];
            }
        }
        
    }
    return _willShowArr;
}
 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    // 隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self addsegmentedCtr];
    [self addScrollView];
//    更改segmentedCtr的点击事件
    _segmentedCtr.selectedSegmentIndex = _number;
    [self segmentAction:_segmentedCtr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)notificationAction:(NSNotification *)notifiction
{
    _segmentedCtr.selectedSegmentIndex = 1;
}

-(void)addsegmentedCtr
{
    NSArray *segmentedArray = @[@"正在热映",@"即将上映"];
    _segmentedCtr = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    _segmentedCtr.frame = CGRectMake(0, 0, theWidth*0.557, 28);
    [_segmentedCtr sizeToFit];
    _segmentedCtr.selectedSegmentIndex = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:@"willShow" object:nil];
//    segmentedCtr.backgroundColor = [UIColor blueColor];
    self.navigationItem.titleView = _segmentedCtr;
    
    [_segmentedCtr addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedCtr];
//    self.navigationItem.rightBarButtonItem = rightItem;
}
//segment 点击事件
- (void)segmentAction:(UISegmentedControl *)segmentCtr{
    
    if (segmentCtr.selectedSegmentIndex == 0) {
        
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else{
        
        [scrollView setContentOffset:CGPointMake(theWidth, 0) animated:YES];
    }
    
}
//添加滚动视图，在滚动视图上添加两个tableView
-(void)addScrollView
{
//  添加scrollView
    self.edgesForExtendedLayout = UIRectEdgeNone;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(theWidth*2, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
//   scrollView上添加leftTableview
    leftTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64) style:UITableViewStylePlain];
    leftTableview.delegate = self;
    leftTableview.dataSource = self;
    [scrollView addSubview: leftTableview];
 //   scrollView上添加rightTableview
    rightTableview = [[UITableView alloc] initWithFrame:CGRectMake(theWidth, 0, theWidth, theHeight-64) style:UITableViewStylePlain];
    rightTableview.delegate = self;
    rightTableview.dataSource = self;
    [scrollView addSubview: rightTableview];
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
    if ([tableView isEqual:leftTableview]) {
        return self.hotShowingArr.count;
    } else if ([tableView isEqual:rightTableview]) {
        return self.willShowArr.count;
    }
    return 0;

}
//数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if ([tableView isEqual:leftTableview]) {
        NSString *identifier = @"myCell";
        HotShowingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (self) {
            cell = [[HotShowingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            movieModel *model = [[movieModel alloc] init];
            model = [self.hotShowingArr objectAtIndex:indexPath.row];
            NSLog(@"model = %@",model);
            cell.hotImageView.image = [UIImage imageNamed:model.movieImageName] ;
            cell.hotLb1.text = model.movieName;
            cell.hotLb2.text = model.movieIntroduce;
            cell.hotLb3.text = [NSString stringWithFormat:@"今天%ld家影院上映%ld场",self.cinemaArry.count,self.cinemaArry.count*3];
            cell.hotLb4.text = [NSString stringWithFormat:@"%.1f",model.moviePingfen];
            return cell;
        }
//        MovieData *movieData = [[MovieData alloc]init];
//        NSArray *movieArr = [movieData selectData];
//        cell.hotImageView.image = [UIImage imageNamed:<#(nonnull NSString *)#>]
        
        

    } else if ([tableView isEqual:rightTableview]) {
        NSString *identifier = @"myCell";
        HotShowingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (self) {
            cell = [[HotShowingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            movieModel *model = [[movieModel alloc] init];
            model = [self.willShowArr objectAtIndex:indexPath.row];
            cell.hotImageView.image = [UIImage imageNamed:model.movieImageName] ;
            cell.hotLb1.text = model.movieName;
            cell.hotLb2.text = model.movieIntroduce;
            cell.hotLb3.text = [NSString stringWithFormat:@"%ld月份上映",model.moviePlayTime];
            return cell;
        }
    }
    return nil;
}
#pragma mark UITableViewDelegate委托方法
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return theWidth*0.362;

}
/**cell点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%ld",indexPath.row);
    
    FilmCinemaViewController *filmCnmVCtr = [[FilmCinemaViewController alloc] init];

    [self.navigationController pushViewController:filmCnmVCtr animated:YES];
    
    if ([tableView isEqual:leftTableview]) {
        filmCnmVCtr.model = [self.hotShowingArr objectAtIndex:indexPath.row];
    } else if ([tableView isEqual:rightTableview]) {
        filmCnmVCtr.model = [self.willShowArr objectAtIndex:indexPath.row];
    }

}



#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1;
{
    if ([scrollView1 isMemberOfClass:[scrollView class]]) {

        if (scrollView1.contentOffset.x == 0) {
            
            _segmentedCtr.selectedSegmentIndex = 0;
        }
        else  {
            
            _segmentedCtr.selectedSegmentIndex = 1;
        }
    }
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
