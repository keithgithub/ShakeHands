//
//  YouLikeTableViewCell.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "YouLikeTableViewCell.h"

@implementation YouLikeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        图片
        _likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, theWidth/3, theWidth/3-20)];
        _likeImageView.backgroundColor = [UIColor brownColor];
        
//        店名lb
        _likeLb1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3+20, 10, theWidth*0.525, theWidth*0.065)];
//        _likeLb1.text = @"瑞祥方志酒店（大玩家7D电影）";
        _likeLb1.font = [UIFont fontWithName:@"Copperplate" size:20];
//        简介lb
        _likeLb2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3+20, theWidth*0.065+20, theWidth*0.6, theWidth*0.088)];
        _likeLb2.numberOfLines = 2;
//        _likeLb2.text = @"[思明区]单人烤肉自助，节假日通用,66666666";
        _likeLb2.textColor = [UIColor lightGrayColor];
        _likeLb2.font = [UIFont fontWithName:@"Copperplate" size:16];
        
        _likeLb3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3+20, theWidth*0.21+15, theWidth*0.06, theWidth*0.07-5)];
        _likeLb3.text = @"¥";
        _likeLb3.textColor = [UIColor redColor];
        
        _likeLb4 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3+10+theWidth*0.06, theWidth*0.21+10, theWidth*0.2, theWidth*0.07)];
        _likeLb4.textColor = [UIColor redColor];
        _likeLb4.font = [UIFont boldSystemFontOfSize:18];
        
//        _likeLb4.text = @"19.9";
        
        _likeLb5 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth/3+theWidth*0.06+theWidth*0.15, theWidth*0.21+15, theWidth*0.15,  theWidth*0.07-5)];
        _likeLb5.font = [UIFont systemFontOfSize:14];
        _likeLb5.textColor = [UIColor lightGrayColor];
        
        _likeLb6 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth-theWidth*0.1-15, 15, theWidth*0.16, theWidth*0.065-5)];
        NSInteger dis = arc4random_uniform(5)+1;
        float distance = (float)((rand()%10)*0.1f+dis);
        _likeLb6.text = [NSString stringWithFormat:@"%.1f km",distance];
        _likeLb6.font = [UIFont systemFontOfSize:15];
        _likeLb6.textColor = [UIColor lightGrayColor];
        
        _likeLb7 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth-theWidth*0.16-15, theWidth*0.21+15, theWidth*0.16, theWidth*0.07)];
//        _likeLb7.text = @"已售236";
        _likeLb7.textColor = [UIColor lightGrayColor];
        _likeLb7.font = [UIFont systemFontOfSize:14];
        
        
        [self.contentView addSubview:_likeImageView];
        [self.contentView addSubview:_likeLb1];
        [self.contentView addSubview:_likeLb2];
        [self.contentView addSubview:_likeLb3];
        [self.contentView addSubview:_likeLb4];
        [self.contentView addSubview:_likeLb5];
        [self.contentView addSubview:_likeLb6];
        [self.contentView addSubview:_likeLb7];

        
        
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
