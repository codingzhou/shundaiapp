//
//  OrderAppealViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "ShareManage.h"
#import <TencentOpenAPI/TencentMessageObject.h>
//#import "WXApi.h"
//#import "WXApiObject.h"
//#import "TencentSDKCallBack.h"
#import "Config.h"

//#import ""
//#import <ShareSDK/ShareSDK.h>
//#import "WeiboSDK.h"

@interface ShareManage()

@property (nonatomic, retain)NSString *descrip;
@property (nonatomic, retain)NSString *titleWeiBo;
@property (nonatomic, retain)UIImage *image;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, retain)NSString *weiTitle;

@end
@implementation ShareManage


-(id)init
{
    self = [super init];
    if (self) {
//        NSDictionary *sinaWeiboDic = [NSDictionary dictionaryWithObjectsAndKeys: \
//                                      kWeiboAppKeyString, kWeiboAppKey,
//                                      kWeiboAppSecretString, kWeiboAppSecret,
//                                      @"http://www.zhixingbus.com", kWeiboAppRedirectURL,
//                                      @"", kWeiboAuthoCancel, nil];
        
//        
//        NSDictionary *qqConDic = [NSDictionary dictionaryWithObjectsAndKeys: \
//                                  kQQAppIDString, kQQAppID,
//                                  kQQAppKeyString, kQQAppKey,
//                                  @"http://www.zhixingbus.com", kQQAppRedirectURL, nil];
//
//        NSDictionary *weixinDic = [NSDictionary dictionaryWithObjectsAndKeys: \
//                                   kWeixinAppIDValue, kWeixinAppId,
//                                   kWeixinAppKeyValue, kWeixinAppKey, nil];
        
//        
//        NSDictionary *rootDict = [NSDictionary dictionaryWithObjectsAndKeys: \
//                                  qqConDic, kQQConnectLogin,
//                                  weixinDic, kWeiXinLogin
//                                  ,nil];
        
//        [LMLSdk initSDKWithParams:rootDict];
        
//        [WXApi registerApp:kWeixinAppIDValue];
    }
    return self;
}

- (void)gotoRedPackShare:(UIViewController *)parentViewController withShareType:(ZXShareType)shareType
{
    
}//{
//    
//    self.image = [UIImage imageNamed:@"red_share_image"];
//    self.descrip = @"我在“智行公交”领到红包了！！！";
//    self.weiTitle = @"我在“智行公交”领到车票了！！！";//微信会屏蔽带有“红包”字段的分享
//    self.url = [kRedPackShareURL stringByAppendingFormat:@"totalAmount=%@&winningWord=%@&business=%@",
//                GET_SINGLET(ActivityManager).currentRPInfo.rpPrice,
//                [GET_SINGLET(ActivityManager).currentRPInfo.adWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                [GET_SINGLET(ActivityManager).currentRPInfo.provideName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSString *str = [NSString stringWithFormat:@"我在“智行公交”领到红包了！%@totalAmount=%@&business=%@&winningWord=%@",
//                     kRedPackShareURL,
//                     GET_SINGLET(ActivityManager).currentRPInfo.rpPrice,
//                     [GET_SINGLET(ActivityManager).currentRPInfo.provideName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                     [GET_SINGLET(ActivityManager).currentRPInfo.adWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    self.titleWeiBo = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    [self shareMethd:parentViewController withShareType:shareType];
//    
//}
-(void)gotoShare:(UIViewController *)parentViewController
   withShareType:(ZXShareType)shareType
             url:(NSString *)url
{
//    self.url = url;
//    self.image = [UIImage imageNamed:@"icon"];
//    self.descrip = [NSString stringWithFormat:@"你的好友%@邀请你来贵漂开始你的创业旅程",getMasterNickName()];
//    self.weiTitle = @"贵漂在手，创业无忧";
    //    self.titleWeiBo = @"智行公交，智慧出行，公交中的定位王！http://www.zhixingbus.com";
    [self shareMethd:parentViewController withShareType:shareType];
}

//进入分享
-(void)gotoShare:(UIViewController *)parentViewController withShareType:(ZXShareType)shareType
{
//    self.url = [NSString stringWithFormat:kShareURL,(long)getMasterID()];
//    self.image = [UIImage imageNamed:@"icon"];
//    self.descrip = [NSString stringWithFormat:@"你的好友%@邀请你来贵漂开始你的创业旅程",getMasterNickName()];
//    self.weiTitle = @"贵漂在手，创业无忧";
//    self.titleWeiBo = @"智行公交，智慧出行，公交中的定位王！http://www.zhixingbus.com";
    [self shareMethd:parentViewController withShareType:shareType];
}

- (void)shareMethd:(UIViewController *)ctl withShareType:(ZXShareType)shareType
{
//    _viewController = (BaseController*)ctl;
    _currentShareState = NO;
    _currentShareType = shareType;
//    _defaultDelegate = [LMLSdk sharedInstance].delegate;
//    [LMLSdk sharedInstance].delegate = self;
    
    switch (_currentShareType) {
        case ShareTypeWeChatFriendCircle:
        {
            //            //微信朋友圈
            [self shareMessageWeChat:1];
        }
            break;
        case ShareTypeSinaWeiBo:
        {
            [self shareSinaWeibo];
            
        }
            break;
        case ShareTypeQzone:
        {
            //QQ空间
            [self shareMessageToQzone];
        }
            break;
        case ShareTypeWeChatFriend:
        {
            //微信好友
            [self shareMessageWeChat:0];
        }
            break;
        case ShareTypeQQFriend:
        {
            //QQ好友
            [self ShareQQFriend];
        }
            break;
        default:
            break;
    }

}


//微信分享，scene 0为好友，1为朋友圈，2为收藏
-(void)shareMessageWeChat:(int)scene
{
//    if ([WeiXinInstnace isWeixinInstalled]) {
//        [self sendMessageWeChat:scene];
//    } else {
//        NSLog(@"你还没有安装微信客户端");
//    }
}

-(void)sendMessageWeChat:(int)scene
{
//    [[LMLSdk sharedInstance]forwardLinkMsgToWeixin:self.weiTitle description:self.descrip thumbnail:self.image url:self.url scene:scene];
}

-(void)shareSinaWeibo
{
//    [[LMLSdk sharedInstance] putShareContentWithImage:self.titleWeiBo image:self.image loginType:kSinaWeiboLogin];
}

-(void)shareMessageToQzone
{
//    NSString *title = @"智行公交";
//    [[LMLSdk sharedInstance] forwardLinkMsgToQQ:title description:self.descrip thumbnail:self.image url:_url scene:1];
}

//QQ好友
-(void)ShareQQFriend
{
//    NSString *title = @"智行公交";
//    [[LMLSdk sharedInstance] forwardLinkMsgToQQ:title description:self.descrip thumbnail:self.image url:_url scene:0];
}

#pragma mark -
#pragma mark LMLSdkProtocol
/**
 登录成功后的回调
 @param info 包含登录成功后的打印信息，参考示例程序
 */
- (void)onLoginSuccess:(id)info
{
//    NSDictionary* dicInfo = (NSDictionary*)info;
//    NSString* loginType = [dicInfo objectForKey:@"loginType"];
//    if ([kSinaWeiboLogin isEqualToString:loginType]) {
//        [self shareSinaWeibo];
//    }
}

/**
 登录失败的回调
 */
//- (void)onLoginFailure:(LMLError)error
//{
//    NSLog(@"分享失败");
//}

/**
 发布分享成功
 @param info 成功回调回来的dictionary。
 @param type 登录的类型，目前有: <code>kQQConnectLogin</code>, <code>kSinaWeiboLogin</code>, <code>kRenrenLogin</code>等三种类型。
 */
- (void)onPutShareContentSuccess:(id)info
                       loginType:(NSString *)type
{
    NSLog(@"分享成功，感谢您的分享");
    [self addGreenValueForShare];
}

/**
 发布分享失败
 @param error LMLError枚举类型。错误码。
 @param type 登录的类型，目前有: <code>kQQConnectLogin</code>, <code>kSinaWeiboLogin</code>, <code>kRenrenLogin</code>等三种类型。
 */
//- (void)onPutShareContentFailed:(LMLError)error
//                      loginType:(NSString *)type
//{
//    if (error == E_FL_AUTH && [kSinaWeiboLogin isEqualToString:type]) {
//        [[LMLSdk sharedInstance] doLogin:type curViewCtrl:_viewController];
//        return;
//    }
//    [LMLSdk sharedInstance].delegate = _defaultDelegate;
//    NSLog(@"分享失败");
//}

/**
 转发消息到微信并回调成功
 @param info 如果为"0"则表示成功.
 */
//- (void)onForwardMsgToWeiXinSuccess
//{
//    [LMLSdk sharedInstance].delegate = _defaultDelegate;
//    //分享成功，通知服务器。
//    
//    if (_isWeixinActivity) {
//        _isWeixinActivity = NO;
////        [GET_SINGLET(ActivityManager) sendShare:YES];
//    }
//    
//    _currentShareState = YES;
//    NSLog(@"分享成功，感谢您的分享");
//    [self addGreenValueForShare];
//}

/**
 转发消息到微信并回调失败
 @param info 如果为"0"则表示成功.
 */
//- (void)onForwardMsgToWeiXinFailure
//{
//    [LMLSdk sharedInstance].delegate = _defaultDelegate;
//    NSLog(@"分享失败");
//}

#pragma mark
#pragma mark QQ空间分享回调
//处理来至QQ的请求

- (void)onForwardMsgToQQSuccess
{
    
}

- (void)onForwardMsgToQQFailure
{
    
}

-(void)shareQQZoneOnReq:(QQBaseReq *)req
{
    NSLog(@"shareQQZoneOnReq = %@",req);
}
//处理来至QQ的响应
-(void)shareQQZoneOnResp:(QQBaseResp *)req
{
    NSLog(@"shareQQZoneOnResp = %@",req);
    NSLog(@"QQBaseResp.result = %@",req.result);
    NSLog(@"QQBaseResp.type = %d",req.type);
    NSLog(@"QQBaseResp.error = %@",req.errorDescription);
    NSLog(@"QQBaseResp.extendInfo = %@",req.extendInfo);
    if (!req.errorDescription && [req.result intValue] == 0) {
        NSLog(@"Qzone share suc");
        _currentShareState = YES;
        NSLog(@"分享成功，感谢您的分享");
        [self addGreenValueForShare];
    } else {
        NSLog(@"分享失败");
    }
}
//处理QQ在线状态的回调
-(void)shareQQZoneIsOnlineResponse:(NSDictionary *)req
{
    NSLog(@"shareQQZoneIsOnlineResponse = %@",req);
}
#pragma mark


- (void)addGreenValueForShare
{
   
}

- (void)clearData
{
    
}

- (void)sharePicToFriend:(UIViewController *)parentViewController
                 content:(NSString *)content
           withShareType:(ZXShareType)shareType
                   Image:(UIImage *)sendImage
{
//    self.titleWeiBo = content;
//    self.image = sendImage;
//    _viewController = (BaseController*)parentViewController;
    _currentShareState = NO;
    _currentShareType = shareType;
//    _defaultDelegate = [LMLSdk sharedInstance].delegate;
//    [LMLSdk sharedInstance].delegate = self;
//    switch (shareType) {
//        case ShareTypeSinaWeiBo:
//            [[LMLSdk sharedInstance] putShareContentWithImage:content image:sendImage loginType:kSinaWeiboLogin];
//            break;
//        case ShareTypeWeChatFriendCircle:
//            [[LMLSdk sharedInstance] forwardPicMsgToWeixin:content thumbnail:sendImage scene:1];
//            break;
//        case ShareTypeWeChatFriend:
//            [[LMLSdk sharedInstance] forwardPicMsgToWeixin:content thumbnail:sendImage scene:0];
//            break;
//        case ShareTypeQQFriend:
//            [[LMLSdk sharedInstance] forwardPicMsgToQQ:content thumbnail:sendImage scene:0];
//            break;
//        default:
//            break;
//    }
    
    
    
//    id<ISSContent> publishContent = [ShareSDK content:@""
//                                       defaultContent:@""
//                                                image:[ShareSDK pngImageWithImage:sendImage]
//                                                title:@"智行公交"
//                                                  url:@"www.zhixingbus.com"
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeImage];
//    id<ISSCAttachment> = [ShareSDK je
//    SSPublishContentMediaType
//    id<ISSCAttachment> thumbImage = [ShareSDK jpegImageWithImage:sendImage quality:.1];
//    id<ISSCAttachment> shareAttach = [ShareSDK jpegImageWithImage:sendImage quality:1.0];
//    
//    [publishContent addWeixinSessionUnitWithType:[NSNumber numberWithInt:SSPublishContentMediaTypeImage] content:@" " title:@"" url:@"" thumbImage:thumbImage image:shareAttach musicFileUrl:@"" extInfo:nil fileData:nil emoticonData:nil];
    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:parentViewController
//                                               authManagerViewDelegate:parentViewController];
//    _viewController = (ZXBaseController*)parentViewController;
//    _currentShareState = NO;
//    _currentShareType = shareType;
//    _defaultDelegate = [LMLSdk sharedInstance].delegate;
//    [LMLSdk sharedInstance].delegate = self;
//    [[LMLSdk sharedInstance] forwardPicMsgToWeixin:content thumbnail:sendImage scene:0];
    
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"img.jpg"];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        default:
        {
            break;
        }
    }
}
@end
