//
//  CinemaData.m
//  PodTest
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CinemaData.h"
#import "FMDatabase.h"
#import <sqlite3.h>

#define sqliteDB @"secondProgress.sqlite"

@implementation CinemaData

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
-(void)insertUsersData:(CinemaModel *)model;
{
    
    FMDatabase *fmDB1 = [[FMDatabase alloc]initWithPath:[self filePath]];
    
    if (![fmDB1 open]) {
        NSLog(@"插入信息时候，文件打开失败!");
        return;
    }
    int result = [fmDB1 executeUpdate:@"INSERT INTO cinemas(cinemaName,cinemaAdress,cinemaLowPrice,cinemaMovieNumb,cinemaSessionNumb,cinemaDistrict,cinemaDistance,cinemaPhone,cinemaImageName)VALUES(?,?,?,?,?,?,?,?,?)",model.cinemaName,model.cinemaAdress,[NSNumber numberWithInteger:model.cinemaLowPrice],[NSNumber numberWithInteger:model.cinemaMovieNumb],[NSNumber numberWithInteger:model.cinemaSessionNumb],model.cinemaDistrict,[NSNumber numberWithFloat:model.cinemaDistance],model.cinemaPhone,model.cinemaImageName];
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
    FMResultSet *re  = [fmDB2 executeQuery:@"SELECT * FROM cinemas"];
    while ([re next])
    {
        NSString  *row0 =  [re stringForColumn:@"cinemaName"];
        NSString  *row1 =  [re stringForColumn:@"cinemaAdress"];
        NSInteger  row2 =  [re intForColumn:@"cinemaLowPrice"];
        NSInteger  row3 =  [re intForColumn:@"cinemaMovieNumb"];
        NSInteger  row4 =  [re intForColumn:@"cinemaSessionNumb"];
        NSString  *row5 =  [re stringForColumn:@"cinemaDistrict"];
        float      row6 =  [re doubleForColumn:@"cinemaDistance"];
        NSString  *row7 =  [re stringForColumn:@"cinemaPhone"];
        NSString  *row8 =  [re stringForColumn:@"cinemaImageName"];
        CinemaModel *model = [[CinemaModel alloc]init];
        model.cinemaName = row0;
        model.cinemaAdress = row1;
        model.cinemaLowPrice = row2;
        model.cinemaMovieNumb = row3;
        model.cinemaSessionNumb = row4;
        model.cinemaDistrict = row5;
        model.cinemaDistance = row6;
        model.cinemaPhone = row7;
        model.cinemaImageName = row8;
        
        [arr addObject:model];
    }
    [re close];
    [fmDB2 close];
    return arr;
}


/**  修改数据库 */
-(void)updateUsersData:(CinemaModel *)model
{
//    FMDatabase *fmDB3 = [[FMDatabase alloc]initWithPath:[self filePath]];
//    if(![fmDB3 open])
//    {
//        NSLog(@"数据不存在");
//    }
//    
//    //        cinemaName
//    //        cinemaAdress
//    //        cinemaLowPrice;
//    //        cinemaMovieNumb;
//    //        cinemaSessionNumb;
//    //        *cinemaDistrict;
//    //        *cinemaDistance;
//    //        *cinemaPhone;
//    //        *cinemaImageName;
//    
//    if( ![fmDB3 executeUpdate:@"UPDATE cinemas SET userName=?,userMoney=?,userPJ=?,userWaitPingJia=?,userWaitPay=?,userHadPay=? WHERE userPhone=? ",model.userName,[NSNumber numberWithFloat:model.userMoney],model.userPJ,model.userWaitPingJia,model.userWaitPay])
//    {
//        printf("用户信息更新失败😢");
//    }
//    [fmDB3 close];
//    
}

@end
