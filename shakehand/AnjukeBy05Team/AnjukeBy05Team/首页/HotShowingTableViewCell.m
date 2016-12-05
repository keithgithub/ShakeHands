//
//  HotShowingTableViewCell.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "HotShowingTableViewCell.h"

@implementation HotShowingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.046, theWidth*0.052, theWidth*0.19, theWidth*0.264)];
        _hotImageView.backgroundColor = [UIColor orangeColor];
        _hotLb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.27, theWidth*0.052, theWidth*0.6, theWidth*0.075)];
//        _hotLb1.text = @"魔兽";
        _hotLb1.font = [UIFont boldSystemFontOfSize:20];
        
        _hotLb2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.27, theWidth*0.052+theWidth*0.075+5, theWidth*0.66, theWidth*0.075)];
//        _hotLb2.text = @"根据暴雪公司的著名游戏改编";
        _hotLb2.font = [UIFont systemFontOfSize:18];
        _hotLb2.textColor = [UIColor grayColor];
        _hotLb3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.27, theWidth*0.052+theWidth*0.075*2+10, theWidth*0.6, theWidth*0.05)];
//        _hotLb3.text = @"今天7家影院上映100场";
        _hotLb3.font = [UIFont systemFontOfSize:14];
        _hotLb3.textColor = [UIColor lightGrayColor];
        
        _hotLb4 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.9, theWidth*0.061, theWidth*0.15, theWidth*0.05)];
//        _hotLb4.text = @"8.8";
        _hotLb4.textColor = [UIColor orangeColor];
        _hotLb4.font = [UIFont systemFontOfSize:12];
    
        
        [self.contentView addSubview:_hotImageView];
        [self.contentView addSubview:_hotLb1];
        [self.contentView addSubview:_hotLb2];
        [self.contentView addSubview:_hotLb3];
        [self.contentView addSubview:_hotLb4];
        
       
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
