//
//  CellStyleAddres.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CellStyleAddres.h"

@implementation CellStyleAddres

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 单元格第一个图片
        _theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.04, theWidth*0.05, theWidth*0.04, theWidth*0.05 )];
        [self.contentView addSubview:_theImageView];
        // 黑体显示地址的Label
        _theLabel = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.12, theWidth*0.02, theWidth*0.56,theWidth*0.12)];//theWidth*0.08
        _theLabel.font= [UIFont systemFontOfSize:14];
        _theLabel.numberOfLines = 0;
        [self.contentView addSubview:_theLabel];
        // 最右边的半透明Label
        _theDetailLabel= [[UILabel alloc] initWithFrame:CGRectMake(0.7*theWidth, theWidth*0.06, 0.21*theWidth, theWidth*0.04)];
        _theDetailLabel.alpha = 0.5;
        _theDetailLabel.font =[UIFont systemFontOfSize:14];
        _theDetailLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_theDetailLabel];
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
