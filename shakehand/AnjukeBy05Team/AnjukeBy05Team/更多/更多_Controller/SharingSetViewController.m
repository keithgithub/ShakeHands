//
//  SharingSetViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/8.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "SharingSetViewController.h"
#import "MoreViewController.h"

@interface SharingSetViewController ()
{
    NSArray *_listArry;//用于懒加载 plist数据的数组
}

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation SharingSetViewController



//懒加载 固定的数据
- (NSArray *)listArry
{
    if (_listArry == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sharingSet" ofType:@"plist"];
        _listArry = [NSArray arrayWithContentsOfFile:path];
    }
    return _listArry;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"分享设置";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//设置导航栏背景色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//设置导航栏按钮图标颜色
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
}

// 将要离开视图的 方法
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;//将要离开视图，显示底部分栏
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
    return 1;
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
    tabCell.imageView.image = [UIImage imageNamed:[cellDic objectForKey:@"iconimg"]];
    tabCell.textLabel.text = [cellDic objectForKey:@"title"];
    tabCell.textLabel.textColor = [UIColor darkGrayColor];
    
    tabCell.detailTextLabel.text = @"未绑定";
    
    tabCell.accessoryType = UITableViewCellAccessoryNone;
    
    
    // 5、创建 bindLabel（isBinding 是否绑定 默认：未绑定） 显示在cell右边的text
    //注意设置 X轴的位置 和宽度
    UILabel *bindLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, theWidth*0.47, 20)];
    //通过上面数据源获取的字典cell的数据 设置给plistLabel的text属性
    bindLabel.text = @"未绑定";
    //bindLabel里面的text   右对齐
    bindLabel.textAlignment = NSTextAlignmentRight;
    //bindLabel中text的字体颜色设置
    bindLabel.textColor = [UIColor orangeColor];
    
    // 在对应cell上 添加控件和内容
    if (indexPath.section == 0 && indexPath.row == 0) {//右边未绑定
        
        tabCell.accessoryView = bindLabel;// accesoryView 属性 添加自定义dispImgSwitch开关控件
        tabCell.tag = 7001;//设置绑定新浪微博的cell的 tag值
        
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {//右边未绑定
        tabCell.accessoryView = bindLabel;// accesoryView 属性 添加自定义dispImgSwitch开关控件
        tabCell.tag = 7002;//设置绑定新浪微博的cell的 tag值
        
    }
    
    //    else if ((indexPath.section == 0 && indexPath.row == 0)||(indexPath.section == 0 && indexPath.row == 1)) {//右边小箭头
    //        //accessoryType 属性 设置cell右边的相关的系统自带控件 DisclosureIndicator 右箭头 导航下一级页面
    //        tabCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //
    //    }
    
    
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
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 30)];
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

// 设置单元格cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return theHeight*0.07;
}

// 设置section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
    
}

// 设置section的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return theHeight*0.6;
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
    if (sectionNo == 0 && cellNo == 0) {
        
        
        //  绑定新浪微博 cell 点击的事件
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"绑定新浪微博" message:@"是否需要绑定新浪微博？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消绑定。");
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定绑定。");
            //  创建绑定新浪微博的cell：sinaBindCell
            UITableViewCell * sinaBindCell = (UITableViewCell*)[_theTableView viewWithTag:7001];
            
            //  创建绑定新浪微博后 修改标签 Label
            UILabel *isbindedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.53, 40)];
            
            isbindedLabel.text = @"上善若水";//标签内容
            isbindedLabel.textAlignment = NSTextAlignmentRight;//isbindedLabel右对齐
            isbindedLabel.textColor = [UIColor darkGrayColor];//字体颜色
            
            //  创建一个UIView
            UIView *bindView = [[UIView alloc]initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.53, 40)];
            
            //  将isbindedLabel添加到bindView上
            //  这样添加实现更改label的内容，不能直接在cell上添加label,直接添加会使cell在点击清除时直接消失
            [bindView addSubview:isbindedLabel];
            
            //  accesoryView 属性 添加自定义控件
            sinaBindCell.accessoryView = bindView;
            
            NSLog(@"cellTag = %ld",(long)sinaBindCell.tag);
            // 底部提示
            [self showMessage:@"新浪微博绑定成功"];
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
    }else if (sectionNo == 0 && cellNo == 1) {
        
        //  绑定新浪微博 cell 点击的事件
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"绑定腾讯微博" message:@"是否需要绑定腾讯微博？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            //  点击取消按钮的事件
            NSLog(@"取消绑定。");
            
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            //  点击确定按钮的事件
            NSLog(@"确定绑定。");
            //  创建绑定腾讯微博的cell：tencBindCell
            UITableViewCell * tencBindCell = (UITableViewCell*)[_theTableView viewWithTag:7002];
            
            //  创建绑定新浪微博后 修改标签 Label
            UILabel *isbindedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.53, 40)];
            
            isbindedLabel.text = @"高山流水";//标签内容
            isbindedLabel.textAlignment = NSTextAlignmentRight;//isbindedLabel右对齐
            isbindedLabel.textColor = [UIColor darkGrayColor];//字体颜色
            
            //  创建一个UIView
            UIView *bindView = [[UIView alloc]initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.53, 40)];
            
            //  将isbindedLabel添加到bindView上
            //  这样添加实现更改label的内容，不能直接在cell上添加label,直接添加会使cell在点击清除时直接消失
            [bindView addSubview:isbindedLabel];
            
            //  accesoryView 属性 添加自定义控件
            tencBindCell.accessoryView = bindView;
            
            NSLog(@"cellTag = %ld",(long)tencBindCell.tag);
            // 底部提示
            [self showMessage:@"腾讯微博绑定成功"];
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        
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
