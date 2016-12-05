//
//  CinemaTableViewCell.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CinemaTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *cinemaLb1;
@property(nonatomic,strong) UILabel *cinemaLb2;
@property(nonatomic,strong) UILabel *cinemaLb3;
@property(nonatomic,strong) UILabel *cinemaLb4;
@property(nonatomic,strong) UILabel *cinemaLb5;
@property(nonatomic,strong) UILabel *cinemaLb6;
@property(nonatomic,strong) UILabel *cinemaLb7;
@property(nonatomic,strong) UILabel *cinemaLb8;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
