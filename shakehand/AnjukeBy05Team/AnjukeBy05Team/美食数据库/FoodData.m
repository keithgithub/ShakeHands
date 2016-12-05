//
//  UsersData.m
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "FoodData.h"

#define sqliteDB @"secondProgress.sqlite"

@implementation FoodData


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
-(void)insertUsersData:(Foodmodel *)model;
{


        FMDatabase *fmDB1 = [[FMDatabase alloc]initWithPath:[self filePath]];
        
        if (![fmDB1 open]) {
            NSLog(@"插入信息时候，文件打开失败!");
            return;
        }
        int result = [fmDB1 executeUpdate:@"INSERT INTO foods(foodName,pingfen,pingjia,pjNum,imageName,address,style,time,price,pricePurchase,sold)VALUES(?,?,?,?,?,?,?,?,?,?,?)",model.foodName,[NSNumber numberWithFloat:model.pingfen],model.pingjia,[NSNumber numberWithInteger:model.pjNum],model.imageName,model.address,model.style,model.time,[NSNumber numberWithInteger:model.price],model.pricePurchase,[NSNumber numberWithInteger:model.sold]];
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
    FMResultSet *re  = [fmDB2 executeQuery:@"SELECT foodName,pingfen,pingjia,pjNum,imageName,address,style,time,price,pricePurchase,sold FROM foods"];
    while ([re next])
    {
     NSString  *row1 = [re stringForColumn:@"foodName"];
     float     row2 =  [re doubleForColumn:@"pingfen"];
     NSString *row3 =  [re stringForColumn:@"pingjia"];
     NSInteger row4 =  [re intForColumn:@"pjNum"];
     NSString *row5 =  [re stringForColumn:@"imageName"];
     NSString *row6 = [re stringForColumn:@"address"];
     NSString *row7 =  [re stringForColumn:@"style"];
     NSString *row8 =  [re stringForColumn:@"time"];
     NSInteger row9 =  [re intForColumn:@"price"];
     NSString *row10 =  [re stringForColumn:@"pricePurchase"];
     NSInteger row11 =  [re intForColumn:@"sold"];
     Foodmodel *model = [[Foodmodel alloc]init];
     model.foodName = row1;
     model.pingfen = row2;
     model.pingjia = row3;
     model.pjNum = row4;
     model.imageName = row5;
     model.address = row6;
     model.style = row7;
     model.time = row8;
     model.price = row9;
     model.pricePurchase = row10;
     model.sold = row11;
        
     [arr addObject:model];
    }
    [re close];
    [fmDB2 close];
    return arr;
}


 /**  修改数据库 */
-(void)updateUsersData:(Foodmodel *)model
{
    FMDatabase *fmDB3 = [[FMDatabase alloc]initWithPath:[self filePath]];
    if(![fmDB3 open])
    {
        NSLog(@"数据不存在");
    }
    //        model.foodName, model.pingfen,model.pingjia,model.pjNum,model.imageName,model.address,model.style,model.time,model.price,model.pricePurchase,model.sold

    if( ![fmDB3 executeUpdate:@"UPDATE foods SET pingfen=?,pingjia=?,pjNum=? WHERE foodName=? ",[NSNumber numberWithFloat:model.pingfen],model.pingjia,[NSNumber numberWithInteger:model.pjNum],model.foodName])
    {
        printf("用户信息更新失败😢");
    }
    [fmDB3 close];
    
}





@end
