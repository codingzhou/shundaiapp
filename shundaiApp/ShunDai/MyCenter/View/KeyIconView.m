//
//  KeyIconView.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/31.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "KeyIconView.h"
#import "MyCenterManager.h"
#import "Config.h"

@implementation KeyIconView

- (void)setIconImgUrl:(NSString *)iconImgUrl{
    _iconImgUrl = iconImgUrl;
    
    [self performSelector:@selector(changeSelfImage)];
}

- (void)changeSelfImage{
    self.image = [self getIconImgWithUserIconUrl:_iconImgUrl];
    NSLog(@"头像设置完成");
}

/**
*获得用户的头像
*/

- (UIImage *)getIconImgWithUserIconUrl:(NSString*)userIconUrl{
UIImage *iconImage ;
if (userIconUrl) {
if ([userIconUrl isEqualToString:[[Config Instance]getID]]) {
//获得当前用户的头像
//读取本地图片
iconImage = [UIImage imageWithContentsOfFile:iconImgFilePath];;
if (!iconImage) {
iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,userIconUrl]]]];
//保存到本地
[[MyCenterManager shared] saveImage:[UIImage imageWithData:UIImageJPEGRepresentation(iconImage, 0.5)] withFileName:iconImgName ofType:@"jpg" inDirectory:getIconImgBasePaht];
}
}else{
    //获取其他用户头像---不保存
    iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,userIconUrl]]]];
}
    
}else{
    //显示默认图片
    iconImage = [UIImage imageNamed:@"defalut_logo"];
}
    
    return iconImage;
}

@end
