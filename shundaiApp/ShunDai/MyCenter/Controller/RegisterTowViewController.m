//
//  RegisterTowViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/11.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "RegisterTowViewController.h"
#import "MyCenterManager.h"
#import "LaunchViewController.h"

#define UILeftSpace 20;
#define UITopSpace 40;
#define UIControlSpace 15;

@interface RegisterTowViewController ()
{
    UITextField *_textFPaw;
    UITextField *_repeatPaw;
}

@end

@implementation RegisterTowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    if (self.type == LaunchType_Register ) {
        self.title = @"用户注册";
    }else{
        self.title = @"修改密码";
    }
    
    CGFloat leftS =UILeftSpace;
    CGFloat topS = UITopSpace ;
    CGFloat uiCS = UIControlSpace;
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(leftS, topS, 0, 0)];
    lblName.text = @"密码";
    [lblName sizeToFit];
    
    [self.view addSubview:lblName];
    UITextField *textFName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblName.frame) + uiCS, CGRectGetMaxY(lblName.frame) - 25, SCREEN_WIDTH -  120, 35)];
    _textFPaw = textFName;
    textFName.keyboardType =UIKeyboardTypePhonePad;
    textFName.secureTextEntry = YES;
    textFName.backgroundColor = [UIColor whiteColor];
    textFName.layer.masksToBounds = YES;
    textFName.layer.cornerRadius = 5;
    textFName.placeholder = @"包含数字和字母且不少于六位";
    [self.view addSubview:textFName];
    
    UILabel *lblPaw =[[UILabel alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(lblName.frame) + uiCS + 15, 0, 0)
                      ];
    lblPaw.text = @"密码";
    [lblPaw sizeToFit];
    [self.view addSubview:lblPaw];
    
    UITextField *textPaw = [[UITextField alloc] initWithFrame:CGRectMake(textFName.frame.origin.x, CGRectGetMaxY(lblPaw.frame) - 25, textFName.frame.size.width, textFName.frame.size.height)];
    _repeatPaw = textPaw;
    textPaw.backgroundColor = [UIColor whiteColor];
    textPaw.keyboardType = UIKeyboardTypePhonePad;
    textPaw.secureTextEntry = YES;
    textPaw.layer.masksToBounds = YES;
    textPaw.layer.cornerRadius = 5;
    textPaw.placeholder = @"请再次输入密码";
    [self.view addSubview:textPaw];
    
    UILabel *lblAgree = [[UILabel alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(textPaw.frame) + uiCS, 0, 0)];
    lblAgree.text = @"注册表示你同意“顺带”服务使用协议和隐私条款";
    lblAgree.font = [UIFont systemFontOfSize:12];
    lblAgree.textColor =[UIColor blueColor];
    [lblAgree sizeToFit];
    lblAgree.userInteractionEnabled =YES;
    [lblAgree addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAgreement)]];
    [self.view addSubview:lblAgree];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(lblAgree.frame) + uiCS + 10, CGRectGetMaxX(textFName.frame) - leftS, 40)];
    btnLogin.backgroundColor = UIColorFromRGB(0x13a8ed);
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (self.type == LaunchType_Register) {
        [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
    }else{
        [btnLogin setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:btnLogin];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 5;
    [btnLogin addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)gotoRegister
{
    NSLog(@"click Register");
    NSString *paw = _textFPaw.text;
    NSString *rePaw = _repeatPaw.text;
    if ([paw isEqualToString:@""] || [rePaw isEqualToString:@""]) {
        [self showWarnMessage:@"请填写完整信息"];
        return;
    }
    if (![paw isEqualToString:rePaw]) {
        [self showWarnMessage:@"两次密码输入不一致"];
        return;
    }
    [_textFPaw resignFirstResponder];
    [_repeatPaw resignFirstResponder];
    NSString *phone = self.phone;//[[[MyCenterManager alloc] init].requestDic objectForKey:@"phone"];
    NSString *code = self.code;//[[[MyCenterManager alloc] init].requestDic objectForKey:@"code"];
    if (self.type == LaunchType_Register) {//注册
        [self showControllerMasterView:@"注册中。。"];
        [[MyCenterManager shared] registerNormal:@"" phone:phone code:code type:0 password:paw success:^(NSInteger returnCode) {
            [self hiddenControllerMaskView];
                NSLog(@"success");
            //注册环信IM
            NSString *paw = EMUserPassword
            EMError *error = [[EMClient sharedClient] registerWithUsername:phone password:paw];
            if (error==nil) {
                NSLog(@"注册成功");
                //登陆顺带
                [LaunchViewController LoginWithPhoe:phone andPaw:paw];
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:error.errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                //登陆顺带
                [LaunchViewController LoginWithPhoe:phone andPaw:paw];
            }
            
//                if ([ApplicationDelegate.window.rootViewController isEqual:ApplicationDelegate.tabBarController]) {
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                } else {
//                    ApplicationDelegate.window.rootViewController = ApplicationDelegate.tabBarController;
//                }
            
        } failure:^(NSString *info) {
            [self hiddenControllerMaskView];
            [self showWarnMessage:info];
        }];
    }else{//忘记或者重置
        [self showControllerMasterView:@"重置密码中。。。"];
        [[MyCenterManager shared] resetPwd:phone password:paw andCode:0 success:^(NSInteger returnCode) {
            [self hiddenControllerMaskView];
            [LaunchViewController LoginWithPhoe:phone andPaw:paw];
        } failure:^(NSString *info) {
            [self hiddenControllerMaskView];
            [self showWarnMessage:info];
        }];
    }
    
    
}

- (void)showAgreement
{
    NSLog(@"click Show Agreement");
    [self showWarnMessage:@"click Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreementclick Show Agreement"];
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
