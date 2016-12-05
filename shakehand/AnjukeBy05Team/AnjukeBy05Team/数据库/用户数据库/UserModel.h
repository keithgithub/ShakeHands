//
//  UserModel.h
//  PodTest
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//    用户的各个属性
@property(nonatomic,copy)NSString        *userName;          /** 用户昵称 */
@property(nonatomic,copy)NSData          *userImageName;     /** 用户头像名称 */
@property(nonatomic,copy)NSString        *userPhone;         /** 用户手机*/
@property(nonatomic,copy)NSString        *userLoginPw;       /** 用户登录密码 */
@property(nonatomic,copy)NSString        *userPayPw;         /** 用户支付密码 */
@property(nonatomic,assign)float         userMoney;          /** 用户余额 */
@property(nonatomic,copy)NSString        *userSex;           /** 用户性别 */
@property(nonatomic,copy)NSString        *userBirthday;      /** 用户生日 */
@property(nonatomic,copy)NSData          *userAddress;       /** 用户收货地址 */
@property(nonatomic,copy)NSData          *userPJ;            /** 用户评价 */
@property(nonatomic,copy)NSData          *userHadPay;        /** 用户已付款 */
@property(nonatomic,copy)NSData          *userWaitPay;       /** 用户待付款 */
@property(nonatomic,copy)NSData          *userWaitPingJia;   /** 用户待评价 */
@property(nonatomic,copy)NSString        *userAdminName;     /** 用户名称  */

@end
