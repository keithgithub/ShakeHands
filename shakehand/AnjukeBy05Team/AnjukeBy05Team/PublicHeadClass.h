//
//  PublicHeadClass.h
//  01PchDemo
//
//  Created by etcxm on 16/6/1.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#ifndef PublicHeadClass_h
#define PublicHeadClass_h

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define TheTitleFont  [UIFont systemFontOfSize:18.0]
#define TheSubTitleFont  [UIFont systemFontOfSize:16.0]

#define TheBackColor RGB(100,200,100)

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define theWidth  [UIScreen mainScreen].bounds.size.width
#define theHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




#endif /* PublicHeadClass_h */
