//
//  MyCenterManager.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/11.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MyCenterManager.h"
#import "UserInfo.h"
#import "Config.h"
#import "Common.h"
#import "NSString+Json.h"

static MyCenterManager *class = nil;

@implementation MyCenterManager

- (instancetype)init{
    if ([super init]) {
        self.requestDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)getCode:(NSString *)phone
           type:(NSInteger)type
        success:(void (^)(NSInteger returnCode))success
        failure:(void (^)(NSString *info))failure{
    
    NSString *urlStr = KUrlGetCode;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}
- (void)registerNormal:(NSString *)nickName
                 phone:(NSString *)phone
                  code:(NSString *)code
                  type:(NSInteger)type
              password:(NSString *)password
               success:(void (^)(NSInteger returnCode))success
               failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlRegister;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone,@"password":password};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];

}


- (void)checkPhone:(NSString *)phone
                      code:(NSString *)code
                   success:(void (^)(NSInteger returnCode))success
                   failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlcheckCode;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone,@"code":code};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)login:(NSString *)phone
          pwd:(NSString *)password
      success:(void (^)(UserInfo *responseObject))success
      failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrLogin;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone,@"password":password};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        
        if (isSuccess) {
            UserInfo *userInfo = [UserInfo userInfoWithDic:responseObject[@"data"]];
            success(userInfo);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)resetPwd:(NSString *)phone password:(NSString *)newPwd andCode:(NSString *)code success:(void (^)(NSInteger))success failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlRegister;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone,@"password":newPwd};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];

}

- (void)isRegisterWithPhone:(NSString *)phone
                    success:(void (^)(NSInteger returnCode))success
                    failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlIsRegister;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"phone":phone};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];

    
}

/**
 *更新用户信息
 */
- (void)upLoadUserInfo:(UserInfo *)userInfo
               success:(void (^)(NSInteger returnCode))success
               failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlUpdateInfo;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = [userInfo getDictionary];
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
}

/**
 *提交申诉信息
 */
- (void)upLoadAppealInfo:(NSString*)userId orderId:(NSString *)orderId
           appealMessage:(NSString*)message
                 success:(void (^)(NSInteger code))success
                 failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlUPloadAppeal;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params =@{@"appeal_user_id":userId,@"task_number":orderId,@"appeal_reason":message};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


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
- (void)upLoadIndenityInfo:(NSString*)userId name:(NSString *)name idcard:(NSString*)idcard
                 idCardImg:(NSString*)idCardImg xhCardImg:(NSString*)xhCardImg
                        xH:(NSString*)xH school:(NSString*)school
                   success:(void (^)(NSInteger code))success
                   failure:(void (^)(NSString *info))failure{
    
    NSString *urlStr = KUrlUPloadIndentityInfo;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params =@{@"user_id":userId,@"name":name,@"idcard":idcard,
                    @"card_positive_pic_url":idCardImg,@"card_inverse_pic_url":xhCardImg,
                    @"student_id":xH,@"school_code":@([Common getSchoolCodeWithName:school])};
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            success(1);
        }else{
            failure(info);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}



/**
 *上传用户头像
 */
- (void)upLoadIconImage:(UIImage *)img andUserId:(NSString *)userId
                 success:(void (^)(NSString *iconImgFile))success
                failure:(void (^)(NSString *info))failure{
    /**
     text/plain（纯文本）
     text/html（HTML文档）
     application/xhtml+xml（XHTML文档）
     image/gif（GIF图像）
     image/jpeg（JPEG图像）【PHP中为：image/pjpeg】
     image/png（PNG图像）【PHP中为：image/x-png】
     video/mpeg（MPEG动画）
     application/octet-stream（任意的二进制数据）
     application/pdf（PDF文档）
     application/msword（Microsoft Word文件）
     message/rfc822（RFC 822形式）
     multipart/alternative（HTML邮件的HTML形式和纯文本形式，相同内容使用不同形式表示）
     application/x-www-form-urlencoded（使用HTTP的POST方法提交的表单）
     multipart/form-data（同上，但主要用于表单提交时伴随文件上传的场合）      */
    
    //保存图片到本地
    [self saveImage:[UIImage imageWithData:UIImageJPEGRepresentation(img, 0.5)] withFileName:iconImgName ofType:@"jpg" inDirectory:getIconImgBasePaht];
    //图片的完整路径 -本地保存路径
    NSString *imgFile  = iconImgFilePath;
    //上传的网路的路径
    NSString *urlStr = KUrlUpLoadIconImg;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFormData:[userId dataUsingEncoding:NSUTF8StringEncoding] name:@"id"];
        
        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:imgFile] name:@"image" fileName:iconImgName mimeType:@"image/pjpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
       
        if (isSuccess) {
            NSString *iconImgUrl = responseObject[@"data"][@"head_path"];
           success(iconImgUrl);
        }else{
            failure(info);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

//将所下载的图片保存到本地
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}

////读取本地保存的图片
//-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
//    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
//    
//    return result;
//}


/**
 *获得用户的头像
 */
- (void)getIconImgWithUserInfo:(UserInfo*)userInfo
                       success:(void (^)(UIImage *iconImg))success
                       failure:(void (^)(NSString *info))failure{
    UIImage *iconImage ;
    if (userInfo.iconImageUrl) {
        if ([userInfo.userId isEqualToString:[[Config Instance]getID]]) {
            //获得当前用户的头像
            //读取本地图片
            iconImage = [UIImage imageWithContentsOfFile:iconImgFilePath];
            if (!iconImage) {
                iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,userInfo.iconImageUrl]]]];
                //保存到本地
                [[MyCenterManager shared] saveImage:[UIImage imageWithData:UIImageJPEGRepresentation(iconImage, 0.5)] withFileName:iconImgName ofType:@"jpg" inDirectory:getIconImgBasePaht];
            }
        }else{
            //获取其他用户头像---不保存
            iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,userInfo.iconImageUrl]]]];
        }
        
    }else{
        //显示默认图片
        iconImage = [UIImage imageNamed:@"defalut_logo"];
    }
    
//    return iconImage;
}

+(MyCenterManager*)shared{
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        
        if (!class) {
            
            [[self alloc] init]; //该方法会调用 allocWithZone
        }
        
    }
    
    return  class;
    
}

- (TencentOAuth*)tencent{


//    if (!_tencent) {
        _tencent = [[TencentOAuth alloc] initWithAppId:KOpenQQAppId andDelegate:self.tencentDelegate];
//        }
    
    return _tencent;
}


+(id)allocWithZone:(NSZone *)zone{
    
    @synchronized(self){
        
        if (!class) {
            
            class = [super allocWithZone:zone]; //确保使用同一块内存地址
            
            return class;
            
        }
        
    }
    
    return nil;
    
}



- (id)copyWithZone:(NSZone *)zone;{
    
    return self; //确保copy对象也是唯一
    
}

/**
 *  QQ登陆---QQ登陆回调成功后向后台发起请求--通过QQ注册
 */
- (BOOL)loginWithQQ:(NSDictionary *)dic andOpenId:(NSString*)openId withOption:(void(^)(NSDictionary*))options{
    [self isExit:dic andOpenId:openId withOption:options];
    
    return NO;
}

/**
 *  QQ登陆---判断是否已经注册过
 */
- (BOOL)isExit:(NSDictionary *)dic andOpenId:(NSString*)openId withOption:(void(^)(NSDictionary*))options{
    
    NSString *urlStr = @"http://localhost:8080/ShunDaiAppExtend/isExitForQQ";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:@"qq_openId" forKey:openId];
    //    NSDictionary *params =dic;
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSDictionary *info = [NSString_Json parseJSONStringToNSDictionary: [responseObject objectForKey:@"info"]];
        if (isSuccess) {//QQ用户已经注册过正常登陆----返回用户的信息
            //登陆IM服务
            NSString *paw = EMUserPassword;
            EMError *error =  [[EMClient sharedClient] loginWithUsername:openId password:paw];
            if (!error) {
                NSLog(@"IM Login is Success");
            }else{
                NSLog(@"Login is faild");
            }
            //将用options进行界面跳转和数据存储
            options(info);
            
        }else{
            [self registerWithQQ:dic andOpenId:openId withOption:options];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    return NO;
}

/**
 *  QQ登陆---通过QQ注册
 */
- (BOOL)registerWithQQ:(NSDictionary *)dic andOpenId:(NSString*)openId withOption:(void(^)(NSDictionary*))options{
    
    NSString *urlStr = @"http://localhost:8080/ShunDaiAppExtend/registerForQQ";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:@"pp_openId" forKey:openId];
    [params setValue:@"nick" forKey:dic[@"nickname"]];
    [params setValue:@"head_pic_url" forKey:dic[@"figureurl_2"]];
    //    NSDictionary *params =dic;
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSDictionary *info = [NSString_Json parseJSONStringToNSDictionary: [responseObject objectForKey:@"info"]];
        if (isSuccess) {//注册成功
            //注册环信IM
            NSString *paw = EMUserPassword
            EMError *error = [[EMClient sharedClient] registerWithUsername:openId password:paw];
            if (error==nil) {
                NSLog(@"IM注册成功");
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:error.errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            options(info);
        }else{
            //            NSLog(@"");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    return NO;
}

- (NSMutableArray*)messagesArray{
    if (!_messagesArray) {
        _messagesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"messagesArray"];
        if (!_messagesArray) {
            _messagesArray = [NSMutableArray array];
            [[NSUserDefaults standardUserDefaults] setValue:_messagesArray forKey:@"messagesArray"];
        }
    }
    return  _messagesArray;
}
/**
 *  跟新沙盒的message
 */
- (void)updateMessagesArraydata{
    [[NSUserDefaults standardUserDefaults] setValue:_messagesArray forKey:@"messagesArray"];
}

@end
