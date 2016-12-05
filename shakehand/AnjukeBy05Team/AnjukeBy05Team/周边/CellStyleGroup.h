//
//  CellStyleGroup.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"

@interface CellStyleGroup : UITableViewCell
@property(nonatomic,strong) UIImageView *theImageView;
@property(nonatomic,strong) UILabel *theLable;
@property(nonatomic,strong) UILabel *theMoneyLable;
@property(nonatomic,strong) StrikeThroughLabel *theLinyLable;
@property(nonatomic,strong) UILabel *theDetailLable;

@end
