//
//  GoodsPayViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/16.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "GoodsPayViewController.h"
#import "UserCouponViewController.h"
#import "PayViewController.h"
#import "BindPhoneNumberViewController.h"


@interface GoodsPayViewController ()
{
    NSInteger _index; // 购买数量
    UITextField *numTextField;// 显示购买数量
    UIButton *downButton; // 购买数量减一按钮
    UILabel *theDetailLable;// 显示总价
    UILabel *moneyLable;// 价格Lable
    UILabel *numLable;//共多少件
    UIButton *selectedBtn ; //选中支付方式按钮
    NSInteger _num; //标示
    UserModel *_userModel;
    
}

#define lableAlpha 0.6
#define  buttonTag 1234
@end

@implementation GoodsPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    _index = 1;
    if (_numb > 0) {
        _index = _numb;
    }
    self.title = @"提交订单";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //本视图的属性

    self.thelableText = _mModel.movieName ? _mModel.movieName : _model.foodName;
    self.theDetaillableText = [NSString stringWithFormat:@"￥%ld",_cinemaModel.cinemaLowPrice?_cinemaModel.cinemaLowPrice : _model.price];

    
    
    
    // 创建表视图
    _num = 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight - 64- 0.2*theWidth) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    // 添加单击事件
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
   // [self.view addGestureRecognizer:tapGesture];
    // 视图最下方“去支付”视图
    UIView *footview =[[UIView alloc] initWithFrame:CGRectMake(0, theHeight - 0.2*theWidth-64, theWidth, 0.2*theWidth)];
    footview.backgroundColor = [UIColor whiteColor];
    [self addCtrToFootView:footview];
    [self.view addSubview:footview];
}
//// 向底部视图 footView 添加内容
-(void)addCtrToFootView:(UIView *)view
{
    // 立即购买按钮
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(0.61*theWidth, 0.03*theWidth, 0.3*theWidth, 0.14*theWidth);
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    payButton.backgroundColor = [UIColor orangeColor];
    payButton.layer.cornerRadius = 0.07*theWidth;
    payButton.layer.masksToBounds = YES;
    [payButton addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:payButton];
    // 合计
    UILabel *totalLable = [[UILabel alloc] initWithFrame:CGRectMake(0.02*theWidth, 0.075*theWidth, 0.15*theWidth, 0.05*theWidth)];
    totalLable.font = [UIFont systemFontOfSize:15];
    totalLable.text = @"合计：";
    totalLable.textColor = [UIColor orangeColor];
    [view addSubview:totalLable];
    // 价格Lable
    moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0.15*theWidth, 0.08*theWidth, 0.15*theWidth, 0.05*theWidth)];

    moneyLable.text =[NSString stringWithFormat:@"￥%ld",_index*(_cinemaModel.cinemaLowPrice ?_cinemaModel.cinemaLowPrice :_model.price)];

    NSLog(@"   moneyLable.text  = %@", moneyLable.text);
    
    moneyLable.textColor = [UIColor orangeColor];
    moneyLable.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:moneyLable];
    
    //共多少件
    numLable = [[UILabel alloc] initWithFrame:CGRectMake(0.29*theWidth, 0.08*theWidth, 0.15*theWidth, 0.05*theWidth)];
    numLable.alpha = lableAlpha;
    numLable.font = [UIFont systemFontOfSize:14];
    numLable.text = [NSString stringWithFormat:@"共%ld件",_index];
    [view addSubview:numLable];
    
}




#pragma mark 单击事件
-(void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    //去键盘
    [numTextField resignFirstResponder ];
}
//当界面出现时
-(void)viewWillAppear:(BOOL)animated
{
    // 隐藏导航栏 bar
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    // 自定义返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lightItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = lightItem;
    
    //读取当前登录的用户信息
    _userModel = [[UserModel alloc]init];
    NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
    _userModel.userPhone = [userDeafaults objectForKey:@"user"];
}
#pragma mark backButton 按钮事件
-(void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 表视图的数据源和委托方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{

    return 4;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 3;
    }else if (section == 3)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}
//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        if (indexPath.section == 0) {// 第一组
            if (indexPath.row == 0) {// 第一组的第一行
            
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.05*theWidth, 0.06*theWidth, 0.7*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.text = self.thelableText;
                [cell.contentView addSubview:theLable];
                UILabel *theDetailLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.06*theWidth, 0.12*theWidth, 0.04*theWidth)];
                theDetailLable1.textAlignment = NSTextAlignmentRight;
                theDetailLable1.font = [UIFont systemFontOfSize:14];
                theDetailLable1.alpha = lableAlpha;
                theDetailLable1.text = self.theDetaillableText;
                [cell.contentView addSubview:theDetailLable1];
            }else if (indexPath.row == 1)// 第一组的第二行
            {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                 cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                 UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.2*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.alpha = lableAlpha;
                theLable.text = @"数量：";
                [cell.contentView addSubview:theLable];
                // 减一按钮
                downButton = [UIButton buttonWithType:UIButtonTypeCustom];
                downButton.frame = CGRectMake(0.6*theWidth, 0.035*theWidth, 0.09*theWidth, 0.09*theWidth);
                downButton.tag = 2001;
                [downButton setImage:[UIImage imageNamed:@"btn_minus_unable"] forState:UIControlStateNormal];
                if (_index > 1) {
                     downButton.enabled = YES;
                     [downButton setImage:[UIImage imageNamed:@"btn_minus_able"] forState:UIControlStateNormal];
                }
                [downButton addTarget:self action:@selector(downBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:downButton];
                // 显示购买数量
                numTextField = [[UITextField alloc]initWithFrame:CGRectMake(0.71*theWidth, 0.03*theWidth, 0.12*theWidth, 0.1*theWidth)];
                numTextField.borderStyle = UITextBorderStyleRoundedRect;
                numTextField.textAlignment =NSTextAlignmentCenter;
                numTextField.text =[NSString stringWithFormat:@"%ld",_index];
                numTextField.font = [UIFont systemFontOfSize:14];
               // numTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
               // numTextField fir
                numTextField.keyboardType =  UIKeyboardTypeNumberPad;
                numTextField.returnKeyType = UIReturnKeyDefault;
                [cell.contentView addSubview:numTextField];
                // 加一按钮
                UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
                upButton.frame = CGRectMake(0.85*theWidth, 0.035*theWidth, 0.09*theWidth, 0.09*theWidth);
                [upButton setImage:[UIImage imageNamed:@"btn_plus_able"] forState:UIControlStateNormal];
                [upButton addTarget:self action:@selector(upBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:upButton];
                
                
            }else// 第一组的第三行
            {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                 cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.2*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.alpha = lableAlpha;
                theLable.text = @"总价：";
                [cell.contentView addSubview:theLable];
                // 显示总价
                
                theDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.06*theWidth, 0.15*theWidth, 0.04*theWidth)];
                theDetailLable.textAlignment = NSTextAlignmentRight;
                theDetailLable.font = [UIFont systemFontOfSize:14];
                theDetailLable.textColor = [UIColor orangeColor];
                theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*(_cinemaModel.cinemaLowPrice ?_cinemaModel.cinemaLowPrice :_model.price)];
           
                [cell.contentView addSubview:theDetailLable];
                
            }
        }else if (indexPath.section == 1)// 第二组
        {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.35*theWidth, 0.04*theWidth)];
            theLable.font = [UIFont systemFontOfSize:14];
            theLable.alpha = lableAlpha;
            theLable.text = @"您绑定的手机号：";
            [cell.contentView addSubview:theLable];
            // 手机号码
            UILabel *phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(0.57*theWidth, 0.06*theWidth, 0.35*theWidth, 0.04*theWidth)];
            phoneLable.font = [UIFont systemFontOfSize:13];
            phoneLable.textAlignment = NSTextAlignmentRight;
            phoneLable.alpha = lableAlpha;
            phoneLable.text = [_userModel.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
;
            [cell.contentView addSubview:phoneLable];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             //cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
        }else if (indexPath.section == 2)// 第三组
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.2*theWidth, 0.04*theWidth)];
            theLable.font = [UIFont systemFontOfSize:14];
            theLable.alpha = lableAlpha;
            theLable.text = @"抵用卷：";
            [cell.contentView addSubview:theLable];
            // 抵用卷
            UILabel *juanLable = [[UILabel alloc] initWithFrame:CGRectMake(0.55*theWidth, 0.06*theWidth, 0.35*theWidth, 0.04*theWidth)];
            juanLable.font = [UIFont systemFontOfSize:14];
            juanLable.textAlignment = NSTextAlignmentRight;
            juanLable.alpha = lableAlpha;
            juanLable.text =@"使用抵用卷";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:juanLable];
        }else// 第四组
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            // 支付图标
             NSArray *imageNameArray = @[@"icon_alipay",@"icon_unionpay",@"icon_bank_pay",@"icon_tenpay"];
            UIButton *zhiFuButton = [[UIButton alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.05*theWidth, 0.16*theWidth, 0.1*theWidth)];
            zhiFuButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:240/255.0 alpha:1.0];
            zhiFuButton.layer.cornerRadius = 5;
            
            [zhiFuButton setImage:[UIImage imageNamed:imageNameArray[indexPath.row]]
                                            forState:UIControlStateNormal];
            [cell.contentView addSubview:zhiFuButton];
           // 支付图标的文字说明
            NSArray *textLable = @[@"支付宝支付",@"银联支付",@"银行卡支付",@"财付通支付"];
            UILabel *zhiFuLable = [[UILabel alloc] initWithFrame:CGRectMake(0.22*theWidth, 0.055*theWidth, 0.3*theWidth, 0.04*theWidth)];
            zhiFuLable.font = [UIFont systemFontOfSize:15];
            zhiFuLable.text = textLable[indexPath.row];
            zhiFuLable.alpha= 0.8;
            [cell.contentView addSubview:zhiFuLable];
            //选中按钮
            selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.87*theWidth, 0.07*theWidth, 0.07*theWidth, 0.07*theWidth)];
            selectedBtn.layer.borderWidth = 0.5;
            selectedBtn.alpha = lableAlpha;
            selectedBtn.tag = buttonTag + indexPath.row;
            selectedBtn.layer.cornerRadius = 2;
//            [selectedBtn setBackgroundImage:[UIImage imageNamed:@"btn_radioBox_selected" ] forState:UIControlStateNormal];
            [cell.contentView addSubview:selectedBtn];
        }
    }
    
    
    
    
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 3) {
        return 0.2*theWidth;
    }else
    {
        return 0.16*theWidth;
    }
}
//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.01;
}
//组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    if (section == 3) {
        return 0.01;
        
    }else
    {
       return 0.02*theWidth;
    }
}
//选中单元格事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 3) {
        // 获取前一个选中的cell
        NSIndexPath *theLastPath  = [NSIndexPath indexPathForRow:_num inSection:3];
        //   通过theLastPath 获取  之前点中的单元格cell
        UITableViewCell *theLastCell = [tableView cellForRowAtIndexPath:theLastPath];
        UIButton *selectedButton = (UIButton *) [theLastCell.contentView viewWithTag:1234+_num];
        [selectedButton setImage:[UIImage imageNamed:@"" ]forState:UIControlStateNormal];
        // 获取点中的单元格（cell）
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        _num = indexPath.row;
        UIButton *newselectedButton = (UIButton *) [newCell.contentView viewWithTag:1234+_num];
        [newselectedButton setImage:[UIImage imageNamed:@"btn_radioBox_selected" ]forState:UIControlStateNormal];
        [selectedBtn setTitle:@"已选支付方式" forState:UIControlStateNormal];
    }else if (indexPath.section == 2)// 跳转至使用抵债券
    {
        UserCouponViewController *userCouponViewCtr = [[UserCouponViewController alloc] init];
        [self.navigationController pushViewController:userCouponViewCtr animated:YES];
    }else if (indexPath.section == 1)// 跳转至手机绑定界面
    {
        // 创建视图控制器 push 绑定手机号页面
        BindPhoneNumberViewController *bindPhoneNoViewCtr = [[BindPhoneNumberViewController alloc] init];
        bindPhoneNoViewCtr.userModel = _userModel;
        [self.navigationController pushViewController:bindPhoneNoViewCtr animated:YES];

    }
}
#pragma mark 加减 按钮事件
-(void)downBtnAction:(UIButton *)sender
{
    if (_index > 2) {
        _index = _index -1;
        downButton.enabled =YES;
    }else if(_index == 2)
    {
        _index = _index -1;
        [downButton setImage:[UIImage imageNamed:@"btn_minus_unable"] forState:UIControlStateNormal];
        downButton.enabled = NO;
    }
    numTextField.text = [NSString stringWithFormat:@"%ld",_index];
    theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*(_cinemaModel.cinemaLowPrice ?_cinemaModel.cinemaLowPrice :_model.price)];

    moneyLable.text =theDetailLable.text;
    numLable.text = [NSString stringWithFormat:@"共%ld件",_index];
}
-(void)upBtnAction:(UIButton *)sender
{
    _index = _index+1;
    if (_index > 1) {
          downButton.enabled =YES;
          [downButton setImage:[UIImage imageNamed:@"btn_minus_able"] forState:UIControlStateNormal];
    }
    numTextField.text = [NSString stringWithFormat:@"%ld",_index];
    theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*(_cinemaModel.cinemaLowPrice ?_cinemaModel.cinemaLowPrice :_model.price)];

    moneyLable.text =theDetailLable.text;
    numLable.text = [NSString stringWithFormat:@"共%ld件",_index];
}

#pragma mark  立刻支付按钮事件
-(void)payBtnAction:(UIButton *)sender
{
    if ([selectedBtn.titleLabel.text isEqualToString:@"已选支付方式"]) {
        [self addActView];
        [self performSelector:@selector(goPay) withObject:nil afterDelay:3.0];
    }
    else{
        [self showMessage:@"请选择支付方式"];
    }
 
}
#pragma mark 延迟调用
- (void)goPay{
    
    /** 将用户已选商品记录写入到文件*/
    NSString *filePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@待支付.txt",_userModel.userPhone];
    NSDictionary *tempDic = @{@"待付款订单号":[NSDate date],@"图片名称":_cinemaModel.cinemaImageName ? _cinemaModel.cinemaImageName:_model.imageName,@"商品名":self.thelableText,@"总价":theDetailLable.text,@"数量":[NSNumber numberWithInteger:_index]};
    
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    // 在最后添加数据
    [recordDic setObject:tempDic forKey:self.thelableText];
    //写入文件
    [recordDic writeToFile:filePath atomically:NO];

    PayViewController *payVCtr = [[PayViewController alloc] init];
    payVCtr.foodModel = self.model;
    payVCtr.mModel = _mModel;
    payVCtr.cinemaModel = _cinemaModel;
    payVCtr.number = _index;
    [self.navigationController pushViewController:payVCtr animated:YES];
  
}
#pragma mark 定时器
- (void)stopActView:(NSTimer *)timer{
    
    UIActivityIndicatorView *actView = timer.userInfo;
    if ([actView isAnimating]) {
        
        [actView stopAnimating];
    }
}
#pragma mark 添加菊花
- (void)addActView{
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.backgroundColor = [UIColor grayColor];
    activityView.alpha = 0.5;
    activityView.hidesWhenStopped = YES;
    activityView.frame = CGRectMake(0, 0, theWidth, theHeight);
    [activityView startAnimating];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopActView:) userInfo:activityView repeats:YES];
    [self.view addSubview:activityView];
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
    showview.frame = CGRectMake((theWidth-LabelSize.width-20)/2, theHeight*0.6, LabelSize.width+20, LabelSize.height+10);
    //提示显示停留时间
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
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
