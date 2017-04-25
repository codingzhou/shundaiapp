//
//  UserInfo.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/21.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "UserInfo.h"
#import "SchoolInfo.h"
#import "common.h"
#import "config.h"

@implementation UserInfo

+ (UserInfo*)userInfoWithDic:(NSDictionary *)dic{
    //    id	用户的主键	guid	所有涉及需要验证身份的操作均需要该参数
    //    phone	手机号	number
    //    password
    //    nick	昵称	string
    //    head_pic_url	头像地址	string
    //    rank	权限值	int	权限值 默认为0 正常登录状态 1为账号锁定不能登录
    //    identity_status	认证信息状态	int	信息认证状态值 0默认没有认证 1已经认证
    //    register_time	注册时间	datetime	例如：2016-05-09 19:40:30
    //    school_name	学校名称	string	例如：贵州财经大学
    //    floor_address	楼层具体名称	string	例如：丹桂苑三栋(男寝)368寝
    //    school_code	学校代码	int	学校代码
    UserInfo *info = [[UserInfo alloc] init];
    info.userId = dic[@"id"];
    info.phone = dic[@"phone"];
    info.paw = dic[@"password"];
    
    info.nickName = dic[@"nick"];
    info.iconImageUrl = dic[@"head_pic_url"];
    
    info.rank = dic[@"rank"];
    info.indentity = [NSString stringWithFormat:@"%@",dic[@"identity_status"]].integerValue;
    info.registerTime = dic[@"register_time"];
    info.address = dic[@"floor_address"];
//    if (dic[@"school_code"]) {
        info.school = [Common getSchoolNameWithCode: [NSString stringWithFormat:@"%@",dic[@"school_code"]].integerValue ];
//    }
    
    
    info.sex = 0;
    
    return info;
}



- (NSDictionary*)getDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:self.userId forKey:@"id"];
    [dic setObject:self.phone forKey:@"phone"];
    [dic setObject:self.paw forKey:@"password"];
    [dic setObject:self.nickName forKey:@"nick"];
    if (self.iconImageUrl) {
         [dic setObject:self.iconImageUrl forKey:@"head_pic_url"];
    }
   
    [dic setObject:self.rank ? self.rank : @""  forKey:@"rank"];
    [dic setObject:self.registerTime forKey:@"register_time"];
     [dic setObject:self.address forKey:@"floor_address"];
//    if (self.school) {
        [dic setObject:@([Common getSchoolCodeWithName:self.school]) forKey:@"school_code"];
//    }
    
    
    [dic setObject:@(self.sex) forKey:@"sex"];
    
    return dic;
}


@end
