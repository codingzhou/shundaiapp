//
//  BaseTabBarVC.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "MainOrederVireController.h"
#import "PublishOrderTableViewController.h"
#import "MyOrderTableViewController.h"
#import "MyCenterTableViewController.h"
#import "CustomNavigationController.h"
#import "LaunchViewController.h"

@interface BaseTabBarVC ()
{
    NSInteger _currentSelectIndex;
}
@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        [self initTabBarView];
    }
    return self;
}


-(void)initTabBarView
{
    self.delegate=self;
    
    _mainVc = [[MainOrederVireController alloc] init];
    _mainVc.title = @"任务大厅";
    _mainVc.tabBarItem.image =  [UIImage imageNamed:@"tab_icon_discover_normal"];
    _mainVc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_icon_discover_focus"];
    [_mainVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    
    _publichVc = [[PublishOrderTableViewController alloc] init];
    _publichVc.title=@"发布任务";
    _publichVc.tabBarItem.image=[UIImage imageNamed:@"tab_icon_chat_normal"];
    _publichVc.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_icon_chat_focus"];
    [_publichVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    
    
     _myOrderVc = [[MyOrderTableViewController alloc] init];
    _myOrderVc.title=@"我的任务";
    _myOrderVc.tabBarItem.image=[UIImage imageNamed:@"tab_icon_contact_normal"];
    _myOrderVc.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_icon_contact_focus"];
    [_myOrderVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    
     _myCenterVc = [[MyCenterTableViewController alloc] init];
    _myCenterVc.title=@"个人中心";
    _myCenterVc.tabBarItem.image=[UIImage imageNamed:@"tab_icon_me_normal"];
    _myCenterVc.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_icon_me_focus"];
    [_myCenterVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    
    
    CustomNavigationController *MainNav,*pulishNav,*myOrderNav,*myCenterNav;
    MainNav = [[CustomNavigationController alloc]initWithRootViewController:_mainVc];
    pulishNav = [[CustomNavigationController alloc] initWithRootViewController:_publichVc];
    myOrderNav = [[CustomNavigationController alloc]initWithRootViewController:_myOrderVc];
    myCenterNav = [[CustomNavigationController alloc]initWithRootViewController:_myCenterVc];
    self.viewControllers = [NSMutableArray arrayWithObjects:
                            pulishNav,
                            myOrderNav,
                            MainNav,
                          myCenterNav,nil];
    self.view.alpha = 1.0;
    [self setSelectedIndex:0];
    //
    _currentSelectIndex = 0;
    //
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CustomNavigationController *nav = (CustomNavigationController *)viewController;
    
    CustomNavigationController *pushNav = [self.viewControllers objectAtIndex:_currentSelectIndex];
    
    if ([nav.topViewController isEqual:_myCenterVc] || [nav.topViewController isEqual:_myOrderVc]) {
        NSInteger isLogin = 2;
        if (isLogin==1) {
            [self setSelectedIndex:_currentSelectIndex];
            LaunchViewController *loginCtl = [[LaunchViewController alloc] init];
            CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:loginCtl];
            loginCtl.hidesBottomBarWhenPushed = YES;
//            AppDelegate *app = ApplicationDelegate;
            ApplicationDelegate.window.rootViewController = nav;
//            [pushNav pushViewController:loginCtl animated:YES];
        }
    } else {
        _currentSelectIndex = self.selectedIndex;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
