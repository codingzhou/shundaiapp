//
//  AppDelegate.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//
#ifndef GZEntrepreneur_Constant_h
#define GZEntrepreneur_Constant_h

#if 1     //0-关闭打印  1-开启打印、
#   define NSLog(fmt, ...)  NSLog((@"\n==*=={%s}==*==[Line %d]" fmt "\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NSLog(fmt, ...)
#endif


#define SAFE_RELEASE(x)    \
if(x)                                   \
{                                       \
[x release];                      \
x = nil;                            \
}
#define SAFE_RELEASE_SET(x)  \
if(x)                                   \
{                                       \
[x removeAllObjects];               \
[x release];                        \
x = nil;                            \
}

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define GetReturnCode(x) [[x objectForKey:@"code"] integerValue]
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppVersionNoComment [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""]
#define AppUUUIDString      (ApplicationDelegate.clientId?ApplicationDelegate.clientId:@"")

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define I0S9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//#define UMENG_APPKEY @""

#define kAppId           @""
#define kAppKey          @""
#define kAppSecret       @""

#define DefualtImage    [UIImage imageNamed:@"defalut_logo"]
#define kFilterHegiht       50
#define kMainCellHegiht     110
#pragma mark
#pragma mark 常用的颜色定义
////////////////////////////////////////////////////////////////////////////////


#define kCommAppbackgroundColor  UIColorFromRGB(0xf4f4f4)

#pragma mark
#pragma mark 常用的字体定义
////////////////////////////////////////////////////////////////////////////////
#define kTextViewTextRedColor           [UIColor colorWithRed:0xf2/255.0 green:0x3a/255.0 blue:0x4b/255.0 alpha:1] //主色红色
#define kCommLableFontTitleText     [UIFont systemFontOfSize:17.0]  //标题栏主标题
#define kCommLableFontMainText      [UIFont systemFontOfSize:14.0]  //主要内容
#define kCommLabelFontMinorText     [UIFont systemFontOfSize:12.0]  //次要内容
#define kCommLabelFontAssistText    [UIFont systemFontOfSize:10.0]  //辅助内容
////////////////////////////////////////////////////////////////////////////////

#define kQueryUserInfoTask(userId) [NSString stringWithFormat:@"QueryUserInfoTask_%ld",userId]
#define kPubHeaderFolder        [NSString stringWithFormat:@"%@/userImage",getPublicPathEx()]
#define kLaunchPic [NSString stringWithFormat:@"%@/launch/guide.jpg",getPublicPathEx()]
/***********************通知 begin******************/

#define kNotifyClearData                @"clearData"
#define kUserNetWorkChangedForView      @"kNetWorkFinish"
#define kRequestOverTime                30
#define kNotifyFriendChange             @"kNotifyFriendChange"
#define kRefreshFriend                  @"kNotifyrefresh"
#define kNotifyGetNewData               @"kNotifyGetNewData"
#define kRefreshProjectData             @"kNotifyProject"
/***********************通知 end******************/

#define kTableUserInfo                      @"t_27_yuonghuliebiao"
#define kTableServiceRecommend              @"t_27_fuwutuijian"

/***************** 请求URL begin*************/

#define KUrlGetCode @"http://119.29.140.85/index.php/user/request_msg"

#define KUrlRegister @"http://119.29.140.85/index.php/user/register"

#define KUrlcheckCode @"http://119.29.140.85/index.php/user/valite_msg_code"

#define KUrLogin @"http://119.29.140.85/index.php/user/login"

#define KUrrRsetPaw @"http://119.29.140.85/index.php/user/reset_password“

#define KUrlIsRegister @"http://119.29.140.85/index.php/user/check_phone"

#define KUrlUpdateInfo @"http://119.29.140.85/index.php/user/update_info"

#define KUrlPublishOrder @"http://119.29.140.85/index.php/task/new_task"

#define KUrlUpLoadIconImg @"http://119.29.140.85/index.php/user/upload_head"

#define KUrlDownMyPublisOrder @"http://119.29.140.85/index.php/task/list_launch"

#define KUrlDownMainOrder @"http://119.29.140.85/index.php/task/task_list"

#define KUrlReceivedOrder @"http://119.29.140.85/index.php/task/start_task"

#define KUrlOrderDetail @"http://119.29.140.85/index.php/task/task_detail"

#define KUrlMyReceive @"http://119.29.140.85/index.php/task/list_complete"

#define KUrlBaseUrl @"http://119.29.140.85"

#define KUrlUPloadAppeal @"http://119.29.140.85/index.php/task/new_task_appeal"

#define KUrlUPloadIndentityInfo @"http://119.29.140.85/index.php/user/validate_user"

#define KUrlUFinishOrder @"http://119.29.140.85/index.php/task/receive_task"

#define KUrlUFinishOrderAndPay @"http://119.29.140.85/index.php/task/sure_pay_package"

#define KUrlUDeleteOrder @"http://119.29.140.85/index.php/task/delete_task"



/******************常数 begin**********/
//获得根目录
#define getIconImgBasePaht [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//本地头像地址--不带后缀名
#define sashIconImgFilePaht  [NSString stringWithFormat:@"%@/%@",getIconImgBasePaht,iconImgName]
//当前用户 ID
#define iconImgName [[Config Instance] getID]
//当前用户本地完整头像地址--带后缀名
#define iconImgFilePath  [NSString stringWithFormat:@"%@.jpg",sashIconImgFilePaht]


#define KOpenQQAppId @"1105285682"

//#define API_SIGN @"f6cc5093e6a643db27b038bac0a46879"

 

//--------------sina weibo------------------------------------


//--------------QQ---------------------------------------------
#define kQQAppIDString @"1104876239"   //测试appid  @"222222"

#define kQQAppKeyString @"18xI7SIfZd9wpKuu"
#define kQQAppRedirectURLValue       @"http://www.51guipiao.com"//"http://www.qq.com"

#define kQQAuthorizeURL @"https://graph.qq.com/oauth2.0/authorize?response_type=token&client_id=%@&scope=%@&redirect_uri=%@&display=mobile"
#define kQQGetUserInfoURLValue       @"https://graph.qq.com/user/get_user_info?access_token=%@&oauth_consumer_key=%@&openid=%@"
#define kQQFriendsURLValue           @"https://graph.qq.com/relation/get_fanslist"
#define kQQAuthScopeValue            @"get_user_info,list_album,upload_pic,do_like"
#define kQQAuthLoginURL @"https://graph.z.qq.com/moc2/me?access_token="



//--------------环信---------------------------------------------
//环信APPkey
#define EMAppKey @"1132161230178388#shundai"

//环信默认登陆密码
#define EMUserPassword @"shundaiapp";


//--------------WeiXin---------------------------------------------
#define kWeixinAppIDValue            @"wx6d5c81a134b7aa3d"
#define kWeixinAppKeyValue           @"a6b5ca93c7477b8d629185b331a2c459"
#define kWeixinAPIAccessTokenURLValue      @"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code"
#define kWeixinAPIUserInfoURLValue      @"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@"
#define kWeixinPayURL                   @"http://2902decd.nat123.net/weixinpay/index"
#define kWeixinPayNotifyURL             @""


#define kWeixinAppRPIDValue         @"wxa41f4b37392e4dcf"
#define kWeixinAppRPKeyValue        @"7cd483c2f62c1b578cb635588e700bfa"


#define kShareURL                   @"http://api.51guipiao.com/m/guipiao/share_ios/api_key/guipiao/share_id/%ld/client_type/1"
#endif
