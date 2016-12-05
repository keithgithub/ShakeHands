//
//  AddUserAddressViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "AddUserAddressViewController.h"
#import "ProvinceCityDistrictViewController.h"

@interface AddUserAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_listArry;
    UITextField *userAddressInfoTextField;
//  NSDictionary *_theTotalDic;
//  NSString *_theAllKeys;
    
}
//@property(nonatomic,copy) NSDictionary *theTotalDic;
//@property(nonatomic,copy) NSArray *theAllKeys;

@property (weak, nonatomic) IBOutlet UITableView *theAddUserAddressTableView;

@end

@implementation AddUserAddressViewController


@class DeliveryAddressViewController;

// 懒加载
- (NSArray *)listArry
{
    if (_listArry == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userDeliveryAddress" ofType:@"plist"];
        _listArry = [NSArray arrayWithContentsOfFile:path];
    }
    return _listArry;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = @"编辑收货地址";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    // TableView 不滚动
    _theAddUserAddressTableView.scrollEnabled = NO;//设置TableView 不滚动
    

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
    
    // 4、设置section尾部的高度
    self.theAddUserAddressTableView.sectionFooterHeight = 24;
    
    // 5、添加TableView Footer 底部视图View
    [self addFooterSaveButtonForAddressView];
    
//  [self addFooterSetDefaultAddressView];

    // 设置标题字体颜色
    tabCell.textLabel.textColor = [UIColor grayColor];
    
    
    // 自定义cell右边文本显示
    userAddressInfoTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, theWidth/3, theHeight*0.066)];
    userAddressInfoTextField.textColor = [UIColor blackColor];

    
    userAddressInfoTextField.textAlignment =  NSTextAlignmentRight;
//    userAddressInfoTextField.textColor = [UIColor lightTextColor];

    if ( indexPath.section == 0 && indexPath.row == 0 ) { // 收货人姓名 cell
        
        tabCell.tag = 5101;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
//        userAddressInfoTextField.textAlignment =  NSTextAlignmentRight;
//        userAddressInfoTextField.textColor = [UIColor lightTextColor];
        
        userAddressInfoTextField.placeholder = @"最少2个字";
        
        tabCell.accessoryView = userAddressInfoTextField;
        
//        tabCell.detailTextLabel.text = [cellDic objectForKey:@"rightTitle"];
//        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else if ( indexPath.section == 0 && indexPath.row == 1) { // 电话号码 cell
        
        tabCell.tag = 5102;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
        userAddressInfoTextField.placeholder = @"不少于7位";
        tabCell.accessoryView = userAddressInfoTextField;
        
//        tabCell.detailTextLabel.text = [cellDic objectForKey:@"rightTitle"];
//        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else if ( indexPath.section == 0 && indexPath.row == 2) { //  省份城市 cell
        
        tabCell.tag = 5103;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
        UILabel *selectedCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.75, 0, theWidth*0.2, theHeight*0.066)];
        selectedCityLabel.text = [cellDic objectForKey:@"rightTitle"];
        selectedCityLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        selectedCityLabel.textAlignment = NSTextAlignmentRight;
        selectedCityLabel.tag =5133;
        
        tabCell.accessoryView = selectedCityLabel;
//        
//        tabCell.detailTextLabel.text = @"请选择";
//        
//        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    } else if ( indexPath.section == 0 && indexPath.row == 3 ) { // 详细地址 cell
        
        tabCell.tag = 5104;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
        userAddressInfoTextField.placeholder = @"请输入文本";
    
        tabCell.accessoryView = userAddressInfoTextField;
        
//        tabCell.detailTextLabel.text = [cellDic objectForKey:@"rightTitle"];
        
//        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    }  else if ( indexPath.section == 0 && indexPath.row == 4 ) { // 邮政编码 cell
        
        tabCell.tag = 5105;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
        userAddressInfoTextField.placeholder = @"请输入6位数字";
        
        tabCell.accessoryView = userAddressInfoTextField;
        
//        tabCell.detailTextLabel.text = [cellDic objectForKey:@"rightTitle"];
//        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
        
    }
    
    return tabCell;
                
}


#pragma mark 添加 收货地址尾部视图 设置默认地址View
//- (void)addFooterSetDefaultAddressView
//{
//    //1.创建 设置默认地址的视图View
//    UIView *setDefaultAddressView = [[UIView alloc] initWithFrame:CGRectMake(theWidth*0.013, theWidth*0.013, theWidth-10, theHeight*0.065)];
//    
//    //2.创建UIImageView 用于设置单选按钮
//    UIImageView *radioButtonSelectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.12, theHeight*0.065)];
////  [radioButtonSelectedImgView initWithImage:[UIImage imageNamed:@"RadioButton-Unselected"] highlightedImage:[UIImage imageNamed:@"RadioButton-selected"]];
//    
//    [radioButtonSelectedImgView initWithImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
//    
//    //3.创建 设置默认地址View 右边的Label
//    UILabel *setDefaultAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.12, 0, theWidth*0.88, theHeight*0.065)];
//    setDefaultAddressLabel.textAlignment = NSTextAlignmentLeft;
//    setDefaultAddressLabel.textColor = [UIColor grayColor];
//    setDefaultAddressLabel.text = @"设置为默认地址";
//    
//    //4.添加 单选按钮 和 文本标签 到 自定义的设置默认地址View
//    [setDefaultAddressView addSubview: radioButtonSelectedImgView];
//    [setDefaultAddressView addSubview:setDefaultAddressLabel];
//
//    //5.添加到tableView tableFooterView中
//    self.theAddUserAddressTableView.tableFooterView = setDefaultAddressView;
//    
//}

#pragma mark 单选按钮 点击事件
- (void)radioBtnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == NO) {
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"RadioButton-selected"] forState:UIControlStateNormal];
        [self showMessage:@"设置默认地址"];
    }
    else{
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
        [self showMessage:@"取消默认地址"];
    }
    
}

#pragma mark 添加 收货地址尾部视图 保存按钮
- (void)addFooterSaveButtonForAddressView
{
    //**  ---------------------------------------------------  **
    //**    一、 创建 设置 默认地址View 并添加到 保存地址View上      **
    //**  ---------------------------------------------------  **
    
    //a.创建 设置默认地址的视图View
    UIView *setDefaultAddressView = [[UIView alloc] initWithFrame:CGRectMake(theWidth*0.025, 0, theWidth-10, theHeight*0.065)];
    //  setDefaultAddressView.backgroundColor = [UIColor purpleColor];
    
    // 创建 单选按钮
    UIButton *radioButton = [[UIButton alloc] initWithFrame:CGRectMake(0, theWidth*0.05, theWidth*0.065, theHeight*0.035)];
    [radioButton setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    
    [radioButton addTarget:self action:@selector(radioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    //b.创建UIImageView 用于设置单选按钮
//    UIImageView *radioButtonSelectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, theWidth*0.05, theWidth*0.065, theHeight*0.035)];
//    //  [radioButtonSelectedImgView initWithImage:[UIImage imageNamed:@"RadioButton-Unselected"] highlightedImage:[UIImage imageNamed:@"RadioButton-selected"]];
//    
//    // 单选按钮图片
//    [radioButtonSelectedImgView initWithImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
    
    //c.创建 设置默认地址View 右边的Label
    UILabel *setDefaultAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.08, theWidth*0.02, theWidth*0.85, theHeight*0.065)];
    setDefaultAddressLabel.textAlignment = NSTextAlignmentLeft;
    setDefaultAddressLabel.textColor = [UIColor grayColor];
    setDefaultAddressLabel.text = @"设置为默认地址";
    
    //d.添加 单选按钮 和 文本标签 到 自定义的设置默认地址View
    [setDefaultAddressView addSubview: radioButton];
    [setDefaultAddressView addSubview:setDefaultAddressLabel];
    
    //**  ---------------------------------------------------  **
    //**  二、 创建 设置 保存地址button按钮 并添加到 保存地址View上   **
    //**  ---------------------------------------------------  **
    
    //1.初始化Button
    UIButton *saveAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //2.设置文字和文字颜色
    [saveAddressBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //3.设置圆角幅度 和 边框线
    saveAddressBtn.layer.cornerRadius = 10.0;
    //  logOutBtn.layer.borderWidth = 0.5;
    
    //4.设置frame
    saveAddressBtn.frame = CGRectMake( theWidth*0.025, theHeight*0.096, theWidth*0.95, theHeight*0.065);
    
    //5.设置背景色 和 按钮上的字体大小
    saveAddressBtn.backgroundColor = [UIColor orangeColor];
    saveAddressBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    //6.设置触发事件
    [saveAddressBtn addTarget:self action:@selector(saveUserAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //7.自定义一个 保存地址的尾部View 用来添加 button
    UIView *saveAddressview = [[UIView alloc]initWithFrame:CGRectMake(0, theHeight*0.3, theWidth,theHeight*0.6)];
    // 设置尾部View背景色
    saveAddressview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //8.将 保存按钮 和  设置默认地址View 添加到 自定义保存地址View上
    
    [saveAddressview addSubview:setDefaultAddressView];
    
    [saveAddressview addSubview:saveAddressBtn];

    //9.添加到tableView tableFooterView中
    self.theAddUserAddressTableView.tableFooterView = saveAddressview;

}

// 保存按钮点击事件
- (void)saveUserAddressAction:(id)sender
{
    
    
    if ([self isConsigneeName:userAddressInfoTextField.text] == NO) {
        
        [self showMessage:@"请输入包含中文的两位数姓名。"];
        
    } else {
        
        [self showMessage:@"收货人姓名格式正确。"];
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"是否保存收货地址？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"取消" action:^{
            // 取消保存 底部提示
            [self showMessage:@"取消保存！"];
        }];
        
        [alertView addBtnTitle:@"确定" action:^{
            
            // 确定保存 底部提示
            [self showMessage:@"成功保存收货地址！"];
            //        [[NSNotificationCenter defaultCenter]postNotificationName:@"退出当前账号" object:@"12"];
            //        NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
            //        [userDeafaults setObject:nil forKey:@"user"];
            //        [userDeafaults setInteger:0 forKey:@"login"];
            
            // 视图消失
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        

        
    }

    
}



#pragma mark UITableViewDelegate 委托方法

// 设置section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

// 设置section的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 1;
    
}
////  设置cell row 的行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0 && indexPath.row == 0) {
//
//        return theHeight*0.095;
//
//    } else {
//
//        return theHeight*0.065;
//
//    }
//
//
//}



#pragma mark 选中单元格的实现方法
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中时触发阴影效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sectionNo = indexPath.section;//组的索引下标
    NSInteger cellNo = indexPath.row;//行的索引下标
    
    // 选中对应cell的点击事件或推出页面
    if (sectionNo == 0 && cellNo == 0) {
        
        //  1、收货人姓名 cell
        
        [self showMessage:@"请输入包含中文的两位数姓名。"];
        
//        if ([self isConsigneeName:userAddressInfoTextField.text] == NO) {//
        
//            [self showMessage:@"格式不正确，请输入包含中文的两位数姓名。"];

//        } else {
        
//            [self showMessage:@"收货人姓名格式正确。"];
        
//        }

        
    }else if (sectionNo == 0 && cellNo == 1) {
        
        //  2、电话号码 cell
        [self showMessage:@"请输入至少7位数的电话号码。"];
        
    }else if (sectionNo == 0 && cellNo == 2) {
        
        //  3、省份城市 cell
        [self showMessage:@"请选择收货的省份城市。"];
        ProvinceCityDistrictViewController *provinceCityDistrictViewCtr = [[ProvinceCityDistrictViewController alloc] init];
        [self.view addSubview:provinceCityDistrictViewCtr.view];
        
    }else if (sectionNo == 0 && cellNo == 3) {
        
        //  4、详细地址 cell
        [self showMessage:@"请输入详细地址具体到街道和门牌号。"];
        
    }else if (sectionNo == 0 && cellNo == 4) {
        
        //  5、邮政编码 cell
        [self showMessage:@"请输入6位数的邮政编码。"];
        
    }
    
    
}

// 判断“2位或2位以上 包含汉字的收货人姓名” 封装的 私有方法
- (BOOL)isConsigneeName:(id)consNameStr
{
    //手机号以13，14，15，17，18开头，加九个 \d 数字字符
    //    NSString *phoneFormat = @"^1[3,4,5,7,8]\\d{9}$";
    //    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    //    BOOL isPhone= [phoneCheck evaluateWithObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
    
    //正则表达式 任意 数字和字母（必须包含数字和字母）6位或6位以上
//  NSString *consigneeNameFormat = @"^(?=.*?[\u4e00-\u9fa5])[\u4e00-\u9fa5]{2,}$";
//  NSString *consigneeNameFormat = @"^(?=.*?[\u4e00-\u9fa5])[A-Za-z0-9\u4e00-\u9fa5]{2,}$";
    
    BOOL isConsigneeName= [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]{2,}$"] evaluateWithObject:consNameStr];
    
//    NSString *consigneeNameFormat = @"^1[3,4,5,7,8]\\d{1}$";
//    //使用正则表达式定义谓词 用于格式匹配判断
//    NSPredicate *consigneeNameCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",consigneeNameFormat];
//    //输入的字段与要求格式匹配对比判断
//    BOOL isConsigneeName= [consigneeNameCheck evaluateWithObject:consNameStr];
    
    return isConsigneeName;//返回匹配后的值
    
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
