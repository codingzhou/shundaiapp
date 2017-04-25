//
//  TextViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/6/1.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "TextViewController.h"

#import "AppDelegate.h"

#import <TencentOpenAPI/TencentOAuth.h>

@interface TextViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,TencentSessionDelegate>
{
    TencentOAuth *_tencento;
}

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"QQ登陆" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickQQLogin) forControlEvents:UIControlEventTouchUpInside];
}


- (void)clickQQLogin{
    NSLog(@"loging  ");
   TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:KOpenQQAppId andDelegate:self];
    _tencento = tencentOAuth;
   NSArray  *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t",nil];
    [tencentOAuth authorize:permissions inSafari:NO];
}

//代理方法

- (void)tencentDidLogin{
//    _labelTitle.text = @"登录完成";
    
    if (_tencento.accessToken && 0 != [_tencento.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = _tencento.accessToken;
    }
    else
    {
//        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
//        _labelTitle.text = @"用户取消登录";
    }
    else
    {
//        _labelTitle.text = @"登录失败";
    }
}


-(void)tencentDidNotNetWork
{
//    _labelTitle.text=@"无网络连接，请设置网络";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
