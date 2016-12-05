//
//  CinemaModel.h
//  PodTest
//
//  Created by etcxm on 16/6/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaModel : NSObject

//   电影院的各个属性
@property(nonatomic,copy)NSString     *cinemaName;           /** 电影院的名称 */
@property(nonatomic,copy)NSString     *cinemaAdress;         /** 电影院的地址 */
@property(nonatomic,assign)NSInteger   cinemaLowPrice;       /**   价格起价  */
@property(nonatomic,assign)NSInteger   cinemaMovieNumb;      /** 放映电影的部数（几部）*/
@property(nonatomic,assign)NSInteger   cinemaSessionNumb;    /** 放映电影的场次数（共几场）*/
@property(nonatomic,copy)NSString     *cinemaDistrict;       /** 电影院地区 */
@property(nonatomic,assign)float       cinemaDistance;       /** 电影院距离 */
@property(nonatomic,copy)NSString     *cinemaPhone;          /** 电影院号码 */
@property(nonatomic,copy)NSString     *cinemaImageName;      /** 电影院图片名称  */




@end
