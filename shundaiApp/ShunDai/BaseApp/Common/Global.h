//
//  Global.h
//  ZhiXingBus
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  全局C++接口类，该类主要是封装一些全局常用的接口。
 */
@interface Global : NSObject

#pragma -mark
#pragma C++系列接口
/**
 *  显示Toast提示
 *
 *  @param apMsg 显示内容
 */
void showToastMsg(NSString* apMsg);

/**
 *  显示错误Toast提示
 *
 *  @param msg 错误内容
 */
void showErrorToastMsg(NSString *msg);

/**
 *  显示成功提示
 *
 *  @param apMsg 显示内容
 */
void showSuccessToastMsg(NSString* apMsg);
/**
 *  制作md5字符串
 *
 *  @param src 输入的一版字符串
 *
 *  @return 返回的MD5字符串
 */
NSString* makeMD5(NSString* src);

/**
 *  获取当前用户ID
 *
 *  @return 用户ID
 */
NSInteger getMasterID();

/**
 *  获取用户数据位置
 */
NSString* getDBPath();

/**
 *  获取用户重要数据存储位置
 *
 *  @return 返回位置
 */
NSString* getAppDocumentPathEx();

/**
 *  返回公共文件夹目录
 *
 *  @return 公共文件夹目录
 */
NSString* getPublicPathEx();

/**
 *  获取用户自己的昵称
 *
 *  @return 昵称
 */
NSString* getMasterNickName();


NSInteger getAgeFromDate(NSString* birthDay);

/**
 *  获取用户自己的Token
 *
 *  @return Token
 */
NSString* getMasterToken();

NSString* getFirstLetterOfString(NSString* apText);

/**
 *  获取某个用户的昵称
 *
 *  @param userId 用户ID
 *
 *  @return 该用户的昵称
 */
NSString* getUserNickName(NSInteger userId);

NSString* getMasterAccpimtName();


/**
 *  获取某个用户的基本信息
 *
 *  @param userId 用户ID
 *
 *  @return 该用户基本信息
 */




NSString *getMasterPwd();

NSString *getRedPackPwd();

NSString* getPhone();



NSString *getDynamicLable(NSInteger type);

NSString *getAreaString(NSInteger areaId);

NSInteger getTypeWithStr(NSString *typeStr);

NSString *getCardString(NSInteger type);

NSString *getIndustryStr(NSInteger type);

NSInteger getTypeWithStr(NSString *typeStr);
@end
