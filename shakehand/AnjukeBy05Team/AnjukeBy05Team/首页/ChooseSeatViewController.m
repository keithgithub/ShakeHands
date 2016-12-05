//
//  ChooseSeatViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ChooseSeatViewController.h"

@interface ChooseSeatViewController ()
{
    NSInteger _index; // 购买数量
    UITextField *numTextField;// 显示购买数量
    UIButton *downButton; // 购买数量减一按钮
    UILabel *theDetailLable;// 显示总价
}
@end

@implementation ChooseSeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _index = 1;
    self.title = @"提交订单";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //本视图的属性
//    self.thelableText =self.model.foodName;
//    self.theDetaillableText = [NSString stringWithFormat:@"￥%0.0f",self.model.price];
    
    // 创建表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // 添加单击事件
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [tableView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
#pragma mark backButton 按钮事件
-(void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 表视图的数据源和委托方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 3;
    }else
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
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.05*theWidth, 0.06*theWidth, 0.7*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.text = self.thelableText;
                [cell.contentView addSubview:theLable];
                UILabel *theDetailLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.06*theWidth, 0.12*theWidth, 0.04*theWidth)];
                theDetailLable1.textAlignment = NSTextAlignmentRight;
                theDetailLable1.font = [UIFont systemFontOfSize:14];
                theDetailLable1.alpha = 0.7;
                theDetailLable1.text = self.theDetaillableText;
                [cell.contentView addSubview:theDetailLable1];
            }else if (indexPath.row == 1)// 第一组的第二行
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.2*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.alpha = 0.7;
                theLable.text = @"数量：";
                [cell.contentView addSubview:theLable];
                // 减一按钮
                downButton = [UIButton buttonWithType:UIButtonTypeCustom];
                downButton.frame = CGRectMake(0.6*theWidth, 0.035*theWidth, 0.09*theWidth, 0.09*theWidth);
                downButton.tag = 2001;
                [downButton setImage:[UIImage imageNamed:@"btn_minus_unable"] forState:UIControlStateNormal];
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
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
                UILabel *theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.06*theWidth, 0.2*theWidth, 0.04*theWidth)];
                theLable.font = [UIFont systemFontOfSize:14];
                theLable.alpha = 0.7;
                theLable.text = @"价格：";
                [cell.contentView addSubview:theLable];
                // 显示总价
                theDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.06*theWidth, 0.15*theWidth, 0.04*theWidth)];
                theDetailLable.textAlignment = NSTextAlignmentRight;
                theDetailLable.font = [UIFont systemFontOfSize:14];
                theDetailLable.textColor = [UIColor orangeColor];
//                theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*self.model.price];
                [cell.contentView addSubview:theDetailLable];
                
            }
        }else// 第二组
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;//  单元格选中不变灰
        }
    }
    
    
    
    
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        return 0.16*theWidth;
    }else
    {
        return 0.68*theWidth;
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
    if (section == 0) {
        return 0.02*theWidth;
    }else
    {
        return 0.01;
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
    theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*149];
}
-(void)upBtnAction:(UIButton *)sender
{
    _index = _index+1;
    if (_index > 1) {
        downButton.enabled =YES;
        [downButton setImage:[UIImage imageNamed:@"btn_minus_able"] forState:UIControlStateNormal];
    }
    numTextField.text = [NSString stringWithFormat:@"%ld",_index];
    theDetailLable.text = [NSString stringWithFormat:@"￥%ld",_index*149];
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
