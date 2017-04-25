//
//  AppDelegate.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "BaseTabBarVC.h"
#import "CustomNavigationController.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import "HttpEngin.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  程序选项卡类
 */
@property (nonatomic, retain) BaseTabBarVC *tabBarController;

/**
 *  个推使用的客户端推送ID
 */
@property (retain, nonatomic) NSString *clientId;

/**
 *  APNS推送的token。每个设备一个唯一的ID
 */
@property (nonatomic, retain) NSString *deviecToken;

/**
 *  是否处于后台模式，包括用户按下Home返回后台，和按下锁屏键锁屏。
 */
@property (nonatomic, assign) BOOL isBackground;

/**
 *  http请求类
 */
//@property (nonatomic, retain) HttpEngin *engin;

/**
 *  当前手机网络状态
 */
//@property (nonatomic, assign) enumNetType netType;

@property (nonatomic, retain) NSDateFormatter *dateFormat;



/**
 *  http请求类
 */
//@property (nonatomic, retain) HttpEngin *engin;

@end

