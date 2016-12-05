//
//  FilmHeadView.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "FilmHeadView.h"



@implementation FilmHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self ) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"FilmHeadView" owner:self options:nil] lastObject];
       
        
    }
    return self;
}


- (void)awakeFromNib
{
    self.autoresizingMask  = UIViewAutoresizingNone;
}


@end
