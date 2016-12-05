//
//  CellStyleNoIMG.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/8.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CellStyleNoIMG.h"
#define theScreenWidth [UIScreen mainScreen].bounds.size.width
#define theScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation CellStyleNoIMG



-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 粗体价格 Label
        _theLabel = [[UILabel alloc] initWithFrame:CGRectMake(theScreenWidth*0.08, theScreenWidth*0.16*0.25, theScreenWidth*0.2, theScreenWidth*0.117*0.2)];
        _theLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _theLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_theLabel];
        
        // 粗体价格 下边 划线细体 detailLabel1
        _detailLab1 = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(theScreenWidth*0.085, theScreenWidth*0.16*0.6, theScreenWidth*0.14, theScreenWidth*0.117*0.2)];
        _detailLab1.alpha = 0.6;
        _detailLab1.font = [UIFont systemFontOfSize:14.0];
        _detailLab1.textAlignment = NSTextAlignmentCenter;
        _detailLab1.strikeThroughEnabled = YES;
        [self.contentView addSubview:_detailLab1];
        
        // 粗体价格 右边的 datailLab2
        _datailLab2 = [[UILabel alloc] initWithFrame:CGRectMake(theScreenWidth*0.3, theScreenWidth*0.16*0.25, theScreenWidth*0.7, theScreenWidth*0.117*0.2)];
        _datailLab2.alpha = 0.7;
        _datailLab2.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_datailLab2];
        
        // 单元格右下角“已售” datailLab3
        _datailLab3 = [[UILabel alloc] initWithFrame:CGRectMake(theScreenWidth*0.6, theScreenWidth*0.16*0.6, theScreenWidth*0.35, theScreenWidth*0.117*0.2)];
        _datailLab3.alpha = 0.6;
        _datailLab3.font = [UIFont systemFontOfSize:14.0];
        _datailLab3.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_datailLab3];
        
        
        
        
        
        
        
        
        
        
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
