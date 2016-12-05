//
//  CellStyleIMG.m
//  项目二——周边
//
//  Created by etcxm on 16/6/7.
//  Copyright © 2016年 CellStyleDemo. All rights reserved.
//

#import "CellStyleIMG.h"
//#define theScreenWidth [UIScreen mainScreen].bounds.size.width
//#define theScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation CellStyleIMG

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

      
        //单元格第一个大图片的视图
        _theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.05,theHeight*0.15 *0.12, theWidth*0.20, theWidth*0.20)];
        [self.contentView addSubview:_theImageView];
        
        // "团" 视图
        _theGrupImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(theWidth*0.3,  CGRectGetMinY(_theImageView.frame), CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theGrupImageView];
        
       //  黑体粗写的 Label
        _theLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.37*theWidth, CGRectGetMinY(_theImageView.frame), theWidth*0.4 , CGRectGetHeight(_theImageView.frame)*0.2)];
        _theLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_theLabel];
        
        // 五星评价的第一课星 视图
        _theStartImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.3, CGRectGetMaxY(_theGrupImageView.frame)+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theStartImageView1];
        
        // 五星评价的第二课星 视图
        _theStartImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.35, CGRectGetMaxY(_theGrupImageView.frame)+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theStartImageView2];
        
        // 五星评价的第三课星 视图
        _theStartImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.4, CGRectGetMaxY(_theGrupImageView.frame)+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theStartImageView3];
        
        // 五星评价的第四课星 视图
        _theStartImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.45, CGRectGetMaxY(_theGrupImageView.frame)+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theStartImageView4];
        
        // 五星评价的第五课星 视图
        _theStartImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(theWidth*0.5, CGRectGetMaxY(_theGrupImageView.frame)+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetHeight(_theImageView.frame)*0.2)];
        [self.contentView addSubview:_theStartImageView5];
        
        //  星评右方的 细体detailLab1
        _detailLab1 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.54+CGRectGetHeight(_theImageView.frame)*0.2, CGRectGetMinY(_theStartImageView1.frame), theWidth*0.3, CGRectGetHeight(_theImageView.frame)*0.2)];
        _detailLab1.alpha = 0.6;
        _detailLab1.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_detailLab1];
        
        //  星评下方的 细体detailLab2
        _datailLab2 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.3, CGRectGetMaxY(_theStartImageView1.frame) +CGRectGetHeight(_theImageView.frame)*0.2, theWidth*0.3, CGRectGetHeight(_theImageView.frame)*0.2)];
        _datailLab2.font = [UIFont systemFontOfSize:14.0];
        _datailLab2.alpha = 0.6;
        [self.contentView addSubview:_datailLab2];
        
        // 细体detailLab1  右边的细体datailLab3
        _datailLab3 = [[UILabel alloc] initWithFrame:CGRectMake(theWidth*0.57, CGRectGetMinY(_datailLab2.frame), theWidth*0.4, CGRectGetHeight(_theImageView.frame)*0.2)];
        _datailLab3.font = [UIFont systemFontOfSize:14.0];
        _datailLab3.alpha = 0.6;
        _datailLab3.lineBreakMode = NSLineBreakByTruncatingMiddle;
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
