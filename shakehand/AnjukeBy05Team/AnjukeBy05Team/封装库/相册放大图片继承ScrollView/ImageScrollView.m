//
//  ImageScrollView.m
//  大的ScrollView包含小的scrollView
//
//  Created by etcxm on 16/5/26.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 0.8;
        _iamgeView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_iamgeView];
     }
    return self;
}


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
{
    return _iamgeView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2); // called before the scroll view begins zooming its content
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
