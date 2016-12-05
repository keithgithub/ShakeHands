//
//  Usersmodel.h
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface movieModel : NSObject

//    电影类的各个属性
@property(nonatomic,  copy)  NSString     *movieName;               /** 电影名称 */
@property(nonatomic,assign)  float        moviePingfen;             /** 电影评分 */
@property(nonatomic,  copy)  NSString     *moviePingjia;            /**   评价  */
@property(nonatomic,assign)  NSInteger    moviePjNum;               /** 评价人数 */
@property(nonatomic,assign)  NSInteger    movieDuration;            /** 电影时长 */
@property(nonatomic,  copy)  NSString     *movieImageName;          /** 图片名称 */
@property(nonatomic,  copy)  NSString     *movieStyle;              /** 电影类型 */
@property(nonatomic, copy)  NSString     *movieTime;               /** 放映时间 */
@property(nonatomic,  copy)  NSString     *movieIntroduce;          /** 电影简介 */
@property(nonatomic,  copy)  NSData       *movieStagePhotoArr;      /**   剧照   */
@property(nonatomic,assign)  NSInteger    moviePlayTime;            /**电影上映月份*/
@property(nonatomic,  copy)  NSString     *movieArea;               /**电影地区*/


@end
