//
//  CLMenuSubView.m
//  CLSortView
//
//  Created by Darren on 16/2/27.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLMenuSubView.h"
#import "CLMainSelectedView.h"

@interface CLMenuSubView()

@property (nonatomic,weak) UIButton *currentSelectedBtn;
@property (nonatomic,weak) UIImageView *currentSelectedImg;

@property (nonatomic,assign,getter=isSelected) BOOL Selected;

@end

@implementation CLMenuSubView

+ (instancetype)show
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CLMenuSubView" owner:nil options:nil] lastObject];
}
- (IBAction)clickSubBtn:(UIButton *)sender {
    

    CLMainSelectedView *clMainView = [CLMainSelectedView show];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selection" object:_titleLable.text];
    [clMainView reloadCell:_titleLable.text];;
    

}

- (void)awakeFromNib
{
    [self updateConstraints];
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com