//
//  XuanzuoTableViewCell.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuanzuoTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *xuanImageView;//选座图片
@property(nonatomic,strong) UILabel *xuanLb1;//开始时间
@property(nonatomic,strong) UILabel *xuanLb2;//结束时间
@property(nonatomic,strong) UILabel *xuanLb3;//原版3D
@property(nonatomic,strong) UILabel *xuanLb4;//影厅
@property(nonatomic,strong) UILabel *xuanLb5;//折后价
@property(nonatomic,strong) UILabel *xuanLb6;//原价

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
