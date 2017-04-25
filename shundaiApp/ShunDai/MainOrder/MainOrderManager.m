//
//  MainOrderManager.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/28.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MainOrderManager.h"

#define pageCount 10;

static MainOrderManager *class = nil;
@implementation MainOrderManager

//发布任务
- (void)publishOrder:(orderInfo *)info
             success:(void (^)(NSInteger returnCode))success
             failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlPublishOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = [info getDictionary];
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

- (NSDictionary *)getPublishDicWith:(NSDictionary *)dic{
    
    NSMutableDictionary * pubDic = [NSMutableDictionary dictionary];
    [pubDic setValue:dic[@"launch_user_id"] forKey:@"launch_user_id"];
    [pubDic setValue:dic[@"receive_express_phone"] forKey:@"receive_express_phone"];
    [pubDic setValue:dic[@"express_code"] forKey:@"express_code"];
    [pubDic setValue:dic[@"receive_address"] forKey:@"receive_address"];
    [pubDic setValue:dic[@"express_info"] forKey:@"express_info"];
    [pubDic setValue:dic[@"expect_money"] forKey:@"expect_money"];
    [pubDic setValue:dic[@"express_weight"] forKey:@"express_weight"];
    [pubDic setValue:dic[@"express_size"] forKey:@"express_size"];
    [pubDic setValue:dic[@"express_depict"] forKey:@"express_depict"];
//    NSString *value =[NSString stringWithFormat:@"%@",dic[@"school_code"]];
//    [pubDic setValue:value forKey:@"school_code"];
    [pubDic setValue:dic[@"school_code"] forKey:@"school_code"];
    return pubDic;
}

//获得主页数据
- (void)mainOrder:(NSString *)school express:(NSString*)express
       pageNumber:(NSInteger)number
          success:(void (^)(NSArray *array))success
          failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlDownMainOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger pageSize = pageCount;
    [params setValue:@(pageSize) forKey:@"page_size"];
    [params setValue:@(0) forKey:@"status"];
    if ([Common getSchoolCodeWithName:school]) {
        [params setValue:@([Common getSchoolCodeWithName:school]) forKey:@"school_code"];
    }
    if ([Common getExpressCodeWithName:express]) {
        [params setValue:@([Common getExpressCodeWithName:express]) forKey:@"express_code"];
    }
    if (number) {
        [params setValue:@(number) forKey:@"page"];
    }
    
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            NSArray *array = responseObject[@"data"];
            NSMutableArray *orders = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                orderInfo *info = [orderInfo getOrderInfoWithDic:dic];
                [orders addObject:info];
            }
            success(orders);
        }else{
            failure(info);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
//        failure(error);
    }];
}

//获得我发布的任务
- (void)myPublishOrder:(NSString *)userId state:(NSInteger)state
            pageNumber:(NSInteger)number
               success:(void (^)(NSArray *array))success
               failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlDownMyPublisOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; //@{@"launch_user_id":userId,@"status":@(state),@"page":@(number),@"page_size":@(pagecount)};
    NSInteger pageSize = pageCount;
    [params setValue:@(pageSize) forKey:@"page_size"];
    [params setValue:userId forKey:@"launch_user_id"];
    if (number) {
        [params setValue:@(number) forKey:@"page"];
    }
//    if (state) {
//        [params setValue:@(state) forKey:@"status"];
//    }
    
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            NSArray *array = responseObject[@"data"];
            NSMutableArray *orders = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                orderInfo *info = [orderInfo getOrderInfoWithDic:dic];
                [orders addObject:info];
            }
            success(orders);
        }else{
            failure(info);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
//        failure(error);
    }];
}
//获得我领取的任务
- (void)myReceiveOrder:(NSString *)userId state:(NSInteger)state pageNumber:(NSInteger)number success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    NSString *urlStr = KUrlMyReceive;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; //@{@"launch_user_id":userId,@"status":@(state),@"page":@(number),@"page_size":@(pagecount)};
    NSInteger pageSize = pageCount;
    [params setValue:@(pageSize) forKey:@"page_size"];
    [params setValue:userId forKey:@"complete_user_id"];
    if (number) {
        [params setValue:@(number) forKey:@"page"];
    }
    if (state) {
        [params setValue:@(state) forKey:@"status"];
    }
    
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            NSArray *array = responseObject[@"data"];
            NSMutableArray *orders = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                orderInfo *info = [orderInfo getOrderInfoWithDic:dic];
                [orders addObject:info];
            }
            success(orders);
        }else{
            failure(info);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //        failure(error);
    }];
}

/**
 *领取一个任务
 task_id	任务ID	guid
 complete_user_id	任务领取者ID	guid
 */
- (void)receiveOrder:(NSString *)orderId completeUserId:(NSString*) completeIds
             success:(void (^)(orderInfo *info))success
             failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlReceivedOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"task_id":orderId,@"complete_user_id":completeIds};
    
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
            orderInfo *info = [orderInfo getOrderInfoWithDic:responseObject[@"data"]];
            success(info);
        }else{
            failure(info);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //        failure(error);
    }];
}

/**
 *获得任务的详细信息（需要任务发布者或者领取者）
 task_id	任务ID	guid
 user_id 任务查看着的ID	guid
 */
- (void)getOrderDetial:(NSString *)orderId userId:(NSString*) userId
             success:(void (^)(orderInfo *info))success
             failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlOrderDetail;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"task_id":orderId,@"user_id":userId};
    
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = (NSString *)[responseObject objectForKey:@"status"];
        BOOL isSuccess = status.intValue;
        NSString *info = [responseObject objectForKey:@"info"];
        if (isSuccess) {
             NSMutableDictionary *orderDic = [NSMutableDictionary dictionary];
            NSDictionary *data = [responseObject objectForKey:@"data"];
//            NSDictionary *dicstatus = data[@"task_detail"]; 
            [orderDic setValuesForKeysWithDictionary:data[@"task_status"][0]];
            [orderDic setValuesForKeysWithDictionary:data[@"task_detail"]];
            orderInfo *order = [orderInfo getOrderInfoWithDic:orderDic];
            success(order);
        }else{
            failure(info);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //        failure(error);
    }];
}


/**
 *确认收货----派件确认---状态变为2
 task_id	任务主键ID	guid
 launch_user_id	任务发起者ID	guid
 pay_type	支付类型	int	1表示现金支付 2表示支付宝支付 3表示微信支付
 */
- (void)finishOrder:(NSString *)orderId userId:(NSString*)userId
            success:(void (^)(NSInteger code))success
            failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlUFinishOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"task_id":orderId,@"complete_user_id":userId};
    
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
        //        failure(error);
    }];
}



/**
 *删除任务
 user_id	用户ID	GUID
 task_id   任务的ID
 */
- (void)deleteOrder:(NSString*)userId  orderId:(NSString *)orderId
            success:(void (^)(NSInteger code))success
            failure:(void (^)(NSString *info))failure{
    NSString *urlStr = KUrlUDeleteOrder;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params =@{@"user_id":userId,@"task_id":orderId};
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


+(MainOrderManager*)shared{
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        if (!class) {
            [[self alloc] init]; //该方法会调用 allocWithZone
            
        }
        
    }
    return  class;
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

@end
