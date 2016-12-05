//
//  FilmHeadView.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView1;


@property (weak, nonatomic) IBOutlet UILabel *filmLb1;
@property (weak, nonatomic) IBOutlet UILabel *filmLb2;
@property (weak, nonatomic) IBOutlet UILabel *filmLb3;
@property (weak, nonatomic) IBOutlet UILabel *filmLb4;
@property (weak, nonatomic) IBOutlet UILabel *filmLb5;
@property (weak, nonatomic) IBOutlet UILabel *filmLb6;
-(instancetype)initWithFrame:(CGRect)frame;
@end
