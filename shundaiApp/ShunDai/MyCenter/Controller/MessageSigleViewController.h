//
//  MessageSigleViewController.h
//  ShunDai
//
//  Created by Mac_key on 17/2/11.
//  Copyright © 2017年 com.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *继承EaseUI
 */
@interface MessageSigleViewController : EaseMessageViewController

/**
 *当前聊天对象的ID
 */
@property (nonatomic,copy) NSString *userID;
/**
 *当前聊天对象的昵称
 */
@property (nonatomic,copy) NSString *userName;


@end
