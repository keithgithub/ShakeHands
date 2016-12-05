//
//  UserQrCodeViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UserQrCodeViewController.h"
#import "UserQrCodeHelpViewController.h"

@interface UserQrCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *theUserQrCodeHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *theUserQrCodeUserNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *theUserQrCodeImageView;




@end

@implementation UserQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // 设置标题
    self.title = @"我的二维码";
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    //设置名字和头像
    _theUserQrCodeUserNameLabel.text = _model.userAdminName;
    _theUserQrCodeUserNameLabel.font = [UIFont systemFontOfSize:20];
    
    _theUserQrCodeHeadImgView.layer.cornerRadius = 43;
    _theUserQrCodeHeadImgView.layer.masksToBounds = YES;
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",_model.userPhone];
    UIImage *tempImage = [UIImage imageWithContentsOfFile:filePath];
    if (  tempImage != nil) {
        _theUserQrCodeHeadImgView.image = tempImage;
    }

    //  通过文字创建 导航栏右按钮RightBarButtonItem
    UIBarButtonItem *rightTextItem = [[UIBarButtonItem alloc] initWithTitle:@"用户帮助" style:UIBarButtonItemStylePlain target:self action:@selector(theHelpAction)];
    rightTextItem.title = @"帮助";
    rightTextItem.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = rightTextItem;
    
    //  隐藏返回按钮文字，只留图标 （此效果作用于：下一级页面）
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];


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

//  右边按钮 帮助 跳转事件
- (void)theHelpAction
{
    [self showMessage:@"用户帮助"];
    
    UserQrCodeHelpViewController *userQrCodeHelpViewCtr = [[UserQrCodeHelpViewController alloc] init];
    [self.navigationController pushViewController:userQrCodeHelpViewCtr animated:YES];
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
