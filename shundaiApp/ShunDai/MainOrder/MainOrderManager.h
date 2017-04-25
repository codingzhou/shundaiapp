//
//  MainOrderManager.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/28.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "ManagerBase.h"
#import "orderInfo.h"

@interface MainOrderManager : ManagerBase

/**
 *发布一个新的任务
 */
- (void)publishOrder:(orderInfo *)info
               success:(void (^)(NSInteger returnCode))success
               failure:(void (^)(NSString *info))failure;
/**
 *获得我发布的任务
 userId 用户ID
 state 任务状态 没有这个参数默认查询所有 0已发布还未认领 1表示已经有人领取的任务 2表示领取人已经拿到包裹 3表示已完成的任务
 page 页数
 pageCount 每页数量
 */
- (void)myPublishOrder:(NSString *)userId state:(NSInteger)state
            pageNumber:(NSInteger)number
               success:(void (^)(NSArray *array))success
               failure:(void (^)(NSString *info))failure;

/**
 *获得我领取的任务
 userId 用户ID
 state 任务状态 没有这个参数默认查询所有 0已发布还未认领 1表示已经有人领取的任务 2表示领取人已经拿到包裹 3表示已完成的任务
 page 页数
 pageCount 每页数量
 */
- (void)myReceiveOrder:(NSString *)userId state:(NSInteger)state
            pageNumber:(NSInteger)number
               success:(void (^)(NSArray *array))success
               failure:(void (^)(NSString *info))failure;
/**
 *获得主页数据
 state 任务状态 没有这个参数默认查询所有 0已发布还未认领 1表示已经有人领取的任务 2表示领取人已经拿到包裹 3表示已完成的任务
 page 页数
school 学校
 express 快递公司
 */
- (void)mainOrder:(NSString *)school express:(NSString*)express
            pageNumber:(NSInteger)number
               success:(void (^)(NSArray *array))success
               failure:(void (^)(NSString *info))failure;

/**
 *领取一个任务
 task_id	任务ID	guid
 complete_user_id	任务领取者ID	guid
 */
- (void)receiveOrder:(NSString *)orderId completeUserId:(NSString*) completeIds
          success:(void (^)(orderInfo *info))success
          failure:(void (^)(NSString *info))failure;

/**
 *获得任务的详细信息（需要任务发布者或者领取者）
 task_id	任务ID	guid
 user_id 任务查看着的ID	guid
 */
- (void)getOrderDetial:(NSString *)orderId userId:(NSString*) userId
             success:(void (^)(orderInfo *info))success
             failure:(void (^)(NSString *info))failure;

/**
 *确认收货  *确认收货----派件确认---状态变为2
 task_id	任务主键ID	guid
 launch_user_id	任务发起者ID	guid
 pay_type	支付类型	int	1表示现金支付 2表示支付宝支付 3表示微信支付
 */
- (void)finishOrder:(NSString *)orderId userId:(NSString*)userId
               success:(void (^)(NSInteger code))success
               failure:(void (^)(NSString *info))failure;


/**
 *确认收货
 task_id	任务主键ID	guid
 launch_user_id	任务发起者ID	guid
 pay_type	支付类型	int	1表示现金支付 2表示支付宝支付 3表示微信支付
 */
- (void)finishOrder:(NSString *)orderId userId:(NSString*)userId type:(NSInteger)type
            success:(void (^)(NSInteger code))success
            failure:(void (^)(NSString *info))failure;

/**
 *删除任务
 user_id	用户ID	GUID
 task_id   任务的ID
 */
- (void)deleteOrder:(NSString*)userId  orderId:(NSString *)orderId
            success:(void (^)(NSInteger code))success
            failure:(void (^)(NSString *info))failure;

+(MainOrderManager*)shared;
@end
