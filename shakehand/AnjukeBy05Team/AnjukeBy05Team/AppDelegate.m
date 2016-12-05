//
//  AppDelegate.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/6.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SurroundViewController.h"
#import "MyViewController.h"
#import "MoreViewController.h"
#import "CreatSqlData.h"
#import "LeadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:3.0];
    
    [SMSSDK registerApp:@"1425999258b54" withSecret:@"222f26b293ec742d4c8895ef75d28458"];
    
    NSString *s = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSLog(@"↑%@",s);
    NSUserDefaults *userDefau = [NSUserDefaults standardUserDefaults];
    if (![userDefau objectForKey:@"haveAddData"]) {
        CreatSqlData *creatData = [[CreatSqlData alloc]init];
        [creatData creatSqlData];
    }
    
    
    //      UINavigationController *myNavigaCtr = [[UINavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]];
    //
    //      self.window.rootViewController = myNavigaCtr;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"NoLead" object:nil];
    //    轻量级的文件保存
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    获取轻量级文件的值 （通过key获取）
    
    BOOL isNotFirstTime = [userDefault objectForKey:@"ThisNotFirstTime"];
    if (isNotFirstTime) {
        //     分栏  四个界面
        
        [self creatTabBarArray];
        UITabBarController *tabBarCtr = [[UITabBarController alloc]init];
        [tabBarCtr setViewControllers:[self creatTabBarArray]];
        tabBarCtr.tabBar.tintColor = [UIColor redColor];
        tabBarCtr.tabBar.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = tabBarCtr;
        
    }else{
        
        self.window.rootViewController = [[LeadViewController alloc] init];
    }
    
    
    return YES;
}

-(void)notificationAction:(NSNotification *)notifiction
{
    [self creatTabBarArray];
    UITabBarController *tabBarCtr = [[UITabBarController alloc]init];
    [tabBarCtr setViewControllers:[self creatTabBarArray]];
    tabBarCtr.tabBar.tintColor = [UIColor redColor];
    tabBarCtr.tabBar.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarCtr;
    self.window.backgroundColor = [UIColor whiteColor];
}

/*
 *
    分栏控制器
 */
- (NSArray *)creatTabBarArray
{
    UINavigationController *homeNavigaCtr = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    homeNavigaCtr.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"nav_home_ico2@2x"] selectedImage:nil];
    
    UINavigationController *surrondNavigaCtr = [[UINavigationController alloc]initWithRootViewController:[[SurroundViewController alloc]init]];
    
    surrondNavigaCtr.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"周边" image:[UIImage imageNamed:@"nav_local_ico2@2x"] selectedImage:nil];

    UINavigationController *myNavigaCtr = [[UINavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]];
    myNavigaCtr.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"nav_my_ico2@2x"] selectedImage:nil];
    
    UINavigationController *moreNavigaCtr = [[UINavigationController alloc]initWithRootViewController:[[MoreViewController alloc]init]];
    moreNavigaCtr.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"nav_more_ico2@2x"] selectedImage:nil];
  
    
    return @[homeNavigaCtr,surrondNavigaCtr,myNavigaCtr,moreNavigaCtr];
 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 
}

@end
