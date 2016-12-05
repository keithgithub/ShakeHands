//
//  SurroundViewController.m
//  项目二——周边
//
//  Created by etcxm on 16/6/7.
//  Copyright © 2016年 CellStyleDemo. All rights reserved.
//

#import "SurroundViewController.h"
#import "StoresViewController.h"
#import "GoodsViewController.h"
#import "SearchViewController.h"
#import "CellStyleIMG.h"
#import "CellStyleNoIMG.h"
#import "StrikeThroughLabel.h"
#import "YGSpreadView.h"
#import "FoodData.h"
#import "Foodmodel.h"

#define SceHight 12.0
#define ButtonSize 36
#define ToolViewHight 33
#define ToolViewTag 2001
#define TheScreenWidth [UIScreen mainScreen].bounds.size.width
#define theScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SurroundViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_foodsArray;//数据库原始数据
   
}

@end

@implementation SurroundViewController

// 懒加载 数据库
-(NSMutableArray *)foodsArray
{
    if (_foodsArray == nil) {
        _foodsArray = [NSMutableArray array];
        FoodData *foodData = [[FoodData alloc] init];
        _foodsArray = [foodData selectData];
        
    }
    return _foodsArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"周边";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 修改分栏背景颜色
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏下边，功能按钮视图
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TheScreenWidth, ToolViewHight)];
    toolView.tag = ToolViewTag;
    [self.view addSubview:toolView];
    //导航栏添加“定位”、“搜索” Items
    [self navigationItemAddTitems];
    //在功能视图中添加功能按钮
    [self toolViewAddButton];
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ToolViewHight, theWidth, theHeight-ToolViewHight-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(30, 200, 250, 50)
//                                                                  numberOfStar:5];
}
 //在功能视图中添加功能按钮
-(void)toolViewAddButton
{
    // button_全部分类
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setWithbutton:button1 andframe:CGRectMake(0, 0, TheScreenWidth/4, ToolViewHight) andTitle:@"全部分类" forState:UIControlStateNormal andFont:[UIFont systemFontOfSize:ToolViewHight/3.0] andTitleColor:[UIColor blackColor] forState:UIControlStateNormal andAddTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    // button_全城
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setWithbutton:button2 andframe:CGRectMake(TheScreenWidth/4, 0, TheScreenWidth/4, ToolViewHight) andTitle:@"全城" forState:UIControlStateNormal andFont:[UIFont systemFontOfSize:ToolViewHight/3.0] andTitleColor:[UIColor blackColor] forState:UIControlStateNormal andAddTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    // button_距离最近
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setWithbutton:button3 andframe:CGRectMake(TheScreenWidth/4*2, 0, TheScreenWidth/4, ToolViewHight) andTitle:@"距离最近" forState:UIControlStateNormal andFont:[UIFont systemFontOfSize:ToolViewHight/3.0] andTitleColor:[UIColor blackColor] forState:UIControlStateNormal andAddTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
    // button_筛选
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setWithbutton:button4 andframe:CGRectMake(TheScreenWidth/4*3, 0, TheScreenWidth/4, ToolViewHight) andTitle:@"筛选" forState:UIControlStateNormal andFont:[UIFont systemFontOfSize:ToolViewHight/3.0] andTitleColor:[UIColor blackColor] forState:UIControlStateNormal andAddTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
    
}

// 功能按钮
-(void)setWithbutton:(UIButton *)button  andframe:(CGRect )CGRect andTitle:(NSString *)title  forState:(UIControlState )state andFont:(UIFont *)font andTitleColor:(UIColor *)color forState:(UIControlState)CtrState  andAddTarget:(nullable id)tager action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
{
    button.frame = CGRect;
    [button setTitle:title forState:state];
    button.titleLabel.font = font;
    [button setTitleColor:color forState:CtrState];
    [button addTarget:tager action:action forControlEvents:controlEvents];
    UIView *toolVIew = [self.view viewWithTag:ToolViewTag];
    [toolVIew addSubview:button];
    
}

//导航栏添加rightItem
-(void)navigationItemAddTitems
{
    // item - “定位”
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setImage:[UIImage imageNamed:@"detail_address"] forState:UIControlStateNormal];
    addressBtn.frame = CGRectMake(0, 0,ButtonSize , ButtonSize);
    [addressBtn addTarget:self action:@selector(addressItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addressItem = [[UIBarButtonItem alloc] initWithCustomView:addressBtn];
    // item - “搜索”
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"icon_nav_search"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0,ButtonSize , ButtonSize);
    [searchBtn addTarget:self action:@selector(searchItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItems = @[searchItem,addressItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 表视图 数据源的事件
// 表视图组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{

    return self.foodsArray.count;
   
}
// 表视图行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}

// 创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier1 = @"myCell";
    static NSString *identifier2 = @"cell";
     Foodmodel *foodModel = [_foodsArray objectAtIndex:indexPath.section];//数据库原始数据转换为model类型
    if (indexPath.row == 0) {
        CellStyleIMG *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell =  [[CellStyleIMG alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        cell.theImageView.image = [UIImage imageNamed:foodModel.imageName];
        cell.theGrupImageView.image = [UIImage imageNamed:@"commonIcon_group"];
        cell.theLabel.text =foodModel.foodName;
        cell.theStartImageView1.image = [UIImage imageNamed:@"star_all"];
        cell.theStartImageView2.image = [UIImage imageNamed:@"star_all"];
        cell.theStartImageView3.image = [UIImage imageNamed:@"star_all"];
        cell.theStartImageView4.image = [UIImage imageNamed:@"star_all"];
        cell.theStartImageView5.image = [UIImage imageNamed:@"star_half"];
        cell.detailLab1.text = [NSString stringWithFormat:@"%ld人评价",foodModel.pjNum ];
        cell.datailLab2.text = foodModel.style;
        cell.datailLab3.text = foodModel.address;
        //cell.theImageView.image =  [UIImage imageNamed:@"detail_address"];
//        cell.theGrupImageView.image = [UIImage imageNamed:@"commonIcon_group"];
//        cell.theLabel.text =@"从前有家烘培店";
//        cell.theStartImageView1.image = [UIImage imageNamed:@"star_all"];
//        cell.theStartImageView2.image = [UIImage imageNamed:@"star_all"];
//        cell.theStartImageView3.image = [UIImage imageNamed:@"star_all"];
//        cell.theStartImageView4.image = [UIImage imageNamed:@"star_all"];
//        cell.theStartImageView5.image = [UIImage imageNamed:@"star_half"];
//        cell.detailLab1.text = @"3人评价";
//        cell.datailLab2.text = @"汽车服务";
//        cell.datailLab3.text = @"软件园二期  445m";
        // 点击单元格 选中的单元格不变灰
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        CellStyleNoIMG *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell =  [[CellStyleNoIMG alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        cell.theLabel.text = [NSString stringWithFormat:@"￥%ld",foodModel.price];
        cell.detailLab1.text = [NSString stringWithFormat:@"￥%ld",foodModel.price*2];;
        cell.datailLab2.text = foodModel.pricePurchase;
        cell.datailLab3.text = [NSString stringWithFormat:@"已售%ld",foodModel.sold];
//        cell.theLabel.text = @"￥149";
//        cell.detailLab1.text = @"￥299";
//        cell.datailLab2.text = @"洗车10次，厦门地区通用，免预约";
//        cell.datailLab3.text = @"已售0";
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
  
    }
   
}

// 组足部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return SceHight;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return  TheScreenWidth*0.263;
    }else
    {
       return  TheScreenWidth*0.16;
    }
}

// 点击单元格事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            
            StoresViewController *storeViewCtr = [[StoresViewController alloc] init];
            storeViewCtr.hidesBottomBarWhenPushed = YES;
            storeViewCtr.model = [_foodsArray objectAtIndex:indexPath.section];// 向下一界面（StoresViewController）传值
            self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:storeViewCtr animated:YES];
        }else if(indexPath.row != 0)
        {
            GoodsViewController *goodsViewCtr = [[GoodsViewController alloc] init];
            goodsViewCtr.hidesBottomBarWhenPushed =YES;
            goodsViewCtr.model = [_foodsArray objectAtIndex:indexPath.section];// 向下一界面（GoodsViewController）传值
            goodsViewCtr.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:goodsViewCtr animated:YES];
        }
    }



#pragma mark 功能按钮事件
// 根据按钮选中状态改变TitleColor颜色
-(void)changeButtonColor:(UIButton *)button
{
    if (button.selected == NO) {
        button.selected = YES;
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }else
    {
        button.selected = NO;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
// button_全部分类 事件
-(void)button1Action:(UIButton *)button
{
    [self changeButtonColor:button];
}
// button_全城 事件
-(void)button2Action:(UIButton *)button
{
 [self changeButtonColor:button];
}
// button_距离最近 事件
-(void)button3Action:(UIButton *)button
{
[self changeButtonColor:button];
}
// button_筛选 事件
-(void)button4Action:(UIButton *)button
{
    [self changeButtonColor:button];
}

#pragma mark “定位”、“搜索” Items事件
// item - “定位”
-(void)addressItemAction:(UIBarButtonItem *)buttonItem
{
    
}

// item - “搜索”
-(void)searchItemAction:(UIBarButtonItem *)buttonItem
{
    SearchViewController *searchViewCtr = [[SearchViewController alloc] init];
    searchViewCtr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewCtr animated:YES];
    
    
    
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//
//- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
