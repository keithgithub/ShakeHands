//
//  UsersData.m
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "MovieData.h"

#define sqliteDB @"secondProgress.sqlite"

@implementation MovieData


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
-(void)insertUsersData:(movieModel *)model;
{

    FMDatabase *fmDB1 = [[FMDatabase alloc]initWithPath:[self filePath]];
    
    if (![fmDB1 open]) {
        NSLog(@"插入信息时候，文件打开失败!");
        return;
    }
    int result = [fmDB1 executeUpdate:@"INSERT INTO movies(movieName,moviePingfen,moviePingjia,moviePjNum,movieDuration,movieImageName,movieStyle,movieTime,movieIntroduce,movieStagePhotoArr,moviePlayTime,movieArea)VALUES(?,?,?,?,?,?,?,?,?,?,?,?)",model.movieName,[NSNumber numberWithFloat:model.moviePingfen],model.moviePingjia,[NSNumber numberWithInteger:model.moviePjNum],[NSNumber numberWithInteger:model.movieDuration],model.movieImageName,model.movieStyle,model.movieTime,model.movieIntroduce,model.movieStagePhotoArr,[NSNumber numberWithInteger:model.moviePlayTime],model.movieArea];
    if (!result) {
        NSLog(@"信息插入失败!");
        return;
    }
    [fmDB1 close];
    printf("\n自动更新用户数据成功\n");
 
    
}

 /**  查询所有用户信息 */
-(NSMutableArray *)selectData;
{
    FMDatabase *fmDB2  = [[FMDatabase alloc]initWithPath:[self filePath]];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if(![fmDB2 open])
    {
        NSLog(@"数据不存在");
    }
    FMResultSet *re  = [fmDB2 executeQuery:@"SELECT movieName,moviePingfen,moviePingjia,moviePjNum,movieImageName,movieIntroduce,movieStyle,movieTime,movieDuration,movieStagePhotoArr,moviePlayTime,movieArea FROM movies"];
    while ([re next])
    {
     NSString  *row1 = [re stringForColumn:@"movieName"];
     float     row2 =  [re doubleForColumn:@"moviePingfen"];
     NSString *row3 =  [re stringForColumn:@"moviePingjia"];
     NSInteger row4 =  [re intForColumn:@"moviePjNum"];
     NSString *row5 =  [re stringForColumn:@"movieImageName"];
     NSString *row6 =  [re stringForColumn:@"movieIntroduce"];
     NSString *row7 =  [re stringForColumn:@"movieStyle"];
     NSString *row8 =  [re stringForColumn:@"movieTime"];
     NSInteger row9 =  [re intForColumn:@"movieDuration"];
     NSData   *row10 = [re dataForColumn:@"movieStagePhotoArr"];
     NSInteger row11 =  [re intForColumn:@"moviePlayTime"];
     NSString *row12 = [re stringForColumn:@"movieArea"];
     movieModel *model = [[movieModel alloc]init];
     model.movieName = row1;
     model.moviePingfen = row2;
     model.moviePingjia = row3;
     model.moviePjNum = row4;
     model.movieImageName = row5;
     model.movieIntroduce = row6;
     model.movieStyle = row7;
     model.movieTime = row8;
     model.movieDuration = row9;
     model.movieStagePhotoArr = row10;
     model.moviePlayTime = row11;
     model.movieArea = row12;

     [arr addObject:model];
    }
    [re close];
    [fmDB2 close];
    return arr;
}


 /**  修改数据库 */
-(void)updateUsersData:(movieModel *)model
{
    FMDatabase *fmDB3 = [[FMDatabase alloc]initWithPath:[self filePath]];
    if(![fmDB3 open])
    {
        NSLog(@"数据不存在");
    }
    //        model.foodName, model.pingfen,model.pingjia,model.pjNum,model.imageName,model.address,model.style,model.time,model.price,model.pricePurchase,model.sold

    if( ![fmDB3 executeUpdate:@"UPDATE movies SET moviePingfen=?,moviePingjia=?,moviePjNum=? WHERE movieName=? ",[NSNumber numberWithFloat:model.moviePingfen],model.moviePingjia,[NSNumber numberWithInteger:model.moviePjNum],model.movieName])
    {
        printf("用户信息更新失败😢");
    }
    [fmDB3 close];
    
}





@end
