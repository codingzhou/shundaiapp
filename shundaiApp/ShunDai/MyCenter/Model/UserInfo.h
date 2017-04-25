//
//  UserInfo.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/21.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
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

    //    id	用户的主键	guid	所有涉及需要验证身份的操作均需要该参数
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *paw;
@property (nonatomic,copy)NSString *nickName;
//性别  0 男  1 女
@property (nonatomic, assign)NSInteger sex;
    //    head_pic_url	头像地址	string
@property (nonatomic,copy)NSString *iconImageUrl;
    //    rank	权限值	int	权限值 默认为0 正常登录状态 1为账号锁定不能登录
@property (nonatomic,copy)NSString *rank;
    //    identity_status	认证信息状态	int	信息认证状态值 0默认没有认证 1已经认证
@property (nonatomic,assign)NSInteger indentity;
@property (nonatomic,copy)NSString *registerTime;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *school;
@property (nonatomic,strong)NSString *mail;

+ (UserInfo*)userInfoWithDic:(NSDictionary *)dic;

- (NSDictionary*)getDictionary;

//+ (NSString*)getSchoolWithId:(NSInteger)schoolId;

@end
