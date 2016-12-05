//
//  MyBalanceViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MyBalanceViewController.h"
#import "RechargeViewController.h"

@interface MyBalanceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView    *_myTableView;
    UILabel        *_moneyLab;
    NSMutableArray *_recordArr;  //充值记录的数据
    NSIndexPath    *_indexPress;  //点击位置
}
@end

@implementation MyBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拉手余额";
    [self setEdgesForExtendedLayout: UIRectEdgeNone];
    self.view.backgroundColor =  [UIColor whiteColor];//[UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];
    
    // 充值按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"充值" style:UIBarButtonItemStylePlain target:self action:@selector(rechargeBtn:)];
    
    [self addMyTableView];
    
}
#pragma  mark 导航栏充值按钮
- (void)rechargeBtn:(UIBarButtonItem *)rightBtn{
    
    RechargeViewController *rechargeCtr = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:rechargeCtr animated:YES];
}
#pragma mark tableView 表视图加载
- (void)addMyTableView{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource =self;
    _myTableView.showsVerticalScrollIndicator = NO;
    /** 加载动画 */
    _myTableView.tableFooterView = self.recordArr.count ? NO :[self loadingView:NO] ;
    
    //添加长按删除手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPressGest.minimumPressDuration = 0.5;
    [_myTableView addGestureRecognizer:longPressGest];
    [self.view addSubview:_myTableView];
}

#pragma mark tableview 数据协议和委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    
    return 2+self.recordArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    if (indexPath.section == 0) {
        
        UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 80, 20)];
        leftLab.textColor = [UIColor grayColor];
        leftLab.tag = 122222;
        leftLab.text = @"拉手余额";
        leftLab.font = [UIFont boldSystemFontOfSize:16.0];
        _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(theWidth/4, 30, theWidth/2, 50)];
        _moneyLab.textColor = [UIColor orangeColor];
        _moneyLab.textAlignment = NSTextAlignmentCenter;
        _moneyLab.font = [UIFont boldSystemFontOfSize:22.0];
        _moneyLab.text = [NSString stringWithFormat:@"💰%.2f",_userModel.userMoney];
        [cell.contentView addSubview:leftLab];
        [cell.contentView addSubview:_moneyLab];
    }
     else if(indexPath.section == 1) {
   
        cell.textLabel.text = @"充值记录";
        cell.textLabel.textColor = [UIColor grayColor];
    }
    else{
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            if (self.recordArr.count != 0) {
                
                NSLog(@"indexPath.row-2 = %ld",indexPath.section-2);
                cell.textLabel.text = [self.recordArr objectAtIndex:indexPath.section-2];
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.font = [UIFont systemFontOfSize:15.0];
             
            }
        
        
    }
    return cell;
    
}
#pragma mark长按单元格删除
- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGest{
    
    if (longPressGest.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [longPressGest locationInView:_myTableView];
        _indexPress = [_myTableView indexPathForRowAtPoint:point];
        
        if (_indexPress.section >= 2) {
            
            ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"提示" message:@"确认删除该充值记录吗"];
            [alertView addBtnTitle:@"取消" action:^{
                
            }];
            [alertView addBtnTitle:@"确定" action:^{
                
//                [self.recordArr removeObjectAtIndex:_indexPress.section-2];
                [self deleteRecoreRecharge];
                [_myTableView reloadData];
//                [_myTableView deleteRowsAtIndexPaths:@[_indexPress] withRowAnimation:UITableViewRowAnimationLeft];
                
            }];
            [alertView showAlertWithSender:self];
        }
    }
    
}
#pragma mark及时删除数据库记录
- (void)deleteRecoreRecharge{
    /** 读取文件*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",_userModel.userPhone];
    
    NSMutableArray *recordArr = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
    
    [recordArr removeObjectAtIndex:_indexPress.section-2];
    
    [recordArr writeToFile:filePath atomically:NO];
}
#pragma mark 表视图单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
//    if (indexPath.section == 0 || indexPath.section == 1) {
//        
//        tableView.allowsSelection = NO;
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    if (indexPath.section == 0) {
        return 80;
    }
    if (self.recordArr.count != 0) {
        if (indexPath.section >= 2) {
            NSDictionary *dicAttri = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0]};
            CGSize size =[[self.recordArr objectAtIndex:indexPath.section - 2] boundingRectWithSize:CGSizeMake(theWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicAttri context:nil].size;
            return size.height+15;
        }
        
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;{
    
    return 3;
    
}
#pragma mark 加载动画
- (UIView *)loadingView:(BOOL)haveData{
    
    LoadingView *loadingView = [[[NSBundle mainBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    loadingView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];
    loadingView.frame = CGRectMake(0, 0, theWidth, theHeight);
    [loadingView.goBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [loadingView.goBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    loadingView.haveData = haveData;
    loadingView.remarkLabelStr = @"您还没有充值记录";
    return loadingView;
}

#pragma mark 充值
- (void)rechargeAction{
    
    RechargeViewController *rechargeCtr = [[RechargeViewController alloc]init];
    rechargeCtr.userModel = _userModel;
    [self.navigationController pushViewController:rechargeCtr animated:YES];

}

- (void)selcetModel{
    
    for (UserModel *model in [[[UserData alloc]init] selectData]) {
        if ([model.userPhone isEqualToString:_userModel.userPhone]) {
            
            _userModel = model;
            NSLog(@"model = %@",model);
        }
        
    }
}
#pragma mark 视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    [self selcetModel];
    [_myTableView reloadData];
    _myTableView.tableFooterView = self.recordArr.count ? NO :[self loadingView:NO] ;
    _moneyLab.text = [NSString stringWithFormat:@"💰%.2f",_userModel.userMoney];
}
#pragma mark 读取充值记录的数据库
- (NSMutableArray *)recordArr{
    
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",_userModel.userPhone];
    _recordArr = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
    return _recordArr;
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
