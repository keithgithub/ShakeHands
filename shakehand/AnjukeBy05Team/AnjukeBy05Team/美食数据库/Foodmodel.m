//
//  Usersmodel.m
//  OnLineSales
//
//  Created by etcxm on 16/4/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "Foodmodel.h"

@implementation Foodmodel

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@---%.2f---%@---%ld---%@---%@----%@---%@---%ld---%@---%ld----",_foodName,_pingfen,_pingjia,_pjNum,_imageName,_address,_style,_time,_price,_pricePurchase,_sold];
}





@end
