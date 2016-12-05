//
//  UserData.h
//  PodTest
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "FMDatabase.h"
#import <sqlite3.h>

@interface UserData : NSObject


-(NSString *)filePath;
-(void)creatUsersTable:(NSString *)sql;            /** 创建数据库 */
-(void)insertUsersData:(UserModel *)model;         /**  信息插入到数据库表中 */
-(NSMutableArray *)selectData;                     /** 查询所有信息 */
-(void)updateUsersData:(UserModel *)model;         /**  更新用户数据 */
-(void)deleteUser:(UserModel *)model;              /**  删除用户信息*/
@end
