//
//  CustomNavigationController.m
//  BPM
//
//  Created by qinyulun on 16/5/6.
//  Copyright (c) 2016年 贵州
//

#import "CustomNavigationController.h"
#include <objc/runtime.h>


#define kBackBtnWidth    47
#define kBackBtnHeight   32

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self  = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        self.navigationBar.hidden = NO;
//        self.navigationBar.tintColor = UIColorFromRGB(0x13a8ed);
        if (IOS7) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nvcBk"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        } else {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nvcBk"] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.translucent = UIBarStyleDefault;
        }
        self.navigationBar.alpha = 1;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//        if (IOS7) {
//            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//        } else {
//            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
//            self.navigationBar.translucent = UIBarStyleDefault;
//        }
    }
    return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:kHiddenMenu object:nil];
    [super pushViewController:viewController animated:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
//        UIImage* normalImage = [UIImage imageNamed:@"common_navi_left_btn_normal"];
//        UIButton* btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
//        btnBack.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
//        [btnBack setImage:normalImage forState:UIControlStateNormal];
//        [btnBack setImage:normalImage forState:UIControlStateHighlighted];
//        [btnBack addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
//        btnBack.titleLabel.font = [UIFont systemFontOfSize:14];
//        btnBack.titleLabel.shadowOffset = CGSizeMake(0, 1);
//        btnBack.titleLabel.shadowColor = [UIColor grayColor];
//        
//        [btnBack setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [btnBack setTitleShadowColor:[UIColor grayColor] forState:UIControlStateDisabled];
//        [btnBack setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        
//        [btnBack setTitleEdgeInsets:UIEdgeInsetsMake(0,6,0,0)];
//        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
//        if (viewController.navigationItem.leftBarButtonItems.count == 0) {
//            UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//            spaceButtonItem.width = 0;
//            [viewController.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:spaceButtonItem,item,nil]];
//        } else {
//            viewController.navigationItem.leftBarButtonItem =item;
//        }
//    }
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    
//    //右边按钮标题阴影
//    if (viewController.navigationItem.rightBarButtonItem && viewController.navigationItem.rightBarButtonItem.title) {
//        NSString *btnTitle = viewController.navigationItem.rightBarButtonItem.title;
//        UIImage *normalImage = [UIImage imageNamed:@"common_navi_right_btn_normal"];
//        UIImage *pressImage = [UIImage imageNamed:@"common_navi_right_btn_press"];
//        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightBtn.frame = CGRectMake(0, 0,normalImage.size.width, normalImage.size.height);
//        [rightBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
//        [rightBtn setBackgroundImage:pressImage forState:UIControlStateHighlighted];
//        [rightBtn addTarget:viewController action:viewController.navigationItem.rightBarButtonItem.action forControlEvents:UIControlEventTouchUpInside];
//        [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
//        rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//        rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        rightBtn.titleLabel.shadowOffset = CGSizeMake(0, 1);
//        rightBtn.titleLabel.shadowColor = [UIColor grayColor];
//        [rightBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [rightBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateDisabled];
//        [rightBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        
//        UIBarButtonItem* right =  [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//        if (viewController.navigationItem.rightBarButtonItems.count == 0) {
//            UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//            spaceButtonItem.width = -10;
//            [viewController.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:spaceButtonItem,right,nil]];
//        }
//    }
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end
