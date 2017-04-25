//
//  BaseViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "BaseViewController.h"
#import "Constant.h"
#import "MyCenterManager.h"



#define kControllerMasterViewTag 1020

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (BOOL)checkLogin{
    
    
    return [[Config Instance] getLoginStatus];
}


- (void)showWarnMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    self.warnV = alert;
    [alert show];
}

- (void)hiddenWarnView{
    [self.warnV removeFromSuperview];
}

- (UIView *)getBackView{
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.baceView = backV;
    //通过设置背景得到透明，且子视图不透明
    //    backV.alpha = 0.3;
    backV.backgroundColor = [UIColorFromRGB(0x0000) colorWithAlphaComponent:0.5];
    
    
    [backV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removerBackView)]];
    
    return backV;
}

- (void)showControllerMasterView:(NSString*)tipMessage
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenControllerMaskView) object:nil];
    
    [self performSelector:@selector(hiddenControllerMaskView) withObject:nil afterDelay:kRequestOverTime];
    
    
    UIView* superView = ApplicationDelegate.window;
    if (superView) {
        UIView* screenMaskView = [superView viewWithTag:kControllerMasterViewTag];
        if (screenMaskView) {
            for (UIView* subView in [screenMaskView subviews]) {
                [subView removeFromSuperview];
            }
            [screenMaskView removeFromSuperview];
        }
        screenMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        screenMaskView.backgroundColor = [UIColor clearColor];
        screenMaskView.tag = kControllerMasterViewTag;
        
        UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, (SCREEN_HEIGHT-150)/2, 150, 150)];
        backgroundImage.image = [UIImage imageNamed:@""];
        backgroundImage.backgroundColor = [UIColor blackColor];
        backgroundImage.alpha = 0.7;
        backgroundImage.layer.masksToBounds = YES;
        backgroundImage.layer.cornerRadius = 8;
        [screenMaskView addSubview:backgroundImage];
        
        
        UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((150-30)/2, 40, 30, 30)];
        
        if (!tipMessage || [tipMessage isEqualToString:@""]) {
            indicator.frame = CGRectMake((140 - 20) / 2.0, (140 - 20) / 2.0, 30, 30);
        } else {
            indicator.frame = CGRectMake((150-30)/2, 40, 30, 30);
        }
        
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [backgroundImage addSubview:indicator];
        [indicator startAnimating];
        
        
        UILabel* tipMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(indicator.frame)+10, 150, 30)];
        tipMessageLabel.backgroundColor = [UIColor clearColor];
        tipMessageLabel.textAlignment = NSTextAlignmentCenter;
        tipMessageLabel.textColor = [UIColor whiteColor];
        tipMessageLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        tipMessageLabel.text = tipMessage;
        [backgroundImage addSubview:tipMessageLabel];
        
        [superView addSubview:screenMaskView];
        
    }
}

- (void)hiddenControllerMaskView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(controllerMaskViewTimeOut) object:nil];
    UIView* superView = ApplicationDelegate.window;
    if (superView) {
        UIView* screenMaskView = [superView viewWithTag:kControllerMasterViewTag];
        if (screenMaskView) {
            [screenMaskView removeFromSuperview];
        }
    }
}

- (void)removerBackView{
    [self.baceView removeFromSuperview];
}

/**
 *从本地获得用户的头像
 */
- (UIImage *)getIconImgWithUserId:(NSString *)userId{
    
    //读取本地图片
    UIImage   *iconImage = [UIImage imageWithContentsOfFile:iconImgFilePath];;
    return iconImage;
}

- (UIImage *)getIconImg{
    
    //读取本地图片
    UIImage   *iconImage = [UIImage imageWithContentsOfFile:iconImgFilePath];;
    return iconImage;
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth//图片压缩，第二个参数为最终宽度
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    NSData *data = UIImagePNGRepresentation(sourceImage);//未压缩
//    NSData *data =UIImageJPEGRepresentation(sourceImage,0.5);//压缩
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
