//
//  MyCenterManager.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/11.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "ManagerBase.h"

@class UserInfo;

/**
 分享类型
 */
typedef enum ShareTypeTag
{
    ShareTypeSinaWeiBo = 4,
    ShareTypeWeChatFriendCircle = 3,//微信朋友圈
    ShareTypeQzone = 1,
    ShareTypeWeChatFriend = 2, //微信好友
    ShareTypeQQFriend = 0,//qq好友
}ZXShareType;

@interface MyCenterManager : ManagerBase
//DECLARE_SINGLETON_FOR_CLASS(MyCenterManager)

@property (nonatomic,strong)NSMutableDictionary *requestDic;

/**
 *  手机账号登录接口
 *
 *  @param userName 账号
 *  @param password 密码
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)login:(NSString *)userName
          pwd:(NSString *)password
      success:(void (^)(UserInfo *userInfo))success
      failure:(void (^)(NSString *info))failure;


/**
 *  手机号注册接口
 *
 *  @param nickName 昵称
 *  @param phone    电话
 *  @param code     验证码
 *  @param password 密码
 *  @param type     类型1 贵漂 2 qq 3 微信  4 微博
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)registerNormal:(NSString *)nickName
                 phone:(NSString *)phone
                  code:(NSString *)code
                  type:(NSInteger)type
              password:(NSString *)password
               success:(void (^)(NSInteger returnCode))success
               failure:(void (^)(NSString *info))failure;


/**
 *  获取验证码
 *
 *  @param phone   电话
 *  @param type    类型1.注册 2.找回密码
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)getCode:(NSString *)phone
           type:(NSInteger)type
        success:(void (^)(NSInteger returnCode))success
        failure:(void (^)(NSString *info))failure;

/**
 *验证验证码是否正确
 */
- (void)checkPhone:(NSString *)phone
           code:(NSString *)code
        success:(void (^)(NSInteger returnCode))success
        failure:(void (^)(NSString *info))failure;
/**
 *重置密码
 */
- (void)resetPwd:(NSString *)phone
        password:(NSString *)newPwd
         andCode:(NSString *)code
         success:(void (^)(NSInteger returnCode))success
         failure:(void (^)(NSString *info))failure;

/**
 *检测手机号是否被注册
 */
- (void)isRegisterWithPhone:(NSString *)phone
         success:(void (^)(NSInteger returnCode))success
         failure:(void (^)(NSString *info))failure;

/**
 *更新用户信息
 */
- (void)upLoadUserInfo:(UserInfo *)userInfo
                    success:(void (^)(NSInteger returnCode))success
                    failure:(void (^)(NSString *info))failure;
/**
 *上传用户头像
 保存成功返回头像地址
 */
- (void)upLoadIconImage:(UIImage *)img andUserId:(NSString *)userId
               success:(void (^)(NSString *iconImgFile))success
               failure:(void (^)(NSString *info))failure;

////读取本地保存的图片
//-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath ;
//将所下载的图片保存到本地
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

/**
 *获得用户的头像
 */
- (void)getIconImgWithUserInfo:(UserInfo*)userInfo
                       success:(void (^)(UIImage *iconImg))success
                       failure:(void (^)(NSString *info))failure;


/**
 *提交申诉信息
 */
- (void)upLoadAppealInfo:(NSString*)userId  orderId:(NSString *)orderId
                        appealMessage:(NSString*)message
                       success:(void (^)(NSInteger code))success
                       failure:(void (^)(NSString *info))failure;

/**
 *提交认证信息
 user_id	认证的用户ID	GUID
 name	真实姓名	string
 idcard	身份证号	string
 card_positive_pic_url	身份证正面照图片地址	string
 card_inverse_pic_url	身份证反面照图片地址	string
 student_id	学号	string
 school_code	学校代码	int
 */
- (void)upLoadIndenityInfo:(NSString*)userId  name:(NSString *)name
           idcard:(NSString*)idcard   idCardImg:(NSString*)idCardImg
        xhCardImg:(NSString*)xhCardImg  xH:(NSString*)xH school:(NSString*)school
                 success:(void (^)(NSInteger code))success
                 failure:(void (^)(NSString *info))failure;





/**
 *获得单例
 */
+ (MyCenterManager*)shared;

/**
 *  QQ授权登陆
 */
@property (nonatomic, retain)TencentOAuth  *tencent;

/**
 *  QQ授权登陆
 */
@property (nonatomic, retain)id<TencentSessionDelegate>  tencentDelegate;

/**
 *  QQ登陆---QQ登陆回调成功后向后台发起请求
 */
- (BOOL)loginWithQQ:(NSDictionary *)dic andOpenId:(NSString*)openId withOption:(void(^)(NSDictionary*))options;

/**
 *  IM最近聊天列表
 */
@property (nonatomic, strong)NSMutableArray *messagesArray;
/**
 *  跟新沙盒的message
 */
- (void)updateMessagesArraydata;

@end
