//
//  orderInfo.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/27.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderInfo : NSObject

//id	任务主键	guid
//launch_user_id	发起者ID	guid
//launch_user_name	发起者昵称	string
//launch_time	任务发起时间	time
//express_name	快递公司名称	string
//receive_address	收件详细地址	string
//express_weight	快递重量	string
//express_size	快递大小	string
//express_depict	快递描述	string
//expect_money	运费	double
//school_name	学校名称	string
//express_status	包裹现在所处状态	int	0表示任务没人接 1表示已经有人领取任务 2表示领取人已经拿到包裹 3表示已经收件
//task_status_id	任务状态表主键	int
//express_task_id	任务主键	guid
//task_time	任务状态发生时间	time
//task_status	任务状态码	int
//task_depict	任务状态描述	string	示例： 认证用户: 2016050911_4540 (13595344540)领取了您的任务

/**
 *任务发起者ID
 */
@property (nonatomic,strong)NSString *userId;
/**
 *任务发起者昵称
 */
@property (nonatomic,strong)NSString *userName;

/**
 *任务发起者头像
 */
@property (nonatomic,strong)NSString *userIconImgUrl;

/**
 *发布者手机
 */
@property (nonatomic,strong)NSString *userPhone;

/**
 *领取者ID
 */
@property (nonatomic,strong)NSString *completeId;
/**
 *领取者手机
 */
@property (nonatomic,strong)NSString *completePhone;
/**
 *领取者姓名
 */
@property (nonatomic,strong)NSString *completeName;

/**
 *任务ID
 */
@property (nonatomic, copy)NSString *orderId;
/**
 *任务单号
 */
@property (nonatomic, copy)NSString *orderNumber;
/**
 *快递所在学校
 */
@property (nonatomic,strong)NSString *school;
/**
 *快递所在学校--服务器返回的名字
 */
@property (nonatomic,strong)NSString *schoolStr;
/**
 *快递领取号码
 */
@property (nonatomic,strong)NSString *orderPhone;
/**
 *快递领取号码
 */
@property (nonatomic,strong)NSString *orderName;
/**
 *快递公司名字
 */
@property (nonatomic,strong)NSString *expressName;
/**
 *快递公司名字--服务器返回的名字
 */
@property (nonatomic,strong)NSString *expressNameStr;
/**
 *送货地址
 */
@property (nonatomic,strong)NSString *address;
/**
 *快递短信
 */
@property (nonatomic,strong)NSString *message;
/**
 *订单酬劳
 */
@property (nonatomic,strong)NSString *value;
/**
 *备注
 */
@property (nonatomic,strong)NSString *remake;
/**
 *任务状态  0表示任务没人接 1表示已经有人领取任务 2表示领取人已经拿到包裹 3表示正在送达 4表示任务完成已经拿到包裹
 */
@property (nonatomic, assign)NSInteger state;
/**
 *任务状态描述
 */
@property (nonatomic,strong)NSString *stateDepict;

/**
 *任务发时间
 */
@property (nonatomic,strong)NSString *launchTime;
/**
 *完成时间
 */
@property (nonatomic,strong)NSString *completeTime;

+ (orderInfo *)getOrderInfoWithDic:(NSDictionary*)dic;

- (NSDictionary*)getDictionary;

@end
