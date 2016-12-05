//
//  CinemaDetailViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"

@interface CinemaDetailViewController : UIViewController

@property(nonatomic,strong) UITableView *theTableView;
@property(nonatomic,strong) CinemaModel *cinemaModel;
@end
