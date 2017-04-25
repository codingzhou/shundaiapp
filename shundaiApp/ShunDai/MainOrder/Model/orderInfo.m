//
//  orderInfo.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/27.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "orderInfo.h"
#import "common.h"

@implementation orderInfo

+ (orderInfo *)getOrderInfoWithDic:(NSDictionary *)dic{
    orderInfo *info = [[orderInfo alloc] init];
    
    info.userId = dic[@"launch_user_id"];
    info.userName = dic[@"launch_user_name"];
    info.userPhone = dic[@"launch_phone"];
    
    info.completeId = dic[@"complete_user_ids"];
     info.completePhone = [dic[@"complete_user_phone"] isKindOfClass:[NSNull class]] ? @"": dic[@"complete_user_phone"];
    info.completeName = [dic[@"complete_user_nick"] isKindOfClass:[NSNull class]] ? @"":dic[@"complete_user_nick"];

    info.userIconImgUrl = dic[@"launch_user_head_pic_url"];

    info.orderId = dic[@"id"];
    info.orderNumber = dic[@"task_number"];
    NSInteger school =[NSString stringWithFormat:@"%@",dic[@"school_code"]].integerValue;
    info.school = [Common getSchoolNameWithCode:school];
    info.schoolStr = dic[@"school_name"];
    info.orderPhone = dic[@"receive_express_phone"];
    info.orderName = dic[@"receive_express_name"];
    NSInteger express =[NSString stringWithFormat:@"%@",dic[@"express_code"]].integerValue;
    info.expressName = [Common getExpressNameWithCode:express];
    info.expressNameStr = dic[@"express_name"];
    info.address = dic[@"receive_address"];
    info.message = dic[@"express_info"];
    info.remake = dic[@"express_depict"];
    info.value = dic[@"expect_money"];
    NSString *strState = dic[@"express_status"];
    info.state = strState.integerValue;
    info.stateDepict = dic[@"task_depict"];
    info.launchTime = dic[@"launch_time"];
    info.completeTime = dic[@"complete_time"];

    return info;
}

-(NSDictionary*)getDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.userId forKey:@"launch_user_id"];
    [dic setValue:self.userName forKey:@"launch_user_name"];
    [dic setValue:self.userPhone forKey:@"launch_phone"];
    if (self.completeId) {
        [dic setValue:self.completeId forKey:@"asd"];
    }
    if (self.completePhone) {
         [dic setValue:self.completePhone forKey:@"asdf"];
    }
    if (self.orderId) {
       [dic setValue:self.orderId forKey:@"id"];
    }
    if (self.school) {
        [dic setValue:@([Common getSchoolCodeWithName:self.school])forKey:@"school_code"];
    }
    
    if (self.orderPhone) {
       [dic setValue:self.orderPhone forKey:@"receive_express_phone"];
    }
    if (self.orderName) {
        [dic setValue:self.orderName forKey:@"receive_express_nam"];
    }
    if (self.expressName) {
        [dic setValue:@([Common getExpressCodeWithName:self.expressName]) forKey:@"express_code"];
    }
    if (self.address) {
         [dic setValue:self.address forKey:@"receive_address"];
    }
    if (self.message) {
       [dic setValue:self.message forKey:@"express_info"];
    }
    if (self.remake) {
        [dic setValue:self.remake forKey:@"express_depict"];
    }
    if (self.value) {
       [dic setValue:self.value forKey:@"expect_money"];
    }
    if (self.state) {
         [dic setValue:@(self.state) forKey:@"express_status"];
    }
    if (self.stateDepict) {
       [dic setValue:self.stateDepict forKey:@"task_depict"];
    }
    if (self.launchTime) {
        [dic setValue:self.launchTime forKey:@"launch_time"];
    }
    if (self.completeTime) {
        [dic setValue:self.completeTime forKey:@"complete_time"];
    }
    if (self.orderNumber) {
        [dic setValue:self.orderNumber forKey:@"task_number"];
    }
    
    if (self.userIconImgUrl) {
        [dic setValue:self.userIconImgUrl forKey:@"launch_user_head_pic_url"];
    }
    
    return dic;
}


@end
