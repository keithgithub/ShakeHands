//
//  YGSpreadView.h
//  FindingSomething
//
//  Created by zhangkaifeng on 16/5/27.
//

#import <UIKit/UIKit.h>

@class YGSpreadView;
@protocol YGSpreadViewDelegate <NSObject>

@optional
/**
 *  当控件高度变化调用此函数
 *
 *  @param spreadView 本控件
 *  @param height     改变的高度（如果是往回收height为负数）
 *  @param down       down为YES为展开，否则为收缩
 */
-(void)YGSpreadView:(YGSpreadView *)spreadView willChangeHeight:(float)height down:(BOOL)down;
@end

@interface YGSpreadView : UIView

@property (nonatomic,strong,readonly) UIView *inView;
@property (nonatomic,assign,readonly) float startHeight;
@property (nonatomic,strong,readonly) UIButton * arrowButton;
@property (nonatomic,strong,readonly) UIImageView *arrowImageView;
@property (nonatomic,strong,readonly) UIView *bottomBaseView;
@property (nonatomic,assign,readonly) CGPoint origin;
@property (nonatomic,assign) id<YGSpreadViewDelegate> delegate;

/**
 *  初始化方法
 *
 *  @param origin      本控件的x，y
 *  @param inView      传进显示在本控件中的位置
 *  @param startHeight 控件起始高度（不包括下面的箭头）
 *
 *  @return 初始化方法
 */
- (instancetype)initWithOrigin:(CGPoint)origin inView:(UIView *)inView startHeight:(float)startHeight;

@end
