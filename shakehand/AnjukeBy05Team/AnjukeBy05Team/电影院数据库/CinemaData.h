//
//  CinemaData.h
//  PodTest
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CinemaModel.h"

@interface CinemaData : NSObject


-(void)creatUsersTable:(NSString *)sql;
-(void)insertUsersData:(CinemaModel *)model;
-(NSMutableArray *)selectData;

@end
