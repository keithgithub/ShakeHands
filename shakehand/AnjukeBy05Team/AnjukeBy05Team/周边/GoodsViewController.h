//
//  GoodsViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foodmodel.h"

@interface GoodsViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) Foodmodel *model;// 定义一个属性，接受上个界面传来的值


@end
