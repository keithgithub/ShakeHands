//
//  PersonalCenterViewController.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic, strong) UserModel *userModel;

@end
