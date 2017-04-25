//
//  BaseTabBarVC.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainOrederVireController;
@class PublishOrderTableViewController;
@class MyOrderTableViewController;
@class MyCenterTableViewController;
/**
 * 全局底部选项卡类
 */

@interface BaseTabBarVC : UITabBarController


/**
 *  任务大厅
 */
@property (nonatomic, retain)MainOrederVireController *mainVc;

/**
 *  发布任务
 */
@property(nonatomic,retain)PublishOrderTableViewController *publichVc;

/**
 *  我的任务
 */
@property(nonatomic,retain)MyOrderTableViewController *myOrderVc;

/**
 *  个人中心
 */
@property(nonatomic,retain)MyCenterTableViewController *myCenterVc;
/**
 *  重新加载视图
 */
- (void)reloadTabViews;

@property (nonatomic, assign)NSInteger preViewSelectIndex;
- (void)changeSecondBarWithType:(NSInteger)type;

@end
