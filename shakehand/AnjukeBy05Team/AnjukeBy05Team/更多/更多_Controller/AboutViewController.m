//
//  AboutViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/7.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UIScrollViewDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];//返回按钮颜色
    self.tabBarController.tabBar.hidden = YES;//隐藏底部分栏
    
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    // 滚动视图背景颜色
    scrollView.backgroundColor = [UIColor whiteColor];
    // 是否支持滑动最顶端
    scrollView.scrollsToTop = YES;
    // 滚动视图的代理对象为scrollView本身
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(theWidth, theHeight*2+theHeight*0.42);
    // 是否反弹
    scrollView.bounces = YES;
    // 是否分页
    //    scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    //    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //  scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //  scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    // 提示用户,Indicators flash
    //  [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    // scrollView.directionalLockEnabled = YES;
    
    [self.view addSubview:scrollView];
    
    //创建字符串
    NSString *textStr =@"拉手网客户端由拉手无线团队精心打造，具有完整的浏览、支付、消费等功能，每天推出多单精品消费，包括餐厅、酒吧、KTV、SPA、美发、瑜伽等精选特色商家和商品，凑够最低团购人数即可享有至尊无敌折扣！更有客户端独家优惠，现金抵用券免费送！记得邀请好友一同参加哦！ 优雅即态度，拉手最生活，更多精彩功能将在拉手客户端陆续推出，期待与你的每一次“拉手”…                                                                                                          关于账户                                                                                                                     Q.注册方式                                                                                                                              只需手机号即可完成注册，注册手机号是您找回拉手网账号的唯一凭证，请确保其真实性、准确性和安全性；                                                                                                                    Q.登录方式                                                                                                                                              老用户可通过用户名、电子邮箱、手机号、qq、新浪微博、腾讯微博进行登录；                                                        新用户可通过手机号实现免注册快速登录；                                                                                                             Q.忘记用户名和密码怎么办？                                                                                                                                      通过手机号可以实现快速登录或找回密码；                                                                                                 Q.账号被锁定怎么办？                                                                                                         如果您输入密码错误次数达到上限，为了您的账户安全，拉手网将锁定您的账户，待自动解锁后可以进行再次登录，如长时间未自动解锁，请致电拉手网客服；                                                                                                                                                  Q.账户余额为什么没了？                                                                                                                                    如果您在选择订单支付方式时勾选了使用余额，那么确认下单后会首先扣除账户余额，如果该订单最终未继续支付成功，取消订单即可恢复余额；                                                                                                    Q.更换绑定手机号时，原手机号已弃用，接收不到验证码，怎么办？                                                                                 当您的账户有余额时，为了您的账户安全，更换绑定手机号时会要求验证原手机号码，若原手机号码接收不到短信，请致电拉手网客服；                                                                                                                        关于购买                                                                                                            Q.如何购买？                                                                                                                                                     您只需在团购结束之前点击“立即购买”按钮，根据提示下订单支付购买即可；                                                             Q.有哪些支付方式？                                                                                                                              目前客户端支持账户余额、银行卡、信用卡、支付宝、财付通、银联多种支付方式，                                                                                                  您可以选择您习惯的方式进行支付；                                                                                                                    Q.为什么要设置支付密码？                                                                                                                        为了您的账户安全，使用拉手账户余额支付时会要求您输入支付密码；                                                                                                                                                                        关于消费                                                                                                                            Q.什么是拉手券，怎么使用？                                                                                                                              拉手券是团购成功后，系统给您的团购电子消费凭证，上面有唯一的消费码（包括拉手券号和密码），消费时需向商家出示；                                                                                                                     Q.不小心删除了短信拉手券，怎么办？                                                                                                              不用担心！您可以在“我的-拉手券”中随时随地查看，还可以离线查看哦；                                                                                                          Q.去商家消费，有需要注意的吗？                                                                                                                    每个团购信息里都会有针对商家的“温馨提示”，包括营业时间、注意事项、消费有效期等，请注意阅读，这很重要！                                                                                    关于退款                                                                                                                                    Q.什么情况下可以退款？                                                                                                    如下情况下可以退款：                                                                                                                                           因未达到最低团购人数造成当次团购活动被取消；                                                                                          商家“支持随时退”；商家“支持过期退”；                                                                                                    因商家原因导致商家无法向用户提供团购商品/服务，经拉手网核实后属实；                                                              Q.如何退款？                                                                                                                         首先确认已购买团购单是否支持退款，如果支持退款，用户应致电拉手网客服完成退款；如果不支持退款，则无法进行退款；                                                                                                                                                                                     关于合作                                                                                                                                                        Q.我是商家，想在拉手网组织团购，怎么联系？                                                                                      欢迎可提供高品质服务或产品的优质商家成为拉手网特约合作伙伴，如您有意，请用电脑登录拉手网www.lashou.com，页面底部进入“商务合作-团购合作”进行操作；                                                                                                                                          拉手无线大家庭";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 10, -40, theWidth-20, theHeight*2)];
    label.backgroundColor = [UIColor whiteColor];//设置label背景颜色
    label.text = textStr;//将字符串设置给text
    label.textAlignment = NSTextAlignmentJustified;//文字对齐设置
    label.numberOfLines = 0;//无限行数
    label.adjustsFontSizeToFitWidth = YES;//字体适应宽度
    
    [scrollView addSubview:label];//将label添加到滚动视图
    
    //在滚动视图上添加 图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( 10, theHeight*2-60, theWidth-20, theHeight*0.36)];
    [imgView setImage:[UIImage imageNamed:@"lashouwang.jpg"]];//图片视图设置图片内容
    [scrollView addSubview:imgView];//滚动视图上添加 图片
    
    
}

// 将要离开视图的 方法
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;//将要离开视图，显示底部分栏
}


#pragma mark -
/*
 // 返回一个放大或者缩小的视图
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
 
 }
 // 开始放大或者缩小
 - (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:
 (UIView *)view
 {
 
 }
 
 // 缩放结束时
 - (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
 {
 
 }
 
 // 视图已经放大或缩小
 - (void)scrollViewDidZoom:(UIScrollView *)scrollView
 {
 NSLog(@"scrollViewDidScrollToTop");
 }
 */

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
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
