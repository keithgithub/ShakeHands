//
//  LoadingView.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    NSArray *imageArr = @[[UIImage imageNamed:@"load_tip1"],[UIImage imageNamed:@"load_tip2"]];
    
    _remarkMessage.text = @"正在加载中.....";
    
    _loadingImage.animationImages = imageArr;  //  播放图片
    
    _loadingImage.animationDuration = 0.4;
    
    
    [UIView animateWithDuration:2.0 animations:^{
        
        [_loadingImage startAnimating];
    
    } completion:^(BOOL finished) {
    
        if (_haveData) {
            
            [self performSelector:@selector(delayHaveDataMethod) withObject:nil afterDelay:2.0f];
        }
        else{
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];

        }
        
    }];
    [self addSubview:_loadingImage];
}
- (void)delayHaveDataMethod{
    
    [self removeFromSuperview];
  
}
- (void)delayMethod{
    
    [_loadingImage stopAnimating];
    _remarkMessage.text = _remarkLabelStr;
    _loadingImage.hidden = YES;
    _errorImage.hidden = NO;
    _goBtn.hidden = NO;
}





@end
