//
//  OrderDetailViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "BaseViewController.h"
#import "MyOrderTableViewController.h"

typedef enum {
    Type_Order_MyPublic = 0,
    Type_Order_MyReceivd = 1
};

@class orderInfo;
@interface OrderDetailViewController : BaseViewController

@property (nonatomic,strong)NSString *orderId;

@property (nonatomic, assign)NSInteger type;
//@property (nonatomic,strong)orderInfo *orderInfo;

@property (nonatomic,strong)NSString *userIconUrl;

@property (nonatomic,strong)NSString *receiveName;

@property (nonatomic,strong)NSString *receivePhone;

@property (nonatomic,strong)MyOrderTableViewController *superVc;

/**
 *聊天的对方ID
 */
@property (nonatomic,strong)NSString *aimId;

/**
 *聊天的对方昵称
 */
@property (nonatomic,strong)NSString *aimName;

@end
