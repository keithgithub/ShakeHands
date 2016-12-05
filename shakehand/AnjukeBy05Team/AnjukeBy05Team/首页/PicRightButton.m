//
//  PicRightButton.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/17.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PicRightButton.h"
#import "UIView+ZRCategory.h"

@implementation PicRightButton

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
//代码
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

//XIB
- (void)awakeFromNib
{
    [self setUp];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    设置图片位置
//    self.imageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor grayColor];
    
    
    //    设置文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = 0; //self.imageView.height;
    self.titleLabel.width = self.width*3/4.0;
    self.titleLabel.height = self.height;//self.height - self.titleLabel.y;
    
    self.imageView.x = self.width*3/4.0;
    self.imageView.y = (self.height-self.height/5)/2;
    self.imageView.width = self.width/5;
    self.imageView.height = self.height/5;
    
    
}
@end
