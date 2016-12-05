//
//  XuanzuoTableViewCell.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "XuanzuoTableViewCell.h"

@implementation XuanzuoTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        选座图片
        _xuanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.76, theWidth*0.056, theWidth*0.165, theWidth*0.088)];
        _xuanImageView.image = [UIImage imageNamed:@"movie_xuanzuo"];
        
        //        开始时间
        _xuanLb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.093,  theWidth*0.056, theWidth*0.139, theWidth*0.056)];
        _xuanLb1.text = @"17.30";
        _xuanLb1.font = [UIFont systemFontOfSize:18];
        //        结束时间
        _xuanLb2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.08,  theWidth*0.056+theWidth*0.056, theWidth*0.2, theWidth*0.05)];
        _xuanLb2.text = @"19.33结束";
        _xuanLb2.font = [UIFont systemFontOfSize:14];
        
        //        原版3D
        _xuanLb3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.297,  theWidth*0.056, theWidth*0.204, theWidth*0.056)];
        _xuanLb3.text = @"原版3D";
        _xuanLb3.font = [UIFont systemFontOfSize:18];

        
        //        影厅
        _xuanLb4 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.267,  theWidth*0.056+theWidth*0.056, theWidth*0.3, theWidth*0.05)];
        _xuanLb4.text = @"1号奥格瑞玛厅";
        _xuanLb4.font = [UIFont systemFontOfSize:14];
        
        //        折后价
        _xuanLb5 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.57,  theWidth*0.056, theWidth*0.15, theWidth*0.056)];
        _xuanLb5.text = @"¥48";
        _xuanLb5.font = [UIFont boldSystemFontOfSize:18];
        _xuanLb5.textColor = [UIColor redColor];
        
        //       影院价
        _xuanLb6 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.267+theWidth*0.25,  theWidth*0.056+theWidth*0.056, theWidth*0.3, theWidth*0.056)];
        _xuanLb6.text = @"影院价 90.00";
        _xuanLb6.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_xuanImageView];
        [self.contentView addSubview:_xuanLb1];
        [self.contentView addSubview:_xuanLb2];
        [self.contentView addSubview:_xuanLb3];
        [self.contentView addSubview:_xuanLb4];
        [self.contentView addSubview:_xuanLb5];
        [self.contentView addSubview:_xuanLb6];
//        [self.contentView addSubview:_likeLb7];
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
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
