//
//  ChangeLoginPasswordViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/15.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeLoginPasswordViewController : UIViewController


@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic,copy) NSString *userLoginPwd;

@end
