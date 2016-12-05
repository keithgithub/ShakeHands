//
//  YouLikeTableViewCell.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouLikeTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *likeImageView;//图片
@property(nonatomic,strong) UILabel *likeLb1;//店面
@property(nonatomic,strong) UILabel *likeLb2;//地址详情，简介
@property(nonatomic,strong) UILabel *likeLb3;//¥符号
@property(nonatomic,strong) UILabel *likeLb4;//活动价格
@property(nonatomic,strong) UILabel *likeLb5;//原价
@property(nonatomic,strong) UILabel *likeLb6;//距离
@property(nonatomic,strong) UILabel *likeLb7;//已售
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
