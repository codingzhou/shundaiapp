//
//  LauchViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum {
    LaunchType_Register = 1,
    LaunchType_Forget = 2
};

@interface LaunchViewController : BaseViewController
    


    
/**
 *登陆接口
 */
+ (void)LoginWithPhoe:(NSString *)phone andPaw:(NSString *)paw;
    
- (void)LoginWithPhoe:(NSString *)phone andPaw:(NSString *)paw;
    
    @end
