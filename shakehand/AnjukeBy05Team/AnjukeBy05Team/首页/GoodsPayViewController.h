//
//  GoodsPayViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/16.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foodmodel.h"
#import "movieModel.h"
#import "CinemaModel.h"

@interface GoodsPayViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>
{
    
}
@property(nonatomic,strong)NSString *thelableText;
@property(nonatomic,strong)NSString *theDetaillableText;
@property(nonatomic,assign)NSInteger numb;
@property(nonatomic,assign)BOOL isLoad;
@property(nonatomic,strong) Foodmodel *model;// 定义一个属性，接受上个界面传来的值
@property(nonatomic,strong) movieModel *mModel;
@property(nonatomic,strong) CinemaModel *cinemaModel;
@end
