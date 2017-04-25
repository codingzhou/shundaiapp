//
//  RegisterViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/11.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTowViewController.h"
#import "MyCenterManager.h"
#import "LaunchViewController.h"

#define UILeftSpace 20;
#define UITopSpace 40;
#define UIControlSpace 15;


@interface RegisterViewController ()
{
    UITextField *_textFphone;
    UITextField *_textFcode;
    UIButton *_getCode;
    NSTimer *_verifyTimer;
    NSInteger seconds;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [Common setNavigationBarRightButtonTitleCenter:self withTitle:@"下一步" withAction:@selector(nextSep)];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    if (self.type == LaunchType_Register ) {
        self.title = @"用户注册";
    }else{
        self.title = @"忘记密码";
    }
    
    
    CGFloat leftS =UILeftSpace;
    CGFloat topS = UITopSpace ;//+ CGRectGetMaxY(self.navigationController.navigationBar.frame);;
    CGFloat uiCS = UIControlSpace;
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(leftS, topS, 0, 0)];
    lblName.text = @"手机号";
    [lblName sizeToFit];
    
    [self.view addSubview:lblName];
    UITextField *textFName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblName.frame) + uiCS, CGRectGetMaxY(lblName.frame) - 25, SCREEN_WIDTH -  120, 35)];
    _textFphone = textFName;
    textFName.keyboardType =UIKeyboardTypePhonePad;
    textFName.backgroundColor = [UIColor whiteColor];
    textFName.layer.masksToBounds = YES;
    textFName.layer.cornerRadius = 5;
    textFName.placeholder = @"手机号";
    [self.view addSubview:textFName];
    
    UILabel *lblPaw =[[UILabel alloc] initWithFrame:CGRectMake(leftS, CGRectGetMaxY(lblName.frame) + uiCS + 15, 0, 0)
                      ];
    lblPaw.text = @"验证码";
    [lblPaw sizeToFit];
    [self.view addSubview:lblPaw];
    
    UITextField *textPaw = [[UITextField alloc] initWithFrame:CGRectMake(textFName.frame.origin.x, CGRectGetMaxY(lblPaw.frame) - 25, textFName.frame.size.width, textFName.frame.size.height)];
    _textFcode = textPaw;
    textPaw.backgroundColor = [UIColor whiteColor];
    textPaw.keyboardType = UIKeyboardTypePhonePad;
    textPaw.layer.masksToBounds = YES;
    textPaw.layer.cornerRadius = 5;
    textPaw.placeholder = @"请输入验证码";
    [self.view addSubview:textPaw];
    
    UIButton *btnGetCode = [[UIButton alloc] init];//WithFrame:];
    _getCode = btnGetCode;
    btnGetCode.backgroundColor = UIColorFromRGB(0x0091d2);
    [btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnGetCode.titleLabel.font = [UIFont systemFontOfSize:14];
    CGSize codeSzie = [@"获取验证码" sizeWithAttributes:@{NSFontAttributeName:btnGetCode.titleLabel.font}];
    btnGetCode.frame = CGRectMake(CGRectGetMaxX(textPaw.frame) - codeSzie.width -10, CGRectGetMaxY(lblPaw.frame) - 23, codeSzie.width + 8, 32);
    [btnGetCode addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGetCode];
    [self.view bringSubviewToFront:btnGetCode];
}

- (void)nextSep
{
    NSString *phone = _textFphone.text;
    NSString *code = _textFcode.text;
    if (![Common isValidateMobile:phone]) {
        [self showWarnMessage:@"手机号有误，请重新填写！！"];
        return;
    }
    if ([code isEqualToString:@""]) {
        [self showWarnMessage:@"请填写验证码！！"];
        return;
    }
    
    [[MyCenterManager shared] checkPhone:phone code:code success:^(NSInteger returnCode) {
        
        //            [[[MyCenterManager alloc] init].requestDic setObject:phone forKey:@"phone"];
        //            [[[MyCenterManager alloc] init].requestDic setObject:code forKey:@"code"];
        RegisterTowViewController *vc = [[RegisterTowViewController alloc] init];
        NSString *phone = _textFphone.text;
        NSString *code = _textFcode.text;
        vc.phone = phone;
        vc.code = code;
        vc.type = self.type;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *info) {
        [self showWarnMessage:info];
    }];
    
}

- (void)getCode{
    NSLog(@"点击获得验证码");
    NSString *phone = _textFphone.text;
    if (![Common isValidateMobile:phone]) {
        [self showWarnMessage:@"手机号有误，请重新填写！！"];
        return;
    }
//    _getCode.userInteractionEnabled = NO;
    [_getCode setEnabled:NO];
    [_textFcode resignFirstResponder];
    [_textFphone resignFirstResponder];
    //检测手机号是否被注册
    [[MyCenterManager shared] isRegisterWithPhone:phone success:
     ^(NSInteger returnCode) {//没有被注册
         [self sendCoddWithPhone:phone];
     } failure:^(NSString *info) {//被注册
         [self showWarnMessage:info];
//         _getCode.userInteractionEnabled = YES;
         [_getCode setEnabled:YES];
     }];
    
}

- (void)sendCoddWithPhone:(NSString *)phone{
    [[MyCenterManager shared] getCode:phone type:0 success:^(NSInteger returnCode) {//发送验证码成功
        [_getCode setTitle:@"重试（60）" forState:UIControlStateNormal];
        
        _verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshBtn) userInfo:nil repeats:YES];
        seconds = 60;
//        _getCode.userInteractionEnabled = NO;
    } failure:^(NSString *info) {//发送验证码失败
//        _getCode.userInteractionEnabled = YES;
//        [_getCode setEnabled:YES];
        [self showWarnMessage:info];
        seconds = -1;
        [self refreshBtn];
    }];
}

- (void)refreshBtn
{
    seconds --;
    if (seconds <= 0) {
        [_verifyTimer invalidate];
        _verifyTimer = nil;
        [_getCode setEnabled:YES];
//        _getCode.userInteractionEnabled = YES;
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        [_getCode setTitle:[NSString stringWithFormat:@"重试（%ld）",seconds] forState:UIControlStateNormal];
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
