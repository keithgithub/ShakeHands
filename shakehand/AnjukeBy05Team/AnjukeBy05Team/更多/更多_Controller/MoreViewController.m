//
//  MoreViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/6.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MoreViewController.h"
#import "SharingSetViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"


@interface MoreViewController ()
{
    NSArray *_listArry;//用于懒加载 plist数据的数组
    NSUInteger switchIndex;//开关标识
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;//XIB 拽一个TableView属性 用于通过tag值获取cell 点击清除缓存的事件实现更改内容

@end


@implementation MoreViewController



//懒加载 固定的数据
- (NSArray *)listArry
{
    if (_listArry == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"myMenu" ofType:@"plist"];
        _listArry = [NSArray arrayWithContentsOfFile:path];
    }
    return _listArry;
    
}

#warning 设置更多分栏的角标  未完成
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = @"更多页面";
        
        // 设置item的红色角标
        self.tabBarItem.badgeValue =@"5";
    }
    return self;
}

//  点击进入有角标提示的页面后 让其消失角标 设置值为空nil
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarItem.badgeValue = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置导航栏显示的标题
    self.title = @"更多";
    // 隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    //     设置导航栏颜色
    //    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    NSLog(@"self.listArry %@",self.listArry);
    
    // 从导航栏顶部开始计算位移
    // [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    //  设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    // push到下一级页面 隐藏分栏按钮
    MoreViewController *moreViewCtr = [[MoreViewController alloc] init];
    moreViewCtr.hidesBottomBarWhenPushed = YES;
    
}

//  当下级页面返回该页面时 更改导航栏颜色
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//更改导航栏颜色 橙色
    
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
    return self.listArry.count;
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
    
    // 1、先通过组数获取字典
    NSDictionary *sectionDic = [self.listArry objectAtIndex:indexPath.section];
    
    // 2、通过datas这个Key 来获取cell的行数（数组）
    NSArray *cellArry = [sectionDic objectForKey:@"datas"];
    
    // 3、通过cell行数（row）获取cell的字典（cell的数据）
    NSDictionary *cellDic = [cellArry objectAtIndex:indexPath.row];
    
    // 4、设置单元格 从plist文件中 获取的cell的字典 设置textLabel标签的文本
    tabCell.imageView.image = [UIImage imageNamed:[cellDic objectForKey:@"image"]];
    tabCell.textLabel.text = [cellDic objectForKey:@"title"];
    
    // 5、创建用于 添加到cell的控件或内容
    // ①创建右边开关
    UISwitch *dispImgSwitch = [[UISwitch alloc] init];
    UISwitch *msgRemindSwitch = [[UISwitch alloc] init];
    
    //    if ([cellArry containsObject:@"image"])
    //    {
    //        switchIndex = [cellArry indexOfObject : @"image"];
    //        NSLog(@"index = %ld",switchIndex);
    //    }else
    //    {
    //        NSLog(@"数组不包含%@",@"image");
    //    }
    
    //设置开关按钮的tag值 备用
    dispImgSwitch.tag = 5001;
    msgRemindSwitch.tag = 5002;
    
    //添加开关按钮的点击事件
    [dispImgSwitch addTarget:self action:@selector(dispImgSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [msgRemindSwitch addTarget:self action:@selector(msgRemindSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    // ②创建plistLabel（联系客服cell右边的客服号码） 显示在cell右边的text
    //注意设置 X轴的位置(=时间的宽度)和宽度(客服View-时间) 结合 客服时间 控件 的宽度
    UILabel *plistLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.47, 20)];
    //通过上面数据源获取的字典cell的数据 设置给plistLabel的text属性
    plistLabel.text = [cellDic objectForKey:@"labeltext"];
    //plistLabel里面的text   右对齐
    plistLabel.textAlignment = NSTextAlignmentRight;
    //plistLabel中text的字体颜色设置
    plistLabel.textColor = [UIColor grayColor];
    
    //  [plistLabel sizeToFit];//根据当前视图自适应label大小
    [plistLabel adjustsFontSizeToFitWidth];//根据label宽度自适应text大小
    
    // ③创建客服时间显示的标签：timeLabel 设置
    //  用于与plist中的电话号码存于plistLabel，然后添加到一个UIView上
    //  再添加到 联系客服的cell中作为左边的数据：客服时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, theWidth*0.27, 20)];
    timeLabel.text = @"(8:00-22:00)";
    timeLabel.textAlignment = NSTextAlignmentLeft;//timeLabel的text左对齐
    timeLabel.textColor = [UIColor grayColor];//timeLabel的text字体颜色
    
    [timeLabel sizeToFit];//根据当前视图自适应label大小
    [timeLabel adjustsFontSizeToFitWidth];//根据label宽度自适应text大小
    
    // 在对应cell上 添加控件和内容
    if (indexPath.section == 0 && indexPath.row == 0) {//仅在WiFi下显示图片 开关
        
        tabCell.accessoryView = dispImgSwitch;// accesoryView 属性 添加自定义dispImgSwitch开关控件
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {//消息提醒 开关
        
        tabCell.accessoryView = msgRemindSwitch;// accesoryView 属性 添加自定义msgRemindSwitch开关控件
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {// cell 右边的text (检查更新cell的内容)
        
        tabCell.accessoryView = plistLabel;// accesoryView 属性 自定义添加控件
        
    }else if ((indexPath.section == 0 && indexPath.row == 3)) {// cell 右边的text (清除缓存cell的内容)
        
        tabCell.accessoryView = plistLabel;// accesoryView 属性 自定义添加控件
        
        //设置 清除缓存 cell的tag
        if (indexPath.section == 0 && indexPath.row == 3) {
            tabCell.tag = 5003;// 设置 清除缓存cell的tag值
        }
        
    }else if ((indexPath.section == 1 && indexPath.row == 2)) {//联系客服 cell的内容
        
        //  创建一个UIView 根据联系客服cell的大小和客服号码的宽度，时间，设置位置和大小
        UIView *cusServiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, theWidth*0.73, 40)];//注意设置 X轴位置和View宽度
        
        //  将label添加到cusServiceView上
        [cusServiceView addSubview:plistLabel];
        [cusServiceView addSubview:timeLabel];
        //  视图大小适配
        [cusServiceView sizeThatFits:CGSizeMake(theWidth*0.73, theHeight*0.06)];
        
        //  accesoryView 属性 添加自定义控件
        tabCell.accessoryView = cusServiceView;
        
    }else{//右边小箭头
        //accessoryType 属性 设置cell右边的相关的系统自带控件 DisclosureIndicator 右箭头 导航下一级页面
        tabCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    //  设置去除表视图单元格选中时的状态，默认选中cell有阴影效果 设置选中无色None
    //  tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //  这样设置会使 选中时都没有显示效果，用委托方法中的deselectRowAtIndexPath:indexPath animated:YES 只在点击动作按下时有瞬间阴影效果
    
    return tabCell;
}

#pragma mark UITableViewDelegate 委托方法

// 四、设置section 头部
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    //  1、 先通过组数获取字典
    NSDictionary *sectionDic = [self.listArry objectAtIndex:section];
    
    //  2、创建一个label 用于解决显示组的头部显示效果
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, theWidth*0.24, 30)];
    
    //  3、通过设置label属性 改变文字显示效果
    //通过上面数据源获取的字典section的数据 设置给label的text属性
    label.text = [sectionDic objectForKey:@"title"];
    label.font = [UIFont systemFontOfSize:18];//设置section标题字体大小
    label.textColor = [UIColor grayColor];//设置section标题字体颜色
    
    //  4、创建一个UIView 位置和大小 设置自适应
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    //  5、将label添加到view上
    [view addSubview:label];
    
    //  6、返回创建的View 此方法可以解决使用字符串返回对象 字符串显示在section头部顶格的问题，改善视觉体验
    return view;
    
    
}

// 设置section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
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
    if (sectionNo == 0 && cellNo == 2) {
        
        //  分享设置 cell 点击后推出的页面
        
        //  1、创建 分享设置 视图控制器
        SharingSetViewController *shareViewCtr = [[SharingSetViewController alloc] init];
        shareViewCtr.title = @"分享设置title";//设置 跳转页面后的导航栏 标题
        
        //  2、通过导航栏push 关于 页面
        [self.navigationController pushViewController:shareViewCtr animated:YES];
        
        
    }else if (sectionNo == 1 && cellNo == 1) {
        
        //  意见反馈 cell 点击后推出的页面
        
        //  1、创建 意见反馈 视图控制器
        FeedbackViewController *feedBackViewCtr = [[FeedbackViewController alloc] init];
        feedBackViewCtr.title = @"意见反馈title";//设置 跳转页面后的导航栏 标题
        //  2、通过导航栏push 意见反馈 页面
        [self.navigationController pushViewController:feedBackViewCtr animated:YES];
        
    }else if (sectionNo == 2 && cellNo == 1) {
        
        //  关于 cell 点击后推出的页面
        
        //  1、创建 关于 视图控制器
        AboutViewController *aboutViewCtr = [[AboutViewController alloc] init];
        aboutViewCtr.title = @"关于title";//设置 跳转页面后的导航栏 标题
        
        //  2、通过导航栏push 关于 页面
        [self.navigationController pushViewController:aboutViewCtr animated:YES];
        
        
    }
    
    
    //  点击对应cell 跳出Alert提示框
    if (sectionNo == 0 && cellNo == 3) {// 清除缓存
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"清除缓存" message:@"是否清除缓存？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消清除缓存。");
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定清除缓存。");
            //  创建清除缓存的cell：clearTabViewCell
            UITableViewCell * clearTabViewCell = (UITableViewCell*)[_tabView viewWithTag:5003];
            
            // 创建清除缓存时用于接收修改后的数据（0KB缓存）的标签 Label
            UILabel *cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.21, 0, theWidth*0.27, 40)];
            
            cacheLabel.text = @"0KB";//标签内容
            cacheLabel.textAlignment = NSTextAlignmentRight;//cacheLabel右对齐
            cacheLabel.textColor = [UIColor grayColor];//字体颜色
            
            //  创建一个UIView
            UIView *clearCacheView = [[UIView alloc]initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.48, 40)];
            
            //  将cacheLabel添加到clearCacheView上
            //  这样添加实现更改label的内容，不能直接在cell上添加label,直接添加会使cell在点击清除时直接消失
            [clearCacheView addSubview:cacheLabel];
            
            //  accesoryView 属性 添加自定义控件
            clearTabViewCell.accessoryView = clearCacheView;
            
            NSLog(@"cellTag = %ld",(long)clearTabViewCell.tag);
            // 底部提示
            [self showMessage:@"缓存已清除"];
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
        
    }else if (sectionNo == 1 && cellNo == 0) {//  赏个好评
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"赏个好评" message:@"好评，鼓励一下！"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消好评。");
            // 底部提示
            [self showMessage:@"已取消好评"];
            
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定好评。");
            // 底部提示
            [self showMessage:@"已好评"];
            
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
        
    }else if (sectionNo == 1 && cellNo == 2) {//   联系客服
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"联系客服" message:@"是否拨打客服热线？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消拨打。");
            // 底部提示
            [self showMessage:@"已取消拨打"];
            
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定拨打。");
            
            //  调用打电话界面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4000517317"]]];
            
            //  底部提示
            [self showMessage:@"启动拨打"];
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
        
    }else if (sectionNo == 2 && cellNo == 0) {//  当前版本
        //  1、创建对象
        
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"版本信息" message:@"当前版本v7.25,是否更新？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消更新。");
            // 底部提示
            [self showMessage:@"已取消更新"];
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定更新。");
            // 底部提示
            [self showMessage:@"当前为最新版本"];
            
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
    }
}



#pragma mark Switch开关点击事件
// 仅在WiFi下显示图片 开关事件
- (void)dispImgSwitchAction:(id)sender {
    
    
    UISwitch *switchView = (UISwitch *)sender;
    
    if ([switchView isOn])
    {
        NSLog(@"仅在WiFi下显示图片 开关已打开：isOn");
        
        // 底部提示
        [self showMessage:@"显示图片开关已打开"];
        
        NSLog(@"switchIndex = %ld",self.view.tag);
        
    }
    else
    {
        NSLog(@"仅在WiFi下显示图片 开关已关闭：isOff");
        NSLog(@"switchIndex = %ld",self.view.tag);
        
        // 底部提示
        [self showMessage:@"显示图片开关已关闭"];
        
    }
    
}

// 消息提醒 开关事件
- (void)msgRemindSwitchAction:(id)sender {
    
    
    UISwitch *switchView = (UISwitch *)sender;
    
    if ([switchView isOn])
    {
        NSLog(@"消息提醒开关已打开：isOn");
        NSLog(@"switchIndex = %ld",self.view.tag);
        // 底部提示
        NSString *message = @"消息提醒已打开";
        [self showMessage:message];
    }
    else
    {
        NSLog(@"消息提醒开关已关闭：isOff");
        NSLog(@"switchIndex = %ld",self.view.tag);
        // 底部提示
        NSString *message = @"消息提醒已关闭";
        [self showMessage:message];
        
    }
    
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
