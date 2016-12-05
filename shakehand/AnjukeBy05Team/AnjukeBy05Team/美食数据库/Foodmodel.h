//
//  Usersmodel.h
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foodmodel : NSObject

//    食品类的各个属性
@property(nonatomic,copy)NSString    *foodName;         /** 商品名称 */
@property(nonatomic,assign)float       pingfen;         /** 商品评分 */
@property(nonatomic,copy)NSString    *pingjia;          /** 评价 */
@property(nonatomic,assign)NSInteger   pjNum;           /** 评价人数 */
@property(nonatomic,copy)NSString    *imageName;        /** 图片名称 */
@property(nonatomic,assign)NSInteger sold;              /** 已售 */
@property(nonatomic,copy)NSString    *address;          /** 地址 */
@property(nonatomic,copy)NSString    *style;            /** 类型 */
@property(nonatomic,copy)NSString    *time;             /** 营业时间 */
@property(nonatomic,assign)NSInteger price;             /** 价格 */
@property(nonatomic,copy)NSString    *pricePurchase;    /** 团购类型 */




@end
