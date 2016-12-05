//
//  HadPayViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "HadPayViewController.h"
#import "CinemaDetailViewController.h"
#import "StoresViewController.h"
#import "CinemaData.h"
#import "FoodData.h"

@interface HadPayViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl  *_segmentCtr;
    UIScrollView        *_myScrollView;
    UITableView         *_myTableView;
    NSArray             *_tempKeysArr;
    NSIndexPath         *_indexPress;  //点击位置

}
@end

@implementation HadPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"已付款订单";
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:[self addSegmentCtr:_selectIndex]];
    [self addScrollView];
    
    if ([self readWaitPayFile].count == 0) {
        
        LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
        loadingView.remarkLabelStr = @"您还没有已付款订单哦";
        [_myScrollView addSubview:loadingView];
        
    }
    else{
        _tempKeysArr =  [[self readWaitPayFile] allKeys];
        [self addTableView];
    }
    
    
    
}
#pragma mark 添加scrollView
- (void)addScrollView{
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, theWidth, theHeight-64)];
    _myScrollView.contentSize = CGSizeMake(theWidth*4, theHeight-64);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    [_myScrollView setContentOffset:CGPointMake(_selectIndex*theWidth, 0) animated:YES];
    _myScrollView.showsHorizontalScrollIndicator = NO;
    
    [_myScrollView addSubview:[self showLoadingView:@"您还没有已付款订单哦" andOffset:CGRectMake(0,0,theWidth,theHeight-64)]];
    
    [_myScrollView addSubview:[self showLoadingView:@"您还没有待评价订单哦" andOffset:CGRectMake(theWidth,0,theWidth,theHeight-64)]];

    
    [_myScrollView addSubview:[self showLoadingView:@"您还没有退款单哦" andOffset:CGRectMake(theWidth*2,0,theWidth,theHeight-64)]];

    
    [_myScrollView addSubview:[self showLoadingView:@"您还没有物流单哦" andOffset:CGRectMake(theWidth*3,0,theWidth,theHeight-64)]];

   
 
    [self.view addSubview:_myScrollView];
    
}
#pragma mark myScorllView 委托方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
{
    _segmentCtr.selectedSegmentIndex  = scrollView.contentOffset.x/theWidth;
}

#pragma mark 添加分段控制器
- (UISegmentedControl *)addSegmentCtr:(NSInteger)selectNumb{
    
    _segmentCtr = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"待评价",@"退款单",@"物流单"]];
    //设置大小
    _segmentCtr.frame = CGRectMake(0, 0, theWidth, 30);
    _segmentCtr.selectedSegmentIndex = selectNumb;
    //    a、普通状态
    NSDictionary *attrsNormal = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[UIColor grayColor]};
    [_segmentCtr setTitleTextAttributes:attrsNormal forState:UIControlStateNormal];
    
    //    b、选中状态
    NSDictionary *attrsSelect = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [_segmentCtr setTitleTextAttributes:attrsSelect forState:UIControlStateSelected];
    
    [_segmentCtr addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    _segmentCtr.tintColor = [UIColor orangeColor];
//    [segmentCtr setBackgroundImage:[UIImage imageNamed:@"load_tip2"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    _segmentCtr.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];
//    segmentCtr.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    return _segmentCtr;
    
}
#pragma mark 选择分段控件的事件
- (void)segmentAction:(UISegmentedControl *)segment{
    
    [_myScrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex*theWidth, 0) animated:YES];
    
}
#pragma mark 展现加载界面
- (UIView *)showLoadingView:(NSString *)remarkStr andOffset:(CGRect)frame{
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    loadingView.frame = frame;
    loadingView.remarkLabelStr = remarkStr;
    
    return loadingView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 添加表视图 展现待支付
- (void)addTableView{
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 120;
    _myTableView.showsHorizontalScrollIndicator = NO;
    //添加长按删除手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPressGest.minimumPressDuration = 0.5;
    [_myTableView addGestureRecognizer:longPressGest];
    _myTableView.separatorColor = [UIColor grayColor];
    UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theWidth, 50)];
    allLab.text = @"已显示全部";
    allLab.textAlignment = NSTextAlignmentCenter;
    allLab.font = [UIFont systemFontOfSize:15.0];
    allLab.textColor = [UIColor grayColor];
    _myTableView.tableFooterView = allLab;
    [_myScrollView addSubview:_myTableView];
    
    
}
#pragma mark长按单元格删除
- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGest{
    
    if (longPressGest.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [longPressGest locationInView:_myTableView];
        _indexPress = [_myTableView indexPathForRowAtPoint:point];
        ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"确认删除该充值记录吗"];
        [alertView addBtnTitle:@"取消" action:^{
            
        }];
        [alertView addBtnTitle:@"确定" action:^{
  
            [self deleteHadPay];
            [_myTableView reloadData];

        }];
        [alertView showAlertWithSender:self];
    }
    
}
/** 将已选商品记录 从已付款中删除*/
- (void)deleteHadPay{
    
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@已付款.txt",_userModel.userPhone];
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 在最后添加数据
    [recordDic removeObjectForKey:[_tempKeysArr objectAtIndex:_indexPress.row]];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];
}
#pragma mark 委托方法  数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    
    return [self readWaitPayFile].count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    static NSString *indentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.backgroundColor = RGB(246,246,246);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, theHeight, _myTableView.rowHeight)];
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, theWidth/4,theWidth/4)];
        leftImageView.image = [UIImage imageNamed:[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"图片名称"]];
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25, 20, theWidth/3-20, 15)];
        nameLab.numberOfLines = 0;
        nameLab.text = [[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"商品名"];
        UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25, 25+theWidth/8, theWidth/3, theWidth/16)];
        priceLab.textColor = [UIColor redColor];
        priceLab.text = [NSString stringWithFormat:@"总价:%@",[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"总价"]];
        
        UILabel *numbLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25+theWidth/3, 25+theWidth/8, theWidth/3, theWidth/16)];
        numbLab.text = [NSString stringWithFormat:@"数量: %@ 张",[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"数量"]];
        UILabel *goLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*3/5, 15, theWidth*2/5, 20)];
        goLab.font = [UIFont systemFontOfSize:14.0];
        goLab.text = [NSString stringWithFormat:@"订单号:%@",[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"已经付款订单号"]];

        goLab.textColor = [ UIColor grayColor];
        [view addSubview:goLab];
        [view addSubview:leftImageView];
        [view addSubview:nameLab];
        [view addSubview:priceLab];
        [view addSubview:numbLab];
        [cell.contentView addSubview:view];
        
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *goodName = [[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"商品名"];
    NSString *imageName = [[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"图片名称"] ;
    for (Foodmodel *fModel in [[[FoodData alloc]init] selectData]) {
        if ([fModel.foodName isEqualToString:goodName]) {
            StoresViewController  *storeCtr = [[StoresViewController alloc]init];
            storeCtr.model = fModel;
            [self.navigationController pushViewController:storeCtr animated:YES];
            break;
        }
    }
    for (CinemaModel *cinamaModel in [[[CinemaData alloc]init] selectData]) {
        if ([cinamaModel.cinemaImageName isEqualToString:imageName]) {
            CinemaDetailViewController *cinemaCtr = [[CinemaDetailViewController alloc]init];
            cinemaCtr.cinemaModel = cinamaModel;
            [self.navigationController pushViewController:cinemaCtr animated:YES];
            break;
        }
    }
}

#pragma mark 读取已付款的文件
- (NSMutableDictionary *)readWaitPayFile{
    
    /**读取已付款*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@已付款.txt",_userModel.userPhone];
    
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    
    return recordDic;
    
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
