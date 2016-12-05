//
//  CLMainSelectedView.h
//  CLSortView
//
//  Created by Darren on 16/2/27.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMainSelectedView : UIView

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

/**左边菜单内button的高度*/
@property (nonatomic,assign) NSInteger leftMenuSubViewHeight;
/**中间菜单内button的高度*/
@property (nonatomic,assign) NSInteger middleMenuSubViewHeight;
/**右边菜单内button的高度*/
@property (nonatomic,assign) NSInteger rightMenuSubViewHeight;

/**左边菜单内容*/
@property (nonatomic,strong) NSArray *leftMenuArrray;
/**中间菜单内容*/
@property (nonatomic,strong) NSArray *middleMenuArray;
/**右边菜单内容*/
@property (nonatomic,strong) NSArray *rightMenuArray;

/** 显示window的位置*/
@property (nonatomic,assign) CGRect  viewFrame;

+ (instancetype)show;

- (void)reloadCell:(NSString *)stringName;


- (void)removeMenu;
    

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com