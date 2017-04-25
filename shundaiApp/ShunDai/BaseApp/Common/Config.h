//
//  Config.h
//  yidiantong
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface Config : NSObject

+(Config *) Instance;

-(void)saveID:(NSString *)ID;
- (NSString *)getID;

- (void)saveThirdId:(NSString *)ID;
- (NSString *)getThirdID;


- (void)saveFirstFlag:(BOOL)flag;
- (BOOL)getIsNeedCloseGuide;
// 存取手机号
- (void)savePhone:(NSString *)phone;
- (NSString *)getPhone;

- (void)saveAccountName:(NSString *)accountName;
- (NSString *)getAccountName;
// 存取密码
- (void)savePwd:(NSString *)pwd;
- (NSString *)getPwd;

- (void)saveUserLogo:(NSString *)logo;
- (NSString *)getUserLogo;

// 存取用户名
-(void)saveUserName:(NSString *)userName;
-(NSString *)getUserName;

// 存取用户ID号
- (void)saveScore:(int)score;
- (int)getUserScore;

- (void)saveSex:(NSString *)Sex;
- (NSString *)getUserSex;

-(void)saveUserBrithday:(NSString *)userBrithday;
-(NSString *)getUserBrithday;

// 存取登录状态
-(void)setLoginStatus:(BOOL)bl;
-(BOOL)getLoginStatus;

// 判断是否需要登录
-(BOOL)isNeedToLogin;
//存取头像地址
- (NSString *)getIconImgeUrl;

- (void)setIconImgeUrl:(NSString *)imgUrl;

//存取用户信息
- (UserInfo *)getUserInfo;


- (void)setUserInfo:(UserInfo*)info;

//存取用户认证状态
- (NSInteger)getUserIdentityState;

- (void)setUserIdentityState:(NSInteger)state;






// 存取选择的城市
-(void)saveCity:(NSDictionary *)city;
-(NSDictionary *)getCity;

// 存取定位所得城市
-(void)saveLocationCity:(NSDictionary *)city;
-(NSDictionary *)getLocationCity;


- (NSMutableArray *)getMyCollectRoads;
- (NSMutableArray *)getMyAttentionStations;

- (NSString *)getAppToken;
- (void)saveToken:(NSString *)token;

- (void)logOut;

- (void)saveHeaderPhoto:(NSString *)photo;
- (NSString *)getHeaderPhoto;

- (void)saveLoginType:(BOOL)isThird;
- (BOOL)getIsThirdLogin;

- (void)saveLoginTypeValue:(NSInteger)value;
- (NSInteger)getLoginTypeValue;

- (void)saveBusPicVersion:(NSInteger)version;
- (NSInteger)getBusPicVersion;


- (void)saveServerPwd:(NSString *)pwd;
-(NSString *)getServerPwd;

- (BOOL)isNoFirstLogin;
- (void)setFirstLoginFlag:(BOOL)isLogin;
@end
