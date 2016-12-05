//
//  CollectViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CollectViewController.h"
#import "UserModel.h"
#import "CellStyleIMG.h"
#import "Foodmodel.h"
#import "FoodData.h"
#import "StoresViewController.h"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UserModel    *_userModel;
    UITableView  *_myTableView;
    NSArray      *_tempKeysArr;
    NSDictionary *recordeDic ;
}

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏列表";
    
    // Do any additional setup after loading the view.
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel = [[UserModel alloc]init];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];

    
//    self.navigationItem.titleView =  [self addSegmentCtr];
    recordeDic = [self  readFileDetail];
    
    if (recordeDic.count == 0) {
        [self showLoadingView:@"您当前还没有收藏过商品哦"];
    }else
    {
        _tempKeysArr =  [[self readFileDetail] allKeys];
        [self addTableView];
    }

    
    
    
}
#pragma mark 添加表视图 展现待支付
- (void)addTableView{
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = theWidth*0.263;
//    _myTableView.separatorColor = [UIColor grayColor];
//    UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theWidth, 50)];
//    allLab.text = @"已显示全部";
//    allLab.textAlignment = NSTextAlignmentCenter;
//    allLab.font = [UIFont systemFontOfSize:15.0];
//    allLab.textColor = [UIColor grayColor];
//    _myTableView.tableFooterView = allLab;
    [self.view addSubview:_myTableView];
    
    
}

#pragma mark 委托方法  数据源
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    
    return [self readFileDetail].count;
    
}
// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return  0.01;
}
// 组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.15*theWidth;
}
// 组尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 0.15*theWidth)];
    view.backgroundColor = [UIColor whiteColor];
        UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(0.4*theWidth, 0.05*theWidth, theWidth*0.2, 0.05*theWidth)];
        allLab.text = @"已显示全部";
        allLab.textAlignment = NSTextAlignmentCenter;
        allLab.font = [UIFont systemFontOfSize:15.0];
        allLab.textColor = [UIColor grayColor];
    [view addSubview:allLab];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    static NSString *indentifier = @"myCell";
    CellStyleIMG *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[CellStyleIMG alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];

    }
    NSLog(@"[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row] = %@",[[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row]]);
    NSLog(@"self readFileDetail = %@",[self readFileDetail]);
    NSLog(@"indexPath.row = %ld",indexPath.row);
    cell.theImageView.image = [UIImage imageNamed:[[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row]][3]];
    cell.theGrupImageView.image = [UIImage imageNamed:@"commonIcon_group"];
    cell.theLabel.text =[[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row]][0];
    cell.theStartImageView1.image = [UIImage imageNamed:@"star_all"];
    cell.theStartImageView2.image = [UIImage imageNamed:@"star_all"];
    cell.theStartImageView3.image = [UIImage imageNamed:@"star_all"];
    cell.theStartImageView4.image = [UIImage imageNamed:@"star_all"];
    cell.theStartImageView5.image = [UIImage imageNamed:@"star_half"];
    //        cell.detailLab1.text = [NSString stringWithFormat:@"%ld人评价",foodModel.pjNum ];
    cell.datailLab2.text = [[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row]][1];
    cell.datailLab3.text = [[self readFileDetail] objectForKey: _tempKeysArr[indexPath.row]][2];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSString *goodName = [[self readFileDetail] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]][0] ;
    
     NSLog(@"goodName= %@",goodName);
      for (Foodmodel *fModel in [[[FoodData alloc]init] selectData]) {
        if ([fModel.foodName isEqualToString:goodName]) {
            StoresViewController  *storeCtr = [[StoresViewController alloc]init];
            storeCtr.model = fModel;
            [self.navigationController pushViewController:storeCtr animated:YES];
            break;
          }
       }
  
}

#pragma mark 添加分段控制器
- (UISegmentedControl *)addSegmentCtr{
    
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc]initWithItems:@[@"商品",@"商家"]];
    //设置大小
    segmentCtr.frame = CGRectMake(0, 0, theWidth*0.33, 22);
    segmentCtr.selectedSegmentIndex = 0;
    
    //    a、普通状态
    NSDictionary *attrsNormal = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[UIColor orangeColor]};
    [segmentCtr setTitleTextAttributes:attrsNormal forState:UIControlStateNormal];
    
    //    b、选中状态
    NSDictionary *attrsSelect = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [segmentCtr setTitleTextAttributes:attrsSelect forState:UIControlStateSelected];
    
    [segmentCtr addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    segmentCtr.tintColor = [UIColor orangeColor];
    segmentCtr.backgroundColor = [UIColor whiteColor];
    
    
    return segmentCtr;

}
#pragma mark 选择分段控件的事件
- (void)segmentAction:(UISegmentedControl *)segment{
    
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            [self showLoadingView:@"您当前还没有收藏过商品哦"];
        }
            break;
        case 1:
        {
            [self showLoadingView:@"您当前还没有收藏过商家哦"];
        }
            break;
        default:
            break;
    }
}

#pragma mark 展现加载界面
- (void)showLoadingView:(NSString *)remarkStr{
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    
    loadingView.remarkLabelStr = remarkStr;
    
    [self.view addSubview:loadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载文件
-(NSDictionary *)readFileDetail
{
     NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@收藏.txt",_userModel.userPhone];
     NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
     return tempDic;
}

#pragma mark 视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    _tempKeysArr =  [[self readFileDetail] allKeys];
    [_myTableView reloadData];
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
