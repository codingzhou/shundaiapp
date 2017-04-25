//
//  BaseViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Common.h"
#import "Config.h"
#import <MJRefresh.h>
#import "KeyIconView.h"
//#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

//QQ
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/sdkdef.h>


@interface BaseViewController : UIViewController

@property (nonatomic,strong)UIView *baceView;

/**
 *检测当前用户的登陆状态
 */
- (BOOL)checkLogin;

- (void)showWarnMessage:(NSString *)message;

- (UIView *)getBackView;

- (void)removerBackView;

@property (nonatomic,strong)UIAlertView *warnV;


- (void)showControllerMasterView:(NSString*)tipMessage;

- (void)hiddenControllerMaskView;

- (void)hiddenWarnView;

/**
 *从本地获得用户的头像
 */

- (UIImage *)getIconImg;

/**
 *图片压缩
 */

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
