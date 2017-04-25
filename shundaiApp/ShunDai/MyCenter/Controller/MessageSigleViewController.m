//
//  MessageSigleViewController.m
//  ShunDai
//
//  Created by Mac_key on 17/2/11.
//  Copyright © 2017年 com.ios. All rights reserved.
//

#import "MessageSigleViewController.h"
#import "MyCenterManager.h"

@implementation MessageSigleViewController

/*!
 @method
 @brief 添加消息
 @discussion
 @param message 聊天消息类
 @param progress 聊天消息发送接收进度条
 @result
 */
- (void)addMessageToDataSource:(EMMessage *)message
                      progress:(id)progress{
    [super addMessageToDataSource:message progress:progress];
//    self.na
    //更新最近消息列表
    //NSLog(@"更新最近消息列表+%@++%@",self.userID,self.title);
    [self updateMessage:self.userID andName:self.title];
}

- (void)updateMessage:(NSString *)userId andName:(NSString *)userName{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userId forKey:@"userId"];
    [dic setValue:userName forKey:@"userName"];
    [array addObject:dic];
    NSMutableArray *oldArray =  [MyCenterManager shared].messagesArray;
    for (NSDictionary *olddic in oldArray) {
        NSString *oldUserId = [olddic valueForKey:@"userId"];
        if (![oldUserId isEqualToString:userId]) {
            [array addObject:olddic];
        }
    }
    [MyCenterManager shared].messagesArray = array;
    
    [[MyCenterManager shared] updateMessagesArraydata];
}

- (instancetype)initWithConversationChatter:(NSString *)conversationChatter conversationType:(EMConversationType)conversationType{
    self.userID = conversationChatter;
    return  [super initWithConversationChatter:conversationChatter conversationType:conversationType];
}



@end
