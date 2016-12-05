//
//  YGSpreadView.m
//  FindingSomething
//
//  Created by zhangkaifeng on 16/5/27.
//

#import "YGSpreadView.h"

/**
 *  @param BOTTOM_ARROW_HEIGHT 箭头View的高度
 */
#define BOTTOM_ARROW_HEIGHT 25

@implementation YGSpreadView

- (instancetype)initWithOrigin:(CGPoint)origin inView:(UIView *)inView startHeight:(float)startHeight
{
    self = [super init];
    if (self)
    {
        _origin = origin;
        _startHeight = startHeight;
        _inView = inView;
        self.frame = CGRectMake(_origin.x, _origin.y, inView.frame.size.width, startHeight + BOTTOM_ARROW_HEIGHT);
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    _inView.frame = CGRectMake(0, 0, _inView.frame.size.width, _inView.frame.size.height);
    [self addSubview:_inView];
    
    UIView *bottomBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, _startHeight, self.frame.size.width, BOTTOM_ARROW_HEIGHT)];
    bottomBaseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomBaseView];
    _bottomBaseView = bottomBaseView;

    /**
     小箭头
     */
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    arrowImageView.center = CGPointMake(bottomBaseView.frame.size.width/2, bottomBaseView.frame.size.height/2);
    arrowImageView.image = [UIImage imageNamed:@"xianzhi_down.png"];
    [bottomBaseView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    /**
     *  button
     */
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bottomBaseView.frame.size.width,bottomBaseView.frame.size.height)];
    button.selected = NO;
    [button addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBaseView addSubview:button];
    _arrowButton = button;
}

- (void)arrowClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    //保存上次的高度
    float selfHeight = self.frame.size.height;
    
    if (button.selected)
    {
        //开始扩张
        [UIView animateWithDuration:1.0 // 动画时长
                              delay:0.0 // 动画延迟
             usingSpringWithDamping:0.2 // 类似弹簧振动效果 0~1
              initialSpringVelocity:0 // 初始速度
                            options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                         animations:^{
                             
                             //把frame改成传进inview的高再加上小箭头高度
                             self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _inView.frame.size.width, _inView.frame.size.height + BOTTOM_ARROW_HEIGHT);
                             
                             //小箭头的view也要跟着往下移动
                             _bottomBaseView.frame = CGRectMake(_bottomBaseView.frame.origin.x, _inView.frame.origin.y+_inView.frame.size.height, _bottomBaseView.frame.size.width, _bottomBaseView.frame.size.height);
                             
                             //按钮箭头旋转
                             _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
                             
                             //改变高度代理
                             [_delegate YGSpreadView:self willChangeHeight:self.frame.size.height-selfHeight down:button.selected];
                         } completion:nil];
    }
    else
    {
        //开始收缩
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _inView.frame.size.width, _startHeight + BOTTOM_ARROW_HEIGHT);
            _bottomBaseView.frame = CGRectMake(_bottomBaseView.frame.origin.x, _startHeight, _bottomBaseView.frame.size.width, _bottomBaseView.frame.size.height);
            _arrowImageView.transform = CGAffineTransformMakeRotation(0);
            [_delegate YGSpreadView:self willChangeHeight:self.frame.size.height-selfHeight down:button.selected];
        }];
    }

}

@end
