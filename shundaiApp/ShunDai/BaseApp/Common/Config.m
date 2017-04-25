//
//  Config.m
//  yidiantong
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 QiXun. All rights reserved.
//

#import "Config.h"
#import <SystemConfiguration/CaptiveNetwork.h> 
#import "Common.h"
//#import "FunctionDBCache.h"
//#import "AppInitManager.h"

@implementation Config

static Config * instance = nil;
+(Config *) Instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Config alloc] init];
    });
    return instance;
}

-(void)savePhone:(NSString *)phone{
    [USER_DEFAULT removeObjectForKey:@"Phone"];
    [USER_DEFAULT setObject:phone forKey:@"Phone"];
    [USER_DEFAULT synchronize];
}

-(NSString *)getPhone{
    return [USER_DEFAULT objectForKey:@"Phone"];
}

- (void)saveServerPwd:(NSString *)pwd
{
    [USER_DEFAULT removeObjectForKey:@"serverPassword"];
    [USER_DEFAULT setObject:pwd forKey:@"serverPassword"];
    [USER_DEFAULT synchronize];
}

-(NSString *)getServerPwd
{
    NSString * temp = [USER_DEFAULT objectForKey:@"serverPassword"];
    return temp;
}

-(void)savePwd:(NSString *)pwd{
    [USER_DEFAULT removeObjectForKey:@"Password"];
    [USER_DEFAULT setObject:pwd forKey:@"Password"];
    [USER_DEFAULT synchronize];
}

-(NSString *)getPwd
{
    NSString * temp = [USER_DEFAULT objectForKey:@"Password"];
    return temp;
}

-(void)saveUserName:(NSString *)userName{
    [USER_DEFAULT removeObjectForKey:@"UserName"];
    [USER_DEFAULT setObject:userName forKey:@"UserName"];
    [USER_DEFAULT synchronize];
}

-(NSString *)getUserName{
    return [USER_DEFAULT objectForKey:@"UserName"];
}

-(void)saveID:(NSString *)ID
{
    [USER_DEFAULT removeObjectForKey:@"ID"];
    [USER_DEFAULT setObject:ID forKey:@"ID"];
    [USER_DEFAULT synchronize];
}

-(NSString *)getID
{
    return [USER_DEFAULT objectForKey:@"ID"];
}

- (void)saveThirdId:(NSString *)ID
{
    [USER_DEFAULT removeObjectForKey:@"thirdID"];
    [USER_DEFAULT setObject:ID forKey:@"thirdID"];
    [USER_DEFAULT synchronize];
}
- (NSString *)getThirdID
{
    return [USER_DEFAULT objectForKey:@"thirdID"];
}








//存取头像地址
- (NSString *)getIconImgeUrl{
 return [USER_DEFAULT objectForKey:@"iconImageUrl"];
}

- (void)setIconImgeUrl:(NSString *)imgUrl{
    [USER_DEFAULT removeObjectForKey:@"iconImageUrl"];
    [USER_DEFAULT setObject:imgUrl forKey:@"iconImageUrl"];
    [USER_DEFAULT synchronize];
}

//存取用户信息
- (UserInfo *)getUserInfo{

    NSDictionary *dic = [USER_DEFAULT objectForKey:@"userInfo"];
    return [UserInfo userInfoWithDic:dic];
}

- (void)setUserInfo:(UserInfo*)info{
    NSDictionary *dic = [info getDictionary];
    
    [USER_DEFAULT removeObjectForKey:@"userInfo"];
    [USER_DEFAULT setObject:dic forKey:@"userInfo"];
    [USER_DEFAULT synchronize];
}

//存取用户认证状态
- (NSInteger)getUserIdentityState{
    NSInteger state = [NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"userIdentityState"]].integerValue;
    return state;
}

- (void)setUserIdentityState:(NSInteger)state{
    [USER_DEFAULT removeObjectForKey:@"userIdentityState"];
    [USER_DEFAULT setObject:@(state) forKey:@"userIdentityState"];
    [USER_DEFAULT synchronize];
}

- (void)clearMsg
{
    [USER_DEFAULT setObject:@(0) forKey:@"msg"];
    [USER_DEFAULT synchronize];
}

- (int)getUnreadMsg;
{
    return [[USER_DEFAULT objectForKey:@"msg"] intValue];
}

-(void)setLoginStatus:(BOOL)bl{
    [USER_DEFAULT removeObjectForKey:@"LoginStatus"];
    [USER_DEFAULT setBool:bl forKey:@"LoginStatus"];
    [USER_DEFAULT synchronize];
}

- (void)saveAccountName:(NSString *)accountName
{
    [USER_DEFAULT removeObjectForKey:@"account"];
    [USER_DEFAULT setObject:accountName forKey:@"account"];
    [USER_DEFAULT synchronize];
}

- (NSString *)getAccountName
{
   return [USER_DEFAULT objectForKey:@"account"];
}

-(BOOL)getLoginStatus{
    return [USER_DEFAULT boolForKey:@"LoginStatus"];
}


- (BOOL)isNeedToLogin
{
    BOOL isLogin = [self getLoginStatus];
    if (isLogin == NO)
        return YES;
    return NO;
}

- (void)saveScore:(int)score
{
    [USER_DEFAULT removeObjectForKey:@"Score"];
    [USER_DEFAULT setObject:@(score) forKey:@"Score"];
    [USER_DEFAULT synchronize];
}
- (int)getUserScore
{
   return [[USER_DEFAULT objectForKey:@"Score"] intValue];
}

- (void)saveSex:(NSString *)Sex
{
    [USER_DEFAULT removeObjectForKey:@"Sex"];
    [USER_DEFAULT setObject:Sex forKey:@"Sex"];
    [USER_DEFAULT synchronize];
}
- (NSString *)getUserSex
{
   return [USER_DEFAULT objectForKey:@"Sex"];
}
- (void)saveUserLogo:(NSString *)logo
{
    [USER_DEFAULT removeObjectForKey:@"logo"];
    [USER_DEFAULT setObject:logo forKey:@"logo"];
    [USER_DEFAULT synchronize];
}

- (void)saveHeaderPhoto:(NSString *)photo
{
    [USER_DEFAULT removeObjectForKey:@"photo"];
    [USER_DEFAULT setObject:photo forKey:@"photo"];
    [USER_DEFAULT synchronize];
}

- (NSString *)getHeaderPhoto
{
    return [USER_DEFAULT objectForKey:@"photo"];
}

- (NSString *)getUserLogo
{
    return [USER_DEFAULT objectForKey:@"logo"];
}

-(void)saveUserBrithday:(NSString *)userBrithday
{
    [USER_DEFAULT removeObjectForKey:@"brithday"];
    [USER_DEFAULT setObject:userBrithday forKey:@"brithday"];
    [USER_DEFAULT synchronize];
}
-(NSString *)getUserBrithday
{
    return [USER_DEFAULT objectForKey:@"brithday"];
}

-(void)saveCity:(NSDictionary *)city{
    [USER_DEFAULT removeObjectForKey:@"City"];
    [USER_DEFAULT setObject:city forKey:@"City"];
    [USER_DEFAULT synchronize];
}

-(NSDictionary *)getCity{
    return [USER_DEFAULT objectForKey:@"City"];
}

-(void)saveLocationCity:(NSDictionary *)city{
    [USER_DEFAULT removeObjectForKey:@"LocationCity"];
    [USER_DEFAULT setObject:city forKey:@"LocationCity"];
    [USER_DEFAULT synchronize];
}

-(NSDictionary *)getLocationCity{
    return [USER_DEFAULT objectForKey:@"LocationCity"];
}

- (void)saveHomeAddress:(NSString *)address
{
    [USER_DEFAULT removeObjectForKey:@"homeAddress"];
    [USER_DEFAULT setObject:address forKey:@"homeAddress"];
    [USER_DEFAULT synchronize];
}

- (NSString *)getHomeAddress;
{
    return [USER_DEFAULT objectForKey:@"homeAddress"];
}

- (void)saveCompanyAddress:(NSString *)address
{
    [USER_DEFAULT removeObjectForKey:@"companyAddres"];
    [USER_DEFAULT setObject:address forKey:@"companyAddres"];
    [USER_DEFAULT synchronize];
}
- (NSString *)getCompanyAddress
{
    return [USER_DEFAULT objectForKey:@"companyAddres"];
}

- (void)saveFirstFlag:(BOOL)flag
{
    [USER_DEFAULT removeObjectForKey:@"firstLogin"];
    [USER_DEFAULT setObject:@(flag) forKey:@"firstLogin"];
    [USER_DEFAULT synchronize];
}

//- (BOOL)getIsNeedCloseGuide
//{
//    if (!AppVersionNoComment) {
//        [AppInitManager updateVersionDo];
//        return YES;
//    }
//    
//    NSInteger getLastVersion = [self getVersion];
//    NSInteger curreintVersion = [AppVersionNoComment integerValue];
//    
//    if (curreintVersion > getLastVersion) {
//        [AppInitManager updateVersionDo];
//        [self setVersion:curreintVersion];
//        return NO;
//    } else {
//        return YES;
//    }
//}

- (void)setVersion:(NSInteger)version
{
    [USER_DEFAULT removeObjectForKey:@"appVersion"];
    [USER_DEFAULT setObject:@(version) forKey:@"appVersion"];
    [USER_DEFAULT synchronize];
}

- (NSInteger)getVersion;
{
    return [[USER_DEFAULT objectForKey:@"appVersion"] integerValue];
}

//读取plist文件
- (NSDictionary *)readDictPlistFile:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return dict;
}

- (NSArray *)readArrayPlistFile:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return arr;
}

+(NSString *) getAppDocumentDirectory
{
	NSArray* lpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//NSDocumentDirectory
	if([lpPaths count]>0)
		return [lpPaths objectAtIndex:0];
	else
		return nil;
}


- (void)logOut
{
    [[Config Instance] saveUserName:@""];
    [[Config Instance] saveID:0];
    [[Config Instance] savePwd:@""];
    [[Config Instance] setLoginStatus:NO];
    [[Config Instance] saveToken:@"Token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClearData object:nil];
//    [GET_SINGLETON_FOR_CLASS(FunctionDBCache) changeDBName];

}

- (NSString *)getAppToken
{
    NSString *appToken = [USER_DEFAULT objectForKey:@"appToken"];
    
    if (!appToken || [appToken isEqualToString:@""]) {
        return @"Token";
    } else {
        return appToken;
    }
}

- (void)saveToken:(NSString *)token
{
    [USER_DEFAULT removeObjectForKey:@"appToken"];
    [USER_DEFAULT setObject:token forKey:@"appToken"];
    [USER_DEFAULT synchronize];
}

- (void)saveLoginType:(BOOL)isThird
{
    [USER_DEFAULT removeObjectForKey:@"isThird"];
    [USER_DEFAULT setBool:isThird forKey:@"isThird"];
    [USER_DEFAULT synchronize];
}

-(BOOL)getIsThirdLogin
{
    return [USER_DEFAULT boolForKey:@"isThird"];
}


-(void)saveLoginTypeValue:(NSInteger)value
{
    [USER_DEFAULT removeObjectForKey:@"loginValue"];
    [USER_DEFAULT setObject:@(value) forKey:@"loginValue"];
    [USER_DEFAULT synchronize];
}

-(NSInteger)getLoginTypeValue
{
    return [[USER_DEFAULT objectForKey:@"loginValue"] integerValue];
}

- (void)saveBusPicVersion:(NSInteger)version
{
    [USER_DEFAULT removeObjectForKey:@"busPicVersion"];
    [USER_DEFAULT setObject:@(version) forKey:@"busPicVersion"];
    [USER_DEFAULT synchronize];
}

- (NSInteger)getBusPicVersion
{
    return [[USER_DEFAULT objectForKey:@"busPicVersion"] integerValue];
}


- (BOOL)isNoFirstLogin
{
    return [USER_DEFAULT boolForKey:@"FirstLogin"];
}
- (void)setFirstLoginFlag:(BOOL)isLogin
{
    [USER_DEFAULT removeObjectForKey:@"FirstLogin"];
    [USER_DEFAULT setBool:isLogin forKey:@"FirstLogin"];
    [USER_DEFAULT synchronize];
}
@end
