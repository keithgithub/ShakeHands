//
//  HotShowingTableViewCell.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotShowingTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *hotImageView;
@property(nonatomic,strong) UILabel *hotLb1;
@property(nonatomic,strong) UILabel *hotLb2;
@property(nonatomic,strong) UILabel *hotLb3;
@property(nonatomic,strong) UILabel *hotLb4;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
