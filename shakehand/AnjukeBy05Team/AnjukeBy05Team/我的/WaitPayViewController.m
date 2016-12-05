//
//  WaitPayViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WaitPayViewController.h"
#import "GoodsPayViewController.h"
#import "movieModel.h"
#import "Foodmodel.h"
#import "CinemaModel.h"
#import "FoodData.h"
#import "MovieData.h"
#import "CinemaData.h"

@interface WaitPayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *_myTableView;
    NSArray      *_tempKeysArr;
    NSIndexPath  *_indexPress;  //点击位置
}
@end

@implementation WaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"待付款订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(rightAction:)];
//   self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if ([self readWaitPayFile].count == 0) {
        
        LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
        [loadingView.goBtn addTarget:self action:@selector(goBtnAction) forControlEvents:UIControlEventTouchUpInside];
        loadingView.remarkLabelStr = @"您还没有待付款订单哦";
        [self.view addSubview:loadingView];
    }
    else{
         _tempKeysArr =  [[self readWaitPayFile] allKeys];
        [self addTableView];
    }
}
#pragma mark 显示随便逛逛
- (void)goBtnAction{
    
    [self.tabBarController setSelectedIndex:1];
}
#pragma mark 右上角导航栏按钮
- (void)rightAction:(UIBarButtonItem *)btn{
    
    static int i = 0;
    if ( i%2 == 0) {
        _myTableView.editing = YES;
    }
    else{
        _myTableView.editing = NO;
    }
    i++;

}
#pragma mark 添加表视图 展现待支付
- (void)addTableView{
    
  
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 120;
    _myTableView.separatorColor = [UIColor grayColor];
    //添加长按删除手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPressGest.minimumPressDuration = 0.5;
    [_myTableView addGestureRecognizer:longPressGest];
    UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theWidth, 50)];
    allLab.text = @"已显示全部";
    allLab.textAlignment = NSTextAlignmentCenter;
    allLab.font = [UIFont systemFontOfSize:15.0];
    allLab.textColor = [UIColor grayColor];
    _myTableView.tableFooterView = allLab;
    [self.view addSubview:_myTableView];
    
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
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, theHeight, _myTableView.rowHeight)];
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, theWidth/4,theWidth/4)];
        leftImageView.image = [UIImage imageNamed:[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"图片名称"]];
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25, 20, theWidth*1/3, 15)];
        nameLab.numberOfLines = 0;
        nameLab.text = [[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"商品名"];
        UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25, 25+theWidth/8, theWidth/3, theWidth/16)];
        priceLab.textColor = [UIColor redColor];
        priceLab.text = [NSString stringWithFormat:@"总价:%@",[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"总价"]];
        
        UILabel *numbLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4+25+theWidth/3, 25+theWidth/8, theWidth/3, theWidth/16)];
        numbLab.text = [NSString stringWithFormat:@"数量: %@ 张",[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"数量"]];
        UILabel *goLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth*3/4, 15, 100, 20)];
        goLab.text = @"立即付款";
        goLab.textColor = [ UIColor orangeColor];
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
    GoodsPayViewController *goodPayCtr = [[GoodsPayViewController alloc]init];
    for (Foodmodel *fModel in [[[FoodData alloc]init] selectData]) {
        if ([fModel.foodName isEqualToString:goodName]) {
            goodPayCtr.model = fModel;
            break;
        }
    }
    for (movieModel *mModel in [[[MovieData alloc]init] selectData]) {
        if ([mModel.movieName isEqualToString:goodName]) {
            goodPayCtr.mModel = mModel;
            break;
        }
    }
    for (CinemaModel *cinamaModel in [[[CinemaData alloc]init] selectData]) {
        if ([cinamaModel.cinemaImageName isEqualToString:imageName]) {
            goodPayCtr.cinemaModel = cinamaModel;
            break;
        }
    }
    goodPayCtr.numb = [[[[self readWaitPayFile] objectForKey:[_tempKeysArr objectAtIndex:indexPath.row]] objectForKey:@"数量"] integerValue];
    [self.navigationController pushViewController:goodPayCtr animated:YES];
    
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        //   1.  数据源数据 要删除
        NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@待支付.txt",_userModel.userPhone];
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
        // 删除数据
        [recordDic removeObjectForKey:[_tempKeysArr objectAtIndex:indexPath.row]];
        //写入文件
        [recordDic writeToFile:filePath atomically:NO];

        //   2.  表视图表格删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
    
     NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@待支付.txt",_userModel.userPhone];
     NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 删除数据
    [recordDic removeObjectForKey:[_tempKeysArr objectAtIndex:_indexPress.row]];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];
}
#pragma mark 读取未付款的文件
- (NSMutableDictionary *)readWaitPayFile{
    
    /**读取未付款*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@待支付.txt",_userModel.userPhone];
    
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    
    return recordDic;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
