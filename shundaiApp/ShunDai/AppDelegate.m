//
//  AppDelegate.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface AppDelegate ()<EMContactManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initTabBarView];
    if ([[Config Instance] getLoginStatus]) {
        self.window.rootViewController = _tabBarController;
        _tabBarController.selectedIndex = 2;
    } else {
        LaunchViewController *ctl = [[LaunchViewController alloc] init];
        CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:ctl];
        self.window.rootViewController = nav;
    }
    
    [self launchImage];
    [self initTools];
    //环信初始化
    EMOptions *options = [EMOptions optionsWithAppkey:EMAppKey];
    options.apnsCertName = @"";
    EMError *error = [[EMClient sharedClient] initializeSDKWithOptions:options];
    if(!error){
        NSLog(@"IM initialize is success");
    }
    [self.window makeKeyAndVisible];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    
    //注册高德地图
    [AMapServices sharedServices].apiKey = @"45793290826a7c335a340611b4cb0ade";
    //[AMapSearchServices sharedServices].apiKey = @"45793290826a7c335a340611b4cb0ade";
    return YES;
}

- (void)initTools{
//    _engin = [[HttpEngin alloc] init];
    _dateFormat = [[NSDateFormatter alloc] init];
}


- (void)launchImage
{
//    NSString *dir = [NSString stringWithFormat:@"%@/launch",];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
//        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:NO attributes:nil error:nil];
//    }
    self.window.backgroundColor = [UIColor whiteColor];
    UIImageView *launchImage = nil;
    NSString *imageStr = @"Launch";
    launchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageStr]];
    //    }
    launchImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.window.rootViewController.view addSubview:launchImage];
    [self.window.rootViewController.view bringSubviewToFront:launchImage];
    [self performSelector:@selector(removeLaunch:) withObject:launchImage afterDelay:2.5];
}
- (void)removeLaunch:(UIImageView *)imageView
{
    [imageView removeFromSuperview];
}

- (void)initTabBarView
{
    _tabBarController = [[BaseTabBarVC alloc] init];
    _tabBarController.view.alpha = 1;
    [_tabBarController setSelectedIndex:2];
}

//QQ登陆要求---重新的方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

//接受到好友请求的回调
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    //同意添加好友请求
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
    if (!error) {
        //NSLog(@"发送同意成功");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//- (void)didReceiveMessages:(NSArray *)aMessages
//{
//      NSLog(@"%@",aMessages);
//    for (EMMessage *message in aMessages) {
//        EMMessageBody *msgBody = message.body;
//        switch (msgBody.type) {
//            case EMMessageBodyTypeText:
//            {
//                // 收到的文字消息
//                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
//                NSString *txt = textBody.text;
//                NSLog(@"收到的文字是 txt -- %@",txt);
//            }
//                break;
//            case EMMessageBodyTypeImage:
//            {
//                // 得到一个图片消息body
//                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
//                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
//                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"大图的secret -- %@"    ,body.secretKey);
//                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
//                //                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
//                
//                
//                // 缩略图sdk会自动下载
//                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
//                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
//                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
//                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
//                //                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeLocation:
//            {
//                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
//                NSLog(@"纬度-- %f",body.latitude);
//                NSLog(@"经度-- %f",body.longitude);
//                NSLog(@"地址-- %@",body.address);
//            }
//                break;
//            case EMMessageBodyTypeVoice:
//            {
//                // 音频sdk会自动下载
//                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
//                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
//                NSLog(@"音频的secret -- %@"        ,body.secretKey);
//                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
//                //                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
//                //                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
//            }
//                break;
//            case EMMessageBodyTypeVideo:
//            {
//                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
//                
//                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"视频的secret -- %@"        ,body.secretKey);
//                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
//                //                NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
//                //                NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
//                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
//                
//                // 缩略图sdk会自动下载
//                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
//                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
//                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
//                //                NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeFile:
//            {
//                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
//                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"文件的secret -- %@"        ,body.secretKey);
//                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
//                //                NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//}
//
///*!
// @method
// @brief 接收到一条及以上cmd消息
// */
//- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages{
//    NSLog(@"%@",aCmdMessages);
//    for (EMMessage *message in aCmdMessages) {
//        EMCmdMessageBody *body = (EMCmdMessageBody *)message.body;
//        NSLog(@"收到的action是 -- %@",body.action);
//    }
//}
//


@end
