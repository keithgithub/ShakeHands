//
//  CellStyleTime.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CellStyleTime.h"

@implementation CellStyleTime
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.04*theWidth, 0.042*theWidth, 0.036*theWidth, 0.036*theWidth)];
        [self.contentView addSubview:_theImageView];
        
        _theLable = [[UILabel alloc] initWithFrame:CGRectMake(0.12*theWidth, 0.042*theWidth, 0.45*theWidth, 0.036*theWidth)];
        _theLable.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_theLable];
        
        _theView = [[UIView alloc] initWithFrame:CGRectMake(0.74*theWidth, 0.03*theWidth, 1, 0.06*theWidth)];
        _theView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_theView];
        
        _theTelImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.8*theWidth, 0.03*theWidth, 0.06*theWidth, 0.06*theWidth)];
        [self.contentView addSubview:_theTelImage];
        
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
