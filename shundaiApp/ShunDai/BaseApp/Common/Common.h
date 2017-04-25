//
//  AppDelegate.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
//#import "UIViewExtend.h"


@interface Common : NSObject


+ (NSString *)getNoTimeDate:(NSDate *)date;

/*邮箱验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateEmail:(NSString *)email;

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  构造右上角按钮
 *
 *  @param viewController 类
 *  @param title          右上角title
 *  @param action         事件
 */
+ (void)setNavigationBarRightButtonTitleCenter:(UIViewController *)viewController
                                     withTitle:(NSString *) title
                                    withAction:(SEL)action;

/**
 *  自定义左边按钮
 *
 *  @param viewController 类
 *  @param normalImage    一般效果
 *  @param pressImage     按下效果
 *  @param title          title
 *  @param action         事件
 */
+ (void)setNavigationBarRightButton:(UIViewController *)viewController
                   withBtnNormalImg:(UIImage *)normalImage
                     withBtnPresImg:(UIImage *)pressImage
                          withTitle:(NSString *)title
                         withAction:(SEL)action;

+ (void)setNavigationBarLeftButton:(UIViewController *)viewController
                  withBtnNormalImg:(UIImage *)normalImage
                    withBtnPresImg:(UIImage *)pressImage
                         withTitle:(NSString *)title
                        withAction:(SEL)action;



+(void) setNavigationTitle:(UIViewController *)viewController
                 withTitle:(NSString *)title;


/**
 *根据快递名字返回快递代码
 */
+ (NSInteger)getExpressCodeWithName:(NSString *)name;
/**
 *根据快递代码返回快递名字
 */
+ (NSString*)getExpressNameWithCode:(NSInteger)code;

/**
 *根据学校名字返回学校代码
 */
+ (NSInteger)getSchoolCodeWithName:(NSString *)name;
/**
 *根据学校代码返回学校名字
 */
+ (NSString*)getSchoolNameWithCode:(NSInteger)code;


#pragma makr --- 获得时间字符串的相关方法
+ (NSInteger )getTimeByString:(NSString *)dateStr;

+ (NSString *)getMessageTime:(NSInteger )msgTime;

+ (NSString *)getMessageCellTime:(NSInteger )msgTime;

+ (NSString *)getDayTime:(NSInteger )msgTime;

#pragma mark ---图片相关方法
+(UIImage *)imageWithTransImage:(UIImage *)useImage
            addtransparentImage:(UIImage *)transparentimg;

+ (UIImage *)addImage:(UIImage *)image1
              toImage:(UIImage *)image2;

+ (UIImage *)addImage:(UIImage *)image1
              toImage:(UIImage *)image2
            imageRect:(CGRect)rect;

+ (NSArray *)getOpenCity;

+ (NSString *)getIPAddress;

+ (NSString *)getSign:(NSDictionary *)dic;

+ (NSMutableDictionary *)sortDic:(NSDictionary *)dic;

+ (NSString *)currentWifiSSID;

+ (NSString *)converJsonString:(NSDictionary *)dic;


+ (NSString *)getModelName:(NSString *)apiStr;

+ (NSString *)getIndustryStr:(NSInteger)type;

+ (NSString *)getTimeStr:(NSInteger )time;

+ (UILabel *)getSepLabel;


+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (void)setUMengTag;

+ (void)setLogOutTag;

+ (void)ScreenShot;
@end
