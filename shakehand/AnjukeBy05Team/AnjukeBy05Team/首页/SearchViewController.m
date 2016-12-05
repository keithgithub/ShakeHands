//
//  SearchViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "SearchViewController.h"
#define ButtonSize 36
@interface SearchViewController ()<UIScrollViewDelegate>
{
    UIButton *backButton;// 自定义返回按钮
    UIPageControl *pageControl; // 在UIScrollView视图 上添加的UIPageControl
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    // 搜索栏下方的关键词栏
    [self keyWordSearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    // 自定义Items
    //返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    backButton.frame = CGRectMake(0, 0, ButtonSize, ButtonSize);
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:  UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    //搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0.6*theWidth, ButtonSize)];
    //searchBar.backgroundColor = [UIColor lightGrayColor];
    searchBar.placeholder = @"请输入商品名、品类或商圈...";
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    //搜索按钮
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ButtonSize, ButtonSize)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2,rightItem1];
}
#pragma mark搜索按钮
- (void)searchAction{
    
    ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"该功能正在完善中...."];
  
    [alertView addBtnTitle:@"好的" action:^{
     
    }];
    [alertView showAlertWithSender:self];

    
}

// 搜索栏下方的关键词栏
-(void)keyWordSearch
{
    //创建 UIScrollView 视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0*theWidth, 68, theWidth, 0.27*theWidth)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    // 设置UIScrollView 内容大小
    scrollView.contentSize = CGSizeMake(2*theWidth, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    // 在UIScrollView视图 上添加UIPageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.5*theWidth, 68+0*theWidth, 0.2*theWidth, 0.04*theWidth)];
    pageControl.numberOfPages = 2;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:pageControl];
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0.02*theWidth, -0.3*scrollView.frame.size.height, 2*theWidth, 0.0005*theWidth)];
    linView.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:linView];
    UIView *linView1 = [[UIView alloc] initWithFrame:CGRectMake(0.02*theWidth, 0,0.98*theWidth, 0.001*theWidth)];
    linView1.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:linView1];
    NSArray *array = @[@[@"蛋糕",@"美发",@"鼓浪屿",@"旅游",@"客栈",@"曾厝垵",],@[@"自助餐",@"方特",@"美食",@"梦幻",@"",@"",]];
    for (int j = 0; j < 2; j ++) {
        for (int i = 0; i < 6; i ++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((i*0.25*theWidth)+0.025*theWidth, (j*0.35-0.25)*scrollView.frame.size.height, 0.2*theWidth, 0.05*theWidth)];
            NSArray *tempArray = array[j];
            lable.text =tempArray[i];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:13];
            [scrollView addSubview:lable];
        }
    }
    
    UILabel *lable = [[UILabel alloc] initWithFrame: CGRectMake(0.03*theWidth, 68 +0.28*theWidth, 0.25*theWidth, 0.07*theWidth)];
    lable.font = [UIFont systemFontOfSize:16];
    lable.text = @"搜索历史";
    [self.view addSubview:lable];
}

#pragma mark UIScrollView 委托事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int index =  scrollView.contentOffset.x/0.96*theWidth;
    pageControl.currentPage = index;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
#pragma mark Items 按钮事件
//返回按钮事件
-(void)backButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
