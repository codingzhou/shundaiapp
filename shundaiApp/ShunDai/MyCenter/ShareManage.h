//
//  AboutShunDaiViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
//#import "LMLSdk.h"


//#import <ShareSDK/ShareSDK.h>

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

/**
 *  分享相关控制器
 */
@interface ShareManage : NSObject//<LMLSdkProtocol>
{
    ZXShareType _currentShareType;
    BOOL _currentShareState;
    id _defaultDelegate;
//    BaseController *_viewController;
    
}


///----------------------
/// @name 属性
///----------------------
/**
 *  是否是微信
 */
@property(nonatomic, assign)BOOL isWeixinActivity;

///----------------------
/// @name 接口
///----------------------
/**
 *  分享接口
 *
 *  @param parentViewController 回调的控制器（分享成功后，需要回弹到这个接口）
 *  @param shareType            分享类型
 */
//-(void)gotoShare:(UIViewController *)parentViewController withShareType:(ZXShareType)shareType;
//
//-(void)gotoShare:(UIViewController *)parentViewController
//   withShareType:(ZXShareType)shareType
//             url:(NSString *)url;
///**
// *  分享单个图片消息
// *
// *  @param parentViewController 回调的控制器（分享成功后，需要回弹到这个接口）
// *  @param content              分享内容
// *  @param shareType            分享类型
// *  @param sendImage            分享的图片
// */
//- (void)sharePicToFriend:(UIViewController *)parentViewController
//                 content:(NSString *)content
//           withShareType:(ZXShareType)shareType
//                   Image:(UIImage *)sendImage;
//
//-(void)gotoRedPackShare:(UIViewController *)parentViewController withShareType:(ZXShareType)shareType;
//
//
//-(void)shareQQZoneOnReq:(QQBaseReq *)req;
//
//-(void)shareQQZoneOnResp:(QQBaseResp *)req;
//
//-(void)shareQQZoneIsOnlineResponse:(NSDictionary *)req;
@end
