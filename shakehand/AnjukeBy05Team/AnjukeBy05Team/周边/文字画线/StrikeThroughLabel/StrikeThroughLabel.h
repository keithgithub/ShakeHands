//
//  StrikeThroughLabel.h
//  StrikeThroughLabelExample
//
//  Created by Scott Hodgin on 12/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StrikeThroughLabel : UILabel {
    BOOL _strikeThroughEnabled;
    BOOL _flag;
}

@property (nonatomic) BOOL strikeThroughEnabled;
@property (nonatomic) BOOL flag;
@end
