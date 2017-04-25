//
//  LauchViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "LaunchViewController.h"
#import "RegisterViewController.h"
#import "MyCenterManager.h"
#import "UserInfo.h"
#import "KeyScroll.h"


#define UILeftSpace 15;
#define UITopSpace 20;
#define UIControlSpace 15;


@interface LaunchViewController ()<TencentSessionDelegate>{
    
    UITextField *_textFName;
    UITextField *_textFaw;
    UIView  *_textFieldView;
    /**
     *  QQ授权登陆
     */
    TencentOAuth *_tencent;
}

@end

@implementation LaunchViewController

-(instancetype)init{
    [self initNav];
    return [super init];
    
}
- (void)initNav{
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";

    [self initView];
    //填充上一位登陆者信息
    _textFName.text = [[Config Instance] getPhone];
//    _textFaw.text = [[Config Instance] getPwd];
}


- (void)initView{
    CGFloat leftS =UILeftSpace;
    CGFloat topS = UITopSpace ;//+ CGRectGetMaxY(self.navigationController.navigationBar.frame);;
    CGFloat uiCS = UIControlSpace;
    CGFloat textFieldViewH = 102;
    CGFloat textFieldH = 50;
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, topS, 120, 120)];
    logo.image=[UIImage imageNamed:@"APPlogo"];
    [self.view addSubview:logo];
    //输入框部分
    _textFieldView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logo.frame) + topS, SCREEN_WIDTH, textFieldViewH)];
    _textFieldView.backgroundColor=[UIColor whiteColor];
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor=UIColorFromRGB(0xd9d9d9);
    [_textFieldView addSubview:lineView1];
    UIImageView *imgName = [[UIImageView alloc] initWithFrame:CGRectMake(leftS-4, 3, 2*leftS+2, textFieldH)];
    [_textFieldView addSubview:imgName];
    imgName.image = [UIImage imageNamed:@"login_name"];
    _textFName = [[UITextField alloc] initWithFrame:CGRectMake(3*leftS,1,SCREEN_WIDTH-3*leftS, textFieldH)];
    _textFName.keyboardType = UIKeyboardTypePhonePad;
    _textFName.textColor =UIColorFromRGB(0xc4c7cc);
    _textFName.font=[UIFont systemFontOfSize:18];
    _textFName.backgroundColor=[UIColor whiteColor];
    [_textFName.layer setBorderColor:[UIColor blackColor].CGColor];
    [_textFieldView addSubview:_textFName];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(3*leftS, CGRectGetMaxY(_textFName.frame), SCREEN_WIDTH-3*leftS, 1)];
    lineView2.backgroundColor=UIColorFromRGB(0xd9d9d9);
    [_textFieldView addSubview:lineView2];
     UIImageView *imgPaw = [[UIImageView alloc] initWithFrame:CGRectMake(leftS-5, CGRectGetMaxY(_textFName.frame)+2, 2*leftS, textFieldH)];
    [_textFieldView addSubview:imgPaw];
    imgPaw.image = [UIImage imageNamed:@"login_paw"];
    _textFaw=[[UITextField alloc] initWithFrame:CGRectMake(3*leftS, CGRectGetMaxY(_textFName.frame)+1, _textFName.frame.size.width, textFieldH)] ;
    _textFaw.keyboardType = UIKeyboardTypeASCIICapable;
    _textFaw.secureTextEntry = YES;
    _textFaw.textColor=[UIColor blackColor];
    _textFaw.backgroundColor=[UIColor whiteColor];
    _textFaw.textColor =UIColorFromRGB(0xc4c7cc);
    _textFaw.font=[UIFont systemFontOfSize:18];
    [_textFaw.layer setBorderColor:[UIColor blackColor].CGColor];
    [_textFieldView addSubview:_textFaw];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textFaw.frame), SCREEN_WIDTH, 1)];
    lineView3.backgroundColor=UIColorFromRGB(0xd9d9d9);
    [_textFieldView addSubview:lineView3];
    [self.view addSubview:_textFieldView];
    
    //登陆按钮部分
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(_textFieldView.frame) + uiCS, CGRectGetMaxX(_textFName.frame) - 2*leftS, textFieldH - 10)];
    btnLogin.backgroundColor = UIColorFromRGB(0x13a8ed);
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:btnLogin];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 5;
    [btnLogin addTarget:self action:@selector(gotoMainView) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblForgot = [[UILabel alloc] init];
    lblForgot.text = @"忘记密码";
    lblForgot.font = [UIFont systemFontOfSize:14];
    CGSize forgtoSize = [lblForgot.text sizeWithAttributes:@{NSFontAttributeName:lblForgot.font}];
    lblForgot.frame = CGRectMake(SCREEN_WIDTH - 60 - forgtoSize.width, CGRectGetMaxY(btnLogin.frame) + uiCS, forgtoSize.width, forgtoSize.height);
    [lblForgot addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToForget)]];
    lblForgot.userInteractionEnabled = YES;
    [self.view addSubview:lblForgot];
    
    UILabel *lblRegister = [[UILabel alloc] init];
    lblRegister.text = @"免费注册" ;
    lblRegister.font = [UIFont systemFontOfSize:14];
    CGSize registerSize =[lblRegister.text sizeWithAttributes: @{NSFontAttributeName:lblRegister.font}];
    lblRegister.frame = CGRectMake(60, CGRectGetMaxY(btnLogin.frame) + uiCS, registerSize.width, registerSize.height);
    [self.view addSubview:lblForgot];
    [lblRegister addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRegister)]];
    lblRegister.userInteractionEnabled = YES;
    [self.view addSubview:lblRegister];
    
    //一键登录部分
    UIView *socialView = [[UIView alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(lblRegister.frame) + 50, SCREEN_WIDTH, 150)];
//    socialView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:socialView];
    socialView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *tBottom=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80];
    [socialView.superview addConstraints:@[tWidth,tBottom]];
    [socialView addConstraint:theight];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    lblTitle.text = @"其他社交账号登陆";
    lblTitle.textColor = UIColorFromRGB(0xB3B3B3);
    lblTitle.font = [UIFont systemFontOfSize:12];
    [lblTitle sizeToFit];
    [socialView addSubview:lblTitle];
    CGSize lblS = lblTitle.frame.size;
    CGFloat lbllienW = (SCREEN_WIDTH - lblS.width-10)/2;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(2.5, lblS.height/2, lbllienW, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xB3B3B3);
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - lbllienW-2.5, lblS.height/2, lbllienW, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xB3B3B3);
    lblTitle.frame = CGRectMake(lbllienW+2.5, 0, lblS.width, lblS.height);
    [socialView addSubview:line2];
    [socialView addSubview:line1];
    
    
    UIImageView *qqLoginV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 65)/2,18, 65, 53)];
    qqLoginV.image = [UIImage imageNamed:@"qqlogin"];
    [socialView addSubview:qqLoginV];
    qqLoginV.userInteractionEnabled = YES;
    [qqLoginV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqLogin)]];
}

- (void)gotoMainView{
    
    NSString *phone = _textFName.text;
    NSString *paw = _textFaw.text;
    
    if ([phone isEqualToString:@""]||[paw isEqualToString:@""]) {
        [self showWarnMessage:@"请填写完整信息"];
        return;
    }
    
    if (![Common isValidateMobile:phone]) {
        [self showWarnMessage:@"手机号不正确"];
        return;
    }
    [_textFaw resignFirstResponder];
    [_textFName resignFirstResponder];
    [self LoginWithPhoe:phone andPaw:paw];
}

+ (void)LoginWithPhoe:(NSString *)phone andPaw:(NSString *)paw{
    [[[self alloc] init] LoginWithPhoe:phone andPaw:paw];
}
-(void)LoginWithPhoe:(NSString *)phone andPaw:(NSString *)paw{
    [[Config Instance] savePwd:paw];
    [self showControllerMasterView:@"登陆中"];
   [ [MyCenterManager shared] login:phone pwd:paw success:^(UserInfo *info) {
        [[Config Instance] setLoginStatus:YES];
       [[Config Instance]setUserIdentityState:info.indentity];
       [self hiddenControllerMaskView];
       //保存数据到本地
       [[MyCenterManager shared].requestDic setObject:info forKey:@"userInfo"];
       [[Config Instance] saveID:info.userId];
       [[Config Instance] savePhone:info.phone];
       [[Config Instance] setUserInfo:info];
      // 更新tabBarControl
        ApplicationDelegate.tabBarController = [[BaseTabBarVC alloc] init];
        ApplicationDelegate.tabBarController.view.alpha = 1;
        [ApplicationDelegate.tabBarController setSelectedIndex:2];
       //登陆环信IM服务
       [self LoginIM];
            if ([ApplicationDelegate.window.rootViewController isEqual:ApplicationDelegate.tabBarController]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                ApplicationDelegate.window.rootViewController = ApplicationDelegate.tabBarController;
            }
    } failure:^(NSString *info) {
         [self hiddenControllerMaskView];
         [self showWarnMessage:info];
    }];
}

- (void)goToRegister{
    NSLog(@"Go TO reGister ");
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    registerVc.type = LaunchType_Register;
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)goToForget{
    NSLog(@"Go TO forget ");
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    registerVc.type = LaunchType_Forget;
    [self.navigationController pushViewController:registerVc animated:YES];

}

#pragma mark QQLogin

- (void)qqLogin{
//    NSArray* permissions = [NSArray arrayWithObjects:
//                            kOPEN_PERMISSION_GET_USER_INFO,
//                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                            kOPEN_PERMISSION_ADD_ALBUM,
//                            kOPEN_PERMISSION_ADD_ONE_BLOG,
//                            kOPEN_PERMISSION_ADD_SHARE,
//                            kOPEN_PERMISSION_ADD_TOPIC,
//                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                            kOPEN_PERMISSION_GET_INFO,
//                            kOPEN_PERMISSION_GET_OTHER_INFO,
//                            kOPEN_PERMISSION_LIST_ALBUM,
//                            kOPEN_PERMISSION_UPLOAD_PIC,
//                            kOPEN_PERMISSION_GET_VIP_INFO,
//                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
//                            nil];
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                              kOPEN_PERMISSION_ADD_TOPIC,
                            nil];
     _tencent = [[TencentOAuth alloc] initWithAppId:KOpenQQAppId andDelegate:self];
     [_tencent authorize:permissions inSafari:NO];
}
//代理方法

- (void)tencentDidLogin{
//   [self showWarnMessage:@"登录完成"];
//    if ([ApplicationDelegate.window.rootViewController isEqual:ApplicationDelegate.tabBarController]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } else {
//        ApplicationDelegate.window.rootViewController = ApplicationDelegate.tabBarController;
//    }
    if (_tencent.accessToken && 0 != [_tencent.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        //        _labelAccessToken.text = _tencento.accessToken;
        [_tencent setAccessToken:[_tencent accessToken]] ;
        [_tencent setOpenId:[_tencent openId] ] ;
        [_tencent setExpirationDate:[_tencent expirationDate]] ;
        [_tencent getUserInfo];
    }
    else
    {
        [self showWarnMessage:@"登录不成功 没有获取accesstoken"];
//                _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}


-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        [self showWarnMessage:@"取消QQ登录"];
    }
    else
    {
        [self showWarnMessage:@"登录失败"];
    }
}


-(void)tencentDidNotNetWork
{
     [self showWarnMessage:@"无网络连接，请设置网络"];
}

/**
 * 获取QQ会员信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getVipInfoResponse.exp success
 *          错误返回示例: \snippet example/getVipInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response {
    if (URLREQUEST_SUCCEED == response.retCode&& kOpenSDKErrorSuccess == response.detailRetCode) {
        NSString *paw = [[Config Instance] getPwd];
        NSString *phone = [[Config Instance] getPhone];
        if ([paw isEqualToString:@""]||!paw) {
            paw = @"123456";
        }
        if ([phone isEqualToString:@""]||!phone) {
            phone = @"15685412820";
        }
        [self LoginWithPhoe:phone andPaw:paw];
        
        
        //NSLog(@"%@",_tencent.accessToken);
        //NSLog(@"%@",_tencent.openId);
//         [self showControllerMasterView:@"登陆中"];
//        [[MyCenterManager shared] loginWithQQ:response.jsonResponse andOpenId:_tencent.openId withOption:^(NSDictionary *userInfo) {
//            [self hiddenControllerMaskView];
//               [self showWarnMessage:@"登录成功"];
//            //保存数据到本地
//             UserInfo *info = [UserInfo userInfoWithDic:userInfo];
//            [[MyCenterManager shared].requestDic setObject:userInfo forKey:@"userInfo"];
//            [[Config Instance] saveID:info.userId];
//            [[Config Instance] savePhone:info.phone];
//            [[Config Instance] setUserInfo:info];
//            // 更新tabBarControl
//            ApplicationDelegate.tabBarController = [[BaseTabBarVC alloc] init];
//            ApplicationDelegate.tabBarController.view.alpha = 1;
//            [ApplicationDelegate.tabBarController setSelectedIndex:2];
//            if ([ApplicationDelegate.window.rootViewController isEqual:ApplicationDelegate.tabBarController]) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            } else {
//                ApplicationDelegate.window.rootViewController = ApplicationDelegate.tabBarController;
//            }
//                if ([ApplicationDelegate.window.rootViewController isEqual:ApplicationDelegate.tabBarController]) {
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                } else {
//                    ApplicationDelegate.window.rootViewController = ApplicationDelegate.tabBarController;
//                }
//        }];
    }
}

- (void)LoginIM{
    NSString *paw = EMUserPassword;
    EMError *error =  [[EMClient sharedClient] loginWithUsername:[[Config Instance] getPhone] password:paw];
    if (!error) {
        NSLog(@"IM Login is Success");
    }else{
        NSLog(@"Login is faild");
    }
}


@end
