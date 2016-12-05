//
//  PersonalCenterViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "EditNickNameViewController.h"
#import "BindPhoneNumberViewController.h"
#import "PayPasswordViewController.h"
#import "ChangeLoginPasswordViewController.h"
#import "NoneDeliveryAddressViewController.h"
#import "DeliveryAddressViewController.h"
#import "UserQrCodeViewController.h"
#import "MyViewController.h"
#import "ProvinceCityDistrictViewController.h"





@interface PersonalCenterViewController ()
{
    NSArray     *_listArry;//用于懒加载 plist数据的数组
    UIButton    *_userLogOutBtn;
    UIImageView *_userHeadImgView;
    UILabel     *_nickNameLabel;
    UILabel     *_phoneLabel;
    NSString    *_birthdayStr;
    UserData    *_userData;
}

@property (weak, nonatomic) IBOutlet UITableView *personalCenterTableView;
@property (strong, nonatomic) MHDatePicker *selectDatePicker;    //  日期选择器


@end


@implementation PersonalCenterViewController

// 懒加载
- (NSArray *)listArry
{
    if (_listArry == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
        _listArry = [NSArray arrayWithContentsOfFile:path];
    }
    return _listArry;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //数据库
    _userData = [[UserData alloc]init];
    _userHeadImgView = [[UIImageView alloc] init];
    
    //  设置导航栏显示的标题
    self.title = @"个人中心";
    //  隐藏底部分栏
    self.tabBarController.tabBar.hidden = YES;
    //  隐藏返回按钮文字，只留图标
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    //设置导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置导航栏按钮图标颜色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    NSLog(@"self.listArry %@",self.listArry);
    
    self.personalCenterTableView.sectionFooterHeight = 24;
    
    //  添加TableView Footer 底部 退出登录 按钮
    [self addFooterButton];
    
    
}

- (void)selcetModel{
    
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
    for (UserModel *model in [_userData selectData]) {
        if ([model.userPhone isEqualToString:_userModel.userPhone]) {
            
            _userModel = model;
            NSLog(@"model = %@",model);
        }
        
    }
}

// 将要离开视图的 方法
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;//将要离开视图，显示底部分栏
}
- (void)viewWillAppear:(BOOL)animated{
    
    
    [self selcetModel];
    _nickNameLabel.text =  _userModel.userName;
    _phoneLabel.text    =   [_userModel.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

    
    UITableViewCell *birthCell = [_personalCenterTableView viewWithTag:1202];
    birthCell.detailTextLabel.text = _userModel.userBirthday;
    
    UITableViewCell *nameCell = [_personalCenterTableView viewWithTag:1102];
    nameCell.detailTextLabel.text = _userModel.userAdminName;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_userModel.userPhone];
    _userHeadImgView.image = [UIImage imageWithContentsOfFile:filePath];

//    [_personalCenterTableView reloadData];
    
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
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    // 1、先通过组数获取字典
    NSDictionary *sectionDic = [self.listArry objectAtIndex:indexPath.section];
    
    // 2、通过datas这个Key 来获取cell的行数（数组）
    NSArray *cellArry = [sectionDic objectForKey:@"datas"];
    
    // 3、通过cell行数（row）获取cell的字典（cell的数据）
    NSDictionary *cellDic = [cellArry objectAtIndex:indexPath.row];
    
    // 4、设置单元格 从plist文件中 获取的cell的字典 设置textLabel标签的文本
    //  tabCell.imageView.image = [UIImage imageNamed:[cellDic objectForKey:@"image"]];
    
    // 5、单元格cell右边小箭头
    tabCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 6、单元格 cell右边文字显示（需要在前面 先设置 单元格风格：Value1 风格）
    //  tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    if (indexPath.section == 0 && indexPath.row == 0) { // 头像 cell
        
        tabCell.tag = 1101;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
        tabCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //  用户头像
        NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_userModel.userPhone];
        _userHeadImgView.image = [UIImage imageWithContentsOfFile:filePath];
        if (_userHeadImgView.image == nil) {
            
            _userHeadImgView.image = [UIImage imageNamed:@"user_head"];
        }
        [_userHeadImgView setFrame:CGRectMake(theWidth*0.76, 5, theWidth*0.144, theWidth*0.144)];
       
        [_userHeadImgView.layer setMasksToBounds:YES]; //设置头像图片视图圆角
        [_userHeadImgView.layer setCornerRadius:theWidth*0.144/2]; //设置矩形四个圆角半径

        [tabCell addSubview:_userHeadImgView];
        
        //[userImgView alignmentRectForFrame:CGRectMake(0, 10, 100, 44)];
        
        //  用户头像右边的箭头
//        UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userInfo_arrow"]];
//        [arrowImgView setFrame:CGRectMake(theWidth*0.71, theHeight*0.037, 8, 14)];
        
//          创建一个View 将用户头像和箭头添加到View
//        UIView *userHeadView = [[UIView alloc] initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.73, theHeight*0.096)];
//        [userHeadView addSubview:_userHeadImgView];
////      [userHeadView addSubview:arrowImgView];
        
        
        //  [userImgView setAutoresizingMask:userHeadView];
        //  [arrowImgView setAutoresizingMask:userHeadView];
        
        //  accesoryView 属性 添加自定义控件
//        tabCell.accessoryView = userHeadView;
        

        
    } else if (indexPath.section == 0 && indexPath.row == 1) { // 用户名 cell
        
        tabCell.tag = 1102;
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = _userModel.userAdminName;
        if (_userModel.userAdminName != nil) {
            tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        tabCell.accessoryType = UITableViewCellAccessoryNone;
        
    } else if (indexPath.section == 0 && indexPath.row == 2) { //  昵称 cell
        
        tabCell.tag = 1103;
    
        //添加 昵称的label 
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3.0, 0, theWidth/3.0+20, theHeight*0.065)];
        _nickNameLabel.text = _userModel.userName;
        _nickNameLabel.textColor = [UIColor grayColor];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
        [tabCell addSubview:_nickNameLabel];
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = @"修改";
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (indexPath.section == 0 && indexPath.row == 3){ // 已绑手机号 cell
        
        tabCell.tag = 1104;
        
        
        
        //  添加 手机号 的label
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3.0, 0, theWidth/3.0, theHeight*0.065)];
        
        // 手机号中间四位 隐藏实现
        _phoneLabel.text =  [_userModel.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        [tabCell addSubview:_phoneLabel];
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = @"变更";
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    }  else if ((indexPath.section == 0 && indexPath.row == 4)||(indexPath.section == 0 && indexPath.row == 5)) { //登录密码 支付密码 cell
        
        if (indexPath.section == 0 && indexPath.row == 4) {
            
             tabCell.tag = 1105;
            
        }else if (indexPath.section == 0 && indexPath.row == 5){
        
             tabCell.tag = 1106;
        
        }
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = @"修改";
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (indexPath.section == 1 && indexPath.row == 0){ // 性别 cell
        
        tabCell.tag = 1201;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = _userModel.userSex;
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (indexPath.section == 1 && indexPath.row == 1){ // 生日 cell
        
        tabCell.tag = 1202;
        
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        tabCell.detailTextLabel.text = _userModel.userBirthday;
        tabCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
    } else {
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            
            tabCell.tag = 1203;
            
        }else if (indexPath.section == 1 && indexPath.row == 1){
            
            tabCell.tag = 1204;
            
        }
    
        tabCell.textLabel.text = [cellDic objectForKey:@"title"];
        
    }
    
    return tabCell;
}

#pragma mark UITableViewDelegate 委托方法

/**
 
// 四、设置section 头部
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//{
//    //  1、 先通过组数获取字典
//    NSDictionary *sectionDic = [self.listArry objectAtIndex:section];
//    
//    //  2、创建一个label 用于解决显示组的头部显示效果
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, theWidth*0.24, theHeight*0.03)];
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


// 设置section  尾部
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *userLogOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10 , theWidth-5, 64)];
    userLogOutBtn.titleLabel.text = @"退出登录";
    userLogOutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    userLogOutBtn.tintColor = [UIColor orangeColor];
    userLogOutBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [userLogOutBtn addTarget:self action:@selector(userLogOutAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    //  创建一个UIView 位置和大小 设置自适应
//        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
//    
//    //  将label添加到view上
//        [view addSubview:userLogOutBtn];
    
    //  返回创建的View 此方法可以解决使用字符串返回对象 字符串显示在section头部顶格的问题，改善视觉体验
    
        return userLogOutBtn;

}

 **/
/*
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    if (section == 1)
//    {
//        //  设置TableView 的尾部
//        UITableViewHeaderFooterView *view = [_personalCenterTableView footerViewForSection:1];
//        UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth*0.96, theHeight*0.086)];
//        UIButton* logOutBtn = [[UIButton alloc] initWithFrame:footerView.frame];
//        logOutBtn.titleLabel.text = @"退出登录";
//        logOutBtn.titleLabel.textColor = [UIColor whiteColor];
//        logOutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        logOutBtn.tintColor = [UIColor orangeColor];
//        
//        [logOutBtn addTarget:self action:@selector(userLogOutAction:) forControlEvents:UIControlEventTouchUpInside];
//        
////        [footerView addSubview:logOutBtn];
////        [view addSubview:footerView];
//
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////
////        [button setTitle:@"我是button 1" forState:UIControlStateNormal ];
////        
//        _userLogOutBtn = logOutBtn;
//
//     }
//    
//    return _userLogOutBtn;
//
//    
//}

*/
//  设置cell row 的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return theHeight*0.095;
        
    } else {
        
        return theHeight*0.065;
        
    }

    
}



// 设置section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 10;
}

// 设置section的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
     return 2;
    
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
    
    // 选中对应cell：头像 昵称 的  点击事件或推出页面
    if (sectionNo == 0 && cellNo == 0) {
        
        //  1、头像 cell 点击事件
        
        //创建提示视图控制器
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //创建提示按钮点击事件 theAlbumAction theCameraAction theCancelAction
        UIAlertAction *theCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self theSelectImage:YES];
        }];
        
        UIAlertAction * theAlbumAction= [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self theSelectImage:NO];
        }];
        
        UIAlertAction *theCancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self showMessage:@"取消上传"];
        }];
        
        //在提示控制器上添加以上提示按钮
        [alertCtr addAction:theCameraAction];
        [alertCtr addAction:theAlbumAction];
        [alertCtr addAction:theCancelAction];
        
        //将提示控制器设置为推出视图
        [self presentViewController:alertCtr animated:YES completion:^{
            [self showMessage:@"请拍照或从本地相册选择头像。"];
        }];
        
    }else if (sectionNo == 0 && cellNo == 1) {
        

        if (_userModel.userAdminName.length == 0) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名（不可更改）" preferredStyle:UIAlertControllerStyleAlert];
            //增加取消按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            //增加确定按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //获取第1个输入框；
//                UITextField *userNameTextField = alertController.textFields.firstObject;
                
                _userModel.userAdminName = alertController.textFields.firstObject.text;
                
                [_userData updateUsersData:_userModel];
                
                [tableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleNone;
 
                [_personalCenterTableView reloadData];
                
            }]];
            
            
            
            //定义第一个输入框；
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入用户名";
            }];
            
            [self presentViewController:alertController animated:true completion:nil];
            

            
        }
        
    }
    else if (sectionNo == 0 && cellNo == 2) {
            
        //  2、编辑昵称 cell 推出的页面
        
        // 创建视图控制器 push 编辑昵称页面
        EditNickNameViewController *editNickNameViewCtr = [[EditNickNameViewController alloc] init];
        editNickNameViewCtr.editModel = _userModel;
        [self.navigationController pushViewController:editNickNameViewCtr animated:YES];
        
    
        
    }else if (sectionNo == 0 && cellNo == 3) {
        
        //  3、绑定手机号 cell 推出的页面
        
        // 创建视图控制器 push 绑定手机号页面
        BindPhoneNumberViewController *bindPhoneNoViewCtr = [[BindPhoneNumberViewController alloc] init];
        bindPhoneNoViewCtr.userModel = _userModel;
        [self.navigationController pushViewController:bindPhoneNoViewCtr animated:YES];
        
        
    }else if (sectionNo == 0 && cellNo == 4) {
        
        //  4、支付密码 cell 推出的页面
        
        // 创建视图控制器 push 支付密码页面
        PayPasswordViewController *payPasswordViewCtr = [[PayPasswordViewController alloc] init];
        payPasswordViewCtr.userModel = _userModel;
        [self.navigationController pushViewController:payPasswordViewCtr animated:YES];
        
        
        
    }else if (sectionNo == 0 && cellNo == 5) {
        
        //  5、登录密码 cell 推出的页面
        
        // 创建视图控制器 push 登录密码页面
        ChangeLoginPasswordViewController *changeLoginPasswordViewCtr = [[ChangeLoginPasswordViewController alloc] init];
        changeLoginPasswordViewCtr.userModel = _userModel;
        [self.navigationController pushViewController:changeLoginPasswordViewCtr animated:YES];
        
        
    }else if (sectionNo == 1 && cellNo == 0) {
        
        //  6、性别 cell 点击事件
        
        //创建提示视图控制器
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //创建提示按钮点击事件 theAlbumAction theCameraAction theCancelAction
        UIAlertAction *theFemaleAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [self theSelectFemale:YES];
             //更改cell 副标题的 值
            UITableViewCell *sexTabCell = (UITableViewCell *)[_personalCenterTableView viewWithTag:1201];
            sexTabCell.detailTextLabel.text = @"女";
            
            _userModel.userSex =  @"女";
            
            [_userData updateUsersData:_userModel];
            
        }];
        
        
        UIAlertAction *theMaleAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self theSelectFemale:NO];
            //更改cell 副标题的 值
            UITableViewCell *sexTabCell = (UITableViewCell *)[_personalCenterTableView viewWithTag:1201];
            sexTabCell.detailTextLabel.text = @"男";
            
            _userModel.userSex =  @"男";
            [_userData updateUsersData:_userModel];
            
        }];
        
//        UIAlertAction *theCancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
        
        //在提示控制器上添加以上提示按钮
        [alertCtr addAction:theFemaleAction];
        [alertCtr addAction:theMaleAction];
        
        //将提示控制器设置为推出视图
        [self presentViewController:alertCtr animated:YES completion:^{
            
        }];
    }else if (sectionNo == 1 && cellNo == 1) {
        
        //  7、生日 cell 推出的页面
        
        // 创建视图控制器 push 生日页面
        _selectDatePicker = [[MHDatePicker alloc] init];
        _selectDatePicker.isBeforeTime = YES;
        _selectDatePicker.datePickerMode = UIDatePickerModeDate;
        
        __weak typeof(self) weakSelf = self;
        [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
            
            _userModel.userBirthday = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
            
            [_userData updateUsersData:_userModel];
            
            [_personalCenterTableView reloadData];
//            weakSelf.myLabel2.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日"];
        }];
        
    }else if (sectionNo == 1 && cellNo == 2) {
        
        //  8、收货地址 cell 推出的页面
        
        //  1、创建对象
        ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"是否已添加过收货地址？"];
        
        //  2、添加按钮
        [alertView addBtnTitle:@"否" action:^{
            // 从未添加过收货地址
            // 创建视图控制器 push 收货地址页面
            NoneDeliveryAddressViewController *noneDeliveryAddressViewCtr = [[NoneDeliveryAddressViewController alloc] init];
            [self.navigationController pushViewController:noneDeliveryAddressViewCtr animated:YES];
            

            // 底部提示
            [self showMessage:@"跳转至 未添加过收货地址的页面！"];
        }];
        
        [alertView addBtnTitle:@"是" action:^{
            
            // 已添加过的收货地址
            // 创建视图控制器 push 收货地址页面
            DeliveryAddressViewController *deliveryAddressViewCtr = [[DeliveryAddressViewController alloc] init];
            [self.navigationController pushViewController:deliveryAddressViewCtr animated:YES];
            
            //  底部提示
            [self showMessage:@"跳转至 添加过收货地址的页面！"];
            
            //  MyViewController *myViewCtr = [[MyViewController alloc] init];
            //  [self.navigationController pushViewController:myViewCtr animated:YES];
            
        }];
        
        //  3、显示
        
        [alertView showAlertWithSender:self];
        

        
    }else if (sectionNo == 1 && cellNo == 3) {
        
        //  9、我的二维码 cell 推出的页面
        
        // 创建视图控制器 push 二维码页面
        UserQrCodeViewController *userQrCodeViewCtr = [[UserQrCodeViewController alloc] init];
        userQrCodeViewCtr.model = _userModel;
        [self.navigationController pushViewController:userQrCodeViewCtr animated:YES];
        
        
    }
 
}


/**
 *  添加底部按钮
 */
-(void)addFooterButton
{
    //1.初始化Button
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //2.设置文字和文字颜色
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    //3.设置圆角幅度 和 边框线
    logOutBtn.layer.cornerRadius = 15.0;
//    logOutBtn.layer.borderWidth = 0.5;
    
    //4.设置frame
    logOutBtn.frame = CGRectMake( 30, 30, theWidth-60, theHeight*0.065);
    
    //5.设置背景色  和字体
    logOutBtn.backgroundColor = [UIColor orangeColor];
    logOutBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    //6.设置触发事件
    [logOutBtn addTarget:self action:@selector(userLogOutAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, theWidth,theHeight*0.055+40)];
//    view.backgroundColor = [UIColor blueColor];
    
    [view addSubview:logOutBtn];
    //7.添加到tableView tableFooterView中
    self.personalCenterTableView.tableFooterView = view;
}


- (void)userLogOutAction:(id)sender
{
    NSLog(@"用户退出登录！");
    //  1、创建对象
    ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录？"];
    
    //  2、添加按钮
    [alertView addBtnTitle:@"取消" action:^{
    // 确定退出登录 底部提示
        [self showMessage:@"取消退出！"];
    }];
    
    [alertView addBtnTitle:@"确定" action:^{
        
    // 确定退出登录 底部提示
        [self showMessage:@"成功退出登录！"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"退出当前账号" object:@"12"];
        NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
        [userDeafaults setObject:nil forKey:@"user"];
        [userDeafaults setInteger:0 forKey:@"login"];
    
    // 视图消失
        [self.navigationController popViewControllerAnimated:YES];
    //  MyViewController *myViewCtr = [[MyViewController alloc] init];
    //  [self.navigationController pushViewController:myViewCtr animated:YES];
        
    }];
    
    //  3、显示
    
    [alertView showAlertWithSender:self];
    
}


//选择是相册  还是摄像头
- (void)theSelectImage:(BOOL)isCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //  sourceType  :选择的风格 有相册、所有的照片资源、摄像头
    //  UIImagePickerControllerSourceTypePhotoLibrary,所有的照片资源
    //  UIImagePickerControllerSourceTypeCamera, 摄像头
    //  UIImagePickerControllerSourceTypeSavedPhotosAlbum  相册

    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (isCamera) {
        //  UIImagePickerControllerCameraDeviceRear, 后置摄像头
        //  UIImagePickerControllerCameraDeviceFront 前置摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            [self showMessage:@"很抱歉，当前不支持摄像头！"];
            return;
        }
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    imagePicker.delegate = self;  //设置委托方法
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        
        [self showMessage:@"从相册选择头像图片。"];
       
    }];
}

#pragma mark UIImagePickerControllerDelegate 
//选择图片后的委托方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    NSLog(@"info = %@",info);
    
    //  UIImagePickerControllerEditedImage 编辑图片
    //  UIImagePickerControllerOriginalImage 原始图片
    //  用户头像
    [_userHeadImgView setFrame:CGRectMake(theWidth*0.51, 5, theWidth*0.144, theWidth*0.144)];
    [_userHeadImgView.layer setMasksToBounds:YES]; //设置头像图片视图圆角
    [_userHeadImgView.layer setCornerRadius:theWidth*0.144/2]; //设置矩形四个圆角半径
    //[userImgView alignmentRectForFrame:CGRectMake(0, 10, 100, 44)];
    
    //  用户头像右边的箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userInfo_arrow"]];
    [arrowImgView setFrame:CGRectMake(theWidth*0.71, theHeight*0.037, 8, 14)];
    
    //  创建一个View 将用户头像和箭头添加到View
    UIView *userHeadView = [[UIView alloc] initWithFrame:CGRectMake(theWidth*0.27, 10, theWidth*0.73, theHeight*0.096)];
    [userHeadView addSubview:_userHeadImgView];
    [userHeadView addSubview:arrowImgView];
    
    // [userImgView setAutoresizingMask:userHeadView];
    // [arrowImgView setAutoresizingMask:userHeadView];
    
    
    UITableViewCell *tabCell = [_personalCenterTableView viewWithTag:1101];
    
    //  accesoryView 属性 添加自定义控件
    tabCell.accessoryView = userHeadView;

    
    //并让视图消失
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = info[UIImagePickerControllerEditedImage];
        
        //设置照片的品质
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        NSLog(@"%@",NSHomeDirectory());
        // 获取沙盒目录
        NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_userModel.userPhone];
        // 将图片写入文件
        [imageData writeToFile:filePath atomically:NO];
        //将选择的图片显示出来
        _userHeadImgView.image = image;
        
        // 发送修改头像通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"更改了头像" object:filePath];
        //    [self.photoImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        
    }];
}
//取消选择图片的委托方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    
     [self showMessage:@"已取消上传！"];
    // 取消dismiss
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//选择是女  还是男
- (void)theSelectFemale:(BOOL)isFemale
{
    if (isFemale) {
    
        [self showMessage:@"女"];
        
    } else {
    
        [self showMessage:@"男"];
    
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

#pragma mark 转为日期选择格式
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

@end
