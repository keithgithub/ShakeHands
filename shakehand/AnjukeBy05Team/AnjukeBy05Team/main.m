//
//  main.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/6.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtn"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtnMiddle"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtnRight"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
}
