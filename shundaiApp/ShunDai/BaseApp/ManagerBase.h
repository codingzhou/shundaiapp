//
//  ManagerBase.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "Constant.h"
#import <AFNetworking/AFNetworking.h>
#import "Common.h"

/**
 *  管理器基类，所有管理器必须继承该类
 */
@interface ManagerBase : NSObject


/**
 *  重置内存接口，当收到内存警告时，调用该接口并通知所有子类，调用resetData,所有子类需要重写该接口并写上释放内存代码
 */
- (void)resetData;

/**
 *获得单例
 */
+ (instancetype*)shared;

@end
