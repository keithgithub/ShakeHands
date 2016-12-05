//
//  LoadingView.h
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LoadingView : UIView

@property(nonatomic, strong) NSString  *remarkLabelStr;
@property (nonatomic,assign) BOOL       haveData;

@property (weak, nonatomic) IBOutlet UIImageView *loadingImage;
@property (weak, nonatomic) IBOutlet UILabel *remarkMessage;
@property (weak, nonatomic) IBOutlet UIImageView *errorImage;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@end
