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
#import "movieModel.h"

@interface MovieData : NSObject

-(NSString *)filePath;
-(void)creatUsersTable:(NSString *)sql;             /** 创建数据库 */
-(void)insertUsersData:(movieModel *)model;         /**  信息插入到数据库表中 */
-(NSMutableArray *)selectData;                      /** 查询所有信息 */
-(void)updateUsersData:(movieModel *)model;         /**  更新数据 */

@end
