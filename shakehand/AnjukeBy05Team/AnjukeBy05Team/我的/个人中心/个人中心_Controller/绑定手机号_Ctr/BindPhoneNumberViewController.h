//
//  BindPhoneNumberViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindPhoneNumberViewController : UIViewController

@property (nonatomic, strong)UserModel *userModel;

- (void)changeIsCanClickButton:(UIButton *)button andButtonEnabled:(BOOL)isEnable andButtonColor:(UIColor *)color andButtonAlpha:(CGFloat)alpha;

@end
