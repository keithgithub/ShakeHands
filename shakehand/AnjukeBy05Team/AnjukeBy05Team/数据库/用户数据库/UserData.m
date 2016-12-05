//
//  UserData.m
//  PodTest
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UserData.h"

#define sqliteDB @"secondProgress.sqlite"

@implementation UserData



-(NSString *)filePath
{
    NSString *s = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",sqliteDB];
    NSLog(@"↑%@",s);
    return s;
    
}
/** 用户创建数据库 用户表 */
-(void)creatUsersTable:(NSString *)sql
{
    
    FMDatabase *fmDB = [[FMDatabase alloc]initWithPath:[self filePath]];
    if(![fmDB open])
    {
        NSLog(@"文件打开失败!");
        return;
    }
    if(! [fmDB executeUpdate:sql])
    {
        NSLog(@"数据库创建失败!");
        return;
    }
    [fmDB close];
    printf("\n创建成功\n");
}

/**  用户注册信息后，要将用户信息插入到数据库表中 */
-(void)insertUsersData:(UserModel *)model;
{
        
        FMDatabase *fmDB1 = [[FMDatabase alloc]initWithPath:[self filePath]];
        
        if (![fmDB1 open]) {
            NSLog(@"插入信息时候，文件打开失败!");
            return;
        }
   int result = [fmDB1 executeUpdate:@"INSERT INTO user(userImageName,userName,userMoney,userPhone,userLoginPw,userPayPw,userSex,userBirthday,userAddress,userPJ,userHadPay,userWaitPay,userWaitPingJia,userAdminName)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.userImageName,model.userName,[NSNumber numberWithFloat:model.userMoney],model.userPhone,model.userLoginPw,model.userPayPw,model.userSex,model.userBirthday,model.userAddress,model.userPJ,model.userHadPay,model.userWaitPay,model.userWaitPingJia,model.userAdminName];
        if (!result) {
            NSLog(@"信息插入失败!");
            return;
        }
        [fmDB1 close];
        printf("\n自动更新用户数据成功\n");

    
    
}

/**  查询所有用户信息 */
-(NSMutableArray *)selectData
{
    FMDatabase *fmDB2  = [[FMDatabase alloc]initWithPath:[self filePath]];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if(![fmDB2 open])
    {
        NSLog(@"数据不存在");
    }
    FMResultSet *re  = [fmDB2 executeQuery:@"SELECT userImageName,userName,userMoney,userPhone,userLoginPw,userPayPw,userSex,userBirthday,userAddress,userPJ,userHadPay,userWaitPay,userWaitPingJia,userAdminName FROM user"];
    while ([re next])
    {
        NSData  *row0     =  [re dataForColumn:@"userImageName"];
        NSString  *row1     =  [re stringForColumn:@"userName"];
        float     row2      =  [re doubleForColumn:@"userMoney"];
        NSString *row3      =  [re stringForColumn:@"userPhone"];
        NSString *row4      =  [re stringForColumn:@"userLoginPw"];
        NSString *row5      =  [re stringForColumn:@"userPayPw"];
        NSString *row6      =  [re stringForColumn:@"userSex"];
        NSString *row7      =  [re stringForColumn:@"userBirthday"];
        NSData *row8      =  [re dataForColumn:@"userAddress"];
        NSData *row9  =  [re dataForColumn:@"userPJ"];
        NSData *row10 =  [re dataForColumn:@"userHadPay"];
        NSData *row11 =  [re dataForColumn:@"userWaitPay"];
        NSData *row12 =  [re dataForColumn:@"userWaitPingJia"];
        NSString *row13 =  [re stringForColumn:@"userAdminName"];
        UserModel *model = [[UserModel alloc]init];
        model.userImageName = row0;
        model.userName = row1;
        model.userMoney = row2;
        model.userPhone = row3;
        model.userLoginPw = row4;
        model.userPayPw = row5;
        model.userSex = row6;
        model.userBirthday = row7;
        model.userAddress = row8;
        model.userPJ = row9;
        model.userHadPay = row10;
        model.userWaitPay = row11;
        model.userWaitPingJia = row12;
        model.userAdminName = row13;
        
        [arr addObject:model];
    }
    [re close];
    [fmDB2 close];
    return arr;
}


/**  修改数据库 */
-(void)updateUsersData:(UserModel *)model
{
    FMDatabase *fmDB3 = [[FMDatabase alloc]initWithPath:[self filePath]];
    if(![fmDB3 open])
    {
        NSLog(@"数据不存在");
    }
    if( ![fmDB3 executeUpdate:@"UPDATE user SET userName=?,userImageName=?,userMoney=?,userLoginPw=?,userPayPw=?,userBirthday=?,userPJ=?,userAddress=?,userWaitPingJia=?,userWaitPay=?,userHadPay=?,userSex=?,userAdminName=? WHERE userPhone=? ",model.userName,model.userImageName,[NSNumber numberWithFloat:model.userMoney],model
          .userLoginPw,model.userPayPw,model.userBirthday,model.userPJ,model.userAddress,model.userWaitPingJia,model.userWaitPay,model.userHadPay,model.userSex,model.userAdminName,model.userPhone])
    {
        printf("用户信息更新失败😢");
    }
    [fmDB3 close];
    
}

/**删除用户信息*/
-(void)deleteUser:(UserModel *)model;
{
    FMDatabase *fmDB = [[FMDatabase alloc]initWithPath:[self filePath]];
    if(![fmDB open])
    {
        NSLog(@"用户不存在");
    }
    if( ![fmDB executeUpdate:@"DELETE FROM user where userPhone =?",model.userPhone])
    {
        printf("用户信息删除失败😢");
    }
    else
    {
        printf("用户信息删除成功😄");
    }
    [fmDB close];
    
}




@end
