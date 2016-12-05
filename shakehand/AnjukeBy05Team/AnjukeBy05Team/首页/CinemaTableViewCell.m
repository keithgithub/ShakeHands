//
//  CinemaTableViewCell.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _cinemaLb1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, theWidth*0.8, theWidth*0.074)];
        _cinemaLb1.font = [UIFont systemFontOfSize:20];
        
        _cinemaLb2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+theWidth*0.074, theWidth*0.9, theWidth*0.074)];
        _cinemaLb2.font = [UIFont systemFontOfSize:15];
        _cinemaLb2.textColor = [UIColor lightGrayColor];
        
        _cinemaLb3 = [[UILabel alloc] initWithFrame:CGRectMake(20, theWidth*0.195, theWidth*0.03, theWidth*0.056)];
        _cinemaLb3.font = [UIFont systemFontOfSize:15];
        _cinemaLb3.text = @"¥";
        _cinemaLb3.textColor = [UIColor redColor];
        
        _cinemaLb4 = [[UILabel alloc] initWithFrame:CGRectMake(20+theWidth*0.03, theWidth*0.195, theWidth*0.1, theWidth*0.056)];
        _cinemaLb4.font = [UIFont systemFontOfSize:20];
        _cinemaLb4.textColor = [UIColor redColor];
        
        _cinemaLb5 = [[UILabel alloc] initWithFrame:CGRectMake(10+theWidth*0.03+theWidth*0.1, theWidth*0.195, theWidth*0.04, theWidth*0.056)];
        _cinemaLb5.font = [UIFont systemFontOfSize:14];
        _cinemaLb5.text = @"起";
        _cinemaLb5.textColor = [UIColor lightGrayColor];
        
        _cinemaLb6 = [[UILabel alloc] initWithFrame:CGRectMake(30+theWidth*0.03+theWidth*0.1+theWidth*0.04, theWidth*0.195,theWidth*0.418, theWidth*0.056)];
        _cinemaLb6.font = [UIFont systemFontOfSize:14];
        _cinemaLb6.textColor = [UIColor lightGrayColor];
        
        _cinemaLb7 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.65, theWidth*0.18,theWidth*0.2, theWidth*0.056)];
        _cinemaLb7.font = [UIFont systemFontOfSize:14];
        _cinemaLb7.textColor = [UIColor lightGrayColor];
        
        _cinemaLb8 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.6+theWidth*0.2, theWidth*0.18,theWidth*0.14, theWidth*0.056)];
        _cinemaLb8.font = [UIFont systemFontOfSize:15];
        _cinemaLb8.textColor = [UIColor lightGrayColor];
        
        
        
        [self.contentView addSubview:_cinemaLb1];
        [self.contentView addSubview:_cinemaLb2];
        [self.contentView addSubview:_cinemaLb3];
        [self.contentView addSubview:_cinemaLb4];
        [self.contentView addSubview:_cinemaLb5];
        [self.contentView addSubview:_cinemaLb6];
        [self.contentView addSubview:_cinemaLb7];
        [self.contentView addSubview:_cinemaLb8];
        
        
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
