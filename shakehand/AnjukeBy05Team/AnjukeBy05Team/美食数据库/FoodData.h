//
//  UsersData.h
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import <sqlite3.h>
#import "Foodmodel.h"
@interface FoodData : NSObject

-(NSString *)filePath;
-(void)creatUsersTable:(NSString *)sql;             /** 创建数据库 */
-(void)insertUsersData:(Foodmodel *)model;         /**  信息插入到数据库表中 */
-(NSMutableArray *)selectData;                      /** 查询所有信息 */
-(void)updateUsersData:(Foodmodel *)model;         /**  更新用户数据 */

@end
