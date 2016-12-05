//
//  CellStyleGroup.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CellStyleGroup.h"

@implementation CellStyleGroup

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.04*theWidth, 0.042*theWidth, 0.042*theWidth)];
        [self.contentView addSubview:_theImageView];
        
        _theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.126*theWidth, 0.041*theWidth, 0.56*theWidth, 0.04*theWidth)];
        _theLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_theLable];
        
        _theMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0.126*theWidth, 0.12*theWidth, 0.15*theWidth, 0.04*theWidth)];
        _theMoneyLable.font = [UIFont systemFontOfSize:15];
        _theMoneyLable.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_theMoneyLable];
        
        _theLinyLable = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(0.28*theWidth, 0.125*theWidth, 0.15*theWidth, 0.03*theWidth)];
        _theLinyLable.font = [UIFont systemFontOfSize:12];
        _theLinyLable.alpha = 0.4;
        _theLinyLable.strikeThroughEnabled  = YES;
        [self.contentView addSubview:_theLinyLable];
        
        _theDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0.75*theWidth, theWidth*0.08, 0.15*theWidth, theWidth*0.04)];
        _theDetailLable.font = [UIFont systemFontOfSize:14];
        _theDetailLable.alpha = 0.7;
        //_theDetailLable.StrikeThroughEnabled = YES;
        _theDetailLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_theDetailLable];
        
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
