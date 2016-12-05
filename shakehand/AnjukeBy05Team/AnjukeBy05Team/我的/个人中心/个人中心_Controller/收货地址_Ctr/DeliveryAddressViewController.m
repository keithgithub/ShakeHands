//
//  DeliveryAddressViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "DeliveryAddressViewController.h"
#import "AddUserAddressViewController.h"
#import "ChangeUserAddressViewController.h"

@interface DeliveryAddressViewController ()
{
    NSArray *_listArry;//用于懒加载 plist数据的数组
}
@property (weak, nonatomic) IBOutlet UITableView *theShowUserAddressTabView;


@end

@implementation DeliveryAddressViewController

//懒加载 固定的数据
- (NSArray *)listArry
{
    if (_listArry == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"showUserAddress" ofType:@"plist"];
        _listArry = [NSArray arrayWithContentsOfFile:path];
    }
    return _listArry;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = @"我的收货地址";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    //  隐藏返回按钮文字，只留图标 （此效果作用于：下一级页面）
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
//    _theShowUserAddressTabView.scrollEnabled = NO; //设置tableview 不能滚动
    

    
    // 创建系统自带的导航栏按钮Item
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDeliveryAddressAction:)];
    
    rightBarBtn.tintColor = [UIColor orangeColor];//设置按钮颜色
    self.navigationItem.rightBarButtonItem = rightBarBtn;//添加到导航栏右按钮
    

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


#pragma mark UITableViewDataSource 数据源方法

//  一、section 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

//  二、cell 的 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 1、先通过组数获取字典
    NSDictionary *sectionDic = [self.listArry objectAtIndex:section];
    
    // 2、通过datas这个Key 来获取cell的行数（数组）
    NSArray *cellArry = [sectionDic objectForKey:@"datas"];
    
    return cellArry.count;
}


//  三、创建单元格的实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (tabCell == nil) {
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
//    // 1、先通过组数获取字典
//    NSDictionary *sectionDic = [self.listArry objectAtIndex:indexPath.section];
//    
//    // 2、通过datas这个Key 来获取cell的行数（数组）
//    NSArray *cellArry = [sectionDic objectForKey:@"datas"];
//    
//    // 3、通过cell行数（row）获取cell的字典（cell的数据）
//    NSDictionary *cellDic = [cellArry objectAtIndex:indexPath.row];
//    
//    // 4、设置单元格 从plist文件中 获取的cell的字典 设置textLabel标签的文本
////    tabCell.textLabel.text = [cellDic objectForKey:@"title"];
    
    // 添加右边附件 小箭头
    tabCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 自定义一个View 用于添加以下 四个显示 用户收货地址信息的Label标签
//    UIView *userDeliveryAddressView = [[UIView alloc] initWithFrame:CGRectMake(5, 20, theWidth*0.85, 226)];
    // 收货人姓名Label
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, theWidth*0.8, 20)];
    userNameLabel.text = @"收货人姓名";
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textColor = [UIColor grayColor];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    
    userNameLabel.tag = 6001;
    
    //  收货人联系电话
    UILabel *userTelNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, theWidth*0.8, 20)];
    userTelNoLabel.text = @"联系电话";
    userTelNoLabel.font = [UIFont systemFontOfSize:13];
    userTelNoLabel.textColor = [UIColor grayColor];
    userTelNoLabel.textAlignment = NSTextAlignmentLeft;
    
    userTelNoLabel.tag = 6002;
    
    //  收货人收货地址
    UILabel *userDetailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 85, theWidth*0.8, 20)];
    userDetailAddressLabel.text = @"收货地址";
    userDetailAddressLabel.font = [UIFont systemFontOfSize:13];
    userDetailAddressLabel.textColor = [UIColor grayColor];
    userDetailAddressLabel.textAlignment = NSTextAlignmentLeft;
    
    userDetailAddressLabel.tag = 6003;
    
    //  收货人邮政编码
    UILabel *userZipCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 110, theWidth*0.8, 20)];
    userZipCodeLabel.text = @"邮政编码";
    userZipCodeLabel.font = [UIFont systemFontOfSize:13];
    userZipCodeLabel.textColor = [UIColor grayColor];
    userZipCodeLabel.textAlignment = NSTextAlignmentLeft;
    
    userZipCodeLabel.tag = 6004;
    
    //  在cell上添加自定义View
//    [tabCell addSubview: userDeliveryAddressView];
    
    // 将label 添加到 cell上
    [tabCell addSubview: userNameLabel];
    [tabCell addSubview: userTelNoLabel];
    [tabCell addSubview: userDetailAddressLabel];
    [tabCell addSubview: userZipCodeLabel];

    
    return tabCell;
    
}

#pragma mark UITableViewDelegate 委托方法

// 四、设置section 头部
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//{
//    //  1、 先通过组数获取字典
//    NSDictionary *sectionDic = [self.listArry objectAtIndex:section];
//    
//    //  2、创建一个label 用于解决显示组的头部显示效果
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, theWidth*0.24, 30)];
//    
//    //  3、通过设置label属性 改变文字显示效果
//    //通过上面数据源获取的字典section的数据 设置给label的text属性
//    label.text = [sectionDic objectForKey:@"title"];
//    label.font = [UIFont systemFontOfSize:18];//设置section标题字体大小
//    label.textColor = [UIColor grayColor];//设置section标题字体颜色
//    
//    //  4、创建一个UIView 位置和大小 设置自适应
//    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
//    
//    //  5、将label添加到view上
//    [view addSubview:label];
//    
//    //  6、返回创建的View 此方法可以解决使用字符串返回对象 字符串显示在section头部顶格的问题，改善视觉体验
//    return view;
//    
//    
//}



//  设置cell row 的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return theHeight*0.3;
    
}


// 设置section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return theHeight*0.02;
    
}

// 设置section的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 1;
    
}

#pragma mark 选中单元格的实现方法
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中时触发阴影效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sectionNo = indexPath.section;//组的索引下标
    NSInteger cellNo = indexPath.row;//行的索引下标
    NSLog(@"sectionNO = %ld ,cellNO= %ld",sectionNo,cellNo);
    
    // 选中对应cell：分享设置cell、意见反馈cell、关于cell的推出页面
    if (cellNo == 0) {
        
        //   选中 cell 点击后推出的页面
        
        //  1、创建 分享设置 视图控制器
        ChangeUserAddressViewController *changeUserAddressViewCtr = [[ChangeUserAddressViewController alloc] init];
//        changeUserAddressViewCtr.title = @"修改收货地址";//设置 跳转页面后的导航栏 标题
        
        //  2、通过导航栏push 关于 页面
        [self.navigationController pushViewController:changeUserAddressViewCtr animated:YES];
        
        [self showMessage:@"修改收货地址"];
        
    }
    
}

//
- (void)addDeliveryAddressAction:(id)sender
{

    [self showMessage:@"增加收货地址"];
    
    AddUserAddressViewController *addUserAddressViewCtr = [[AddUserAddressViewController alloc] init];
    [self.navigationController pushViewController:addUserAddressViewCtr animated:YES];

}


// 底部提示
- (void)showMessage:(NSString *)message
{
    //UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 13.0f;
    showview.layer.masksToBounds = YES;
    //[window addSubview:showview];
    [self.view addSubview:showview];
    
    UILabel *label = [[UILabel alloc] init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize: CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    //设置底部提示视图位置和大小
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.83, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];

}

@end
