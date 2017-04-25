//
//  TextViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/6/1.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "BaseViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuthObject.h>



@interface TextViewController : BaseViewController

- (void)showAlumb;

- (void)getImage:(UIImage *)image;

@end
