//
//  PayDetialViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foodmodel.h"
#import "movieModel.h"
#import "CinemaModel.h"

@interface PayDetialViewController : UIViewController


@property(nonatomic, strong) Foodmodel       *foodModel;
@property(nonatomic, strong) movieModel      *mModel;
@property(nonatomic, strong) CinemaModel     *cinemaModel;
@property(nonatomic, assign) NSInteger       number;

@end
