//
//  UserModel.m
//  PodTest
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


-(NSString *)description
{
    return [NSString stringWithFormat:@"%@---%@---%.2f---%@---%@---%@--%@---%@---%@-----%@---%@---%@------%@---",
            _userImageName,_userName,_userMoney,_userPhone,_userLoginPw,_userPayPw,_userSex,_userBirthday,_userAddress,_userPJ,_userHadPay,_userWaitPay,_userWaitPingJia];
}


@end
