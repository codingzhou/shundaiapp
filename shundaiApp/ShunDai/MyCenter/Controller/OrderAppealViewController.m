//
//  OrderAppealViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "OrderAppealViewController.h"
#import "MyCenterManager.h"

@interface OrderAppealViewController ()<UIAlertViewDelegate>
{
    UITextField *_orderNumber;
    UITextView *_appealContent;
}

@end

@implementation OrderAppealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务申诉";
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    
    self.view.backgroundColor = kCommAppbackgroundColor;
    
    UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 0, 0)];
    lblNumber.font = [UIFont systemFontOfSize:16];
    lblNumber.text = @"任务单号:";
    [lblNumber sizeToFit];
    [self.view addSubview:lblNumber];
    UITextField *orderF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblNumber.frame) + 10, 20,SCREEN_WIDTH -  CGRectGetMaxX(lblNumber.frame) -20 , 30)];
    _orderNumber = orderF;
    if (self.orderNum) {
        _orderNumber.text = self.orderNum;
    }
    orderF.backgroundColor = [UIColor whiteColor];
    orderF.placeholder = @"请填写需要申诉的任务单号";
    orderF.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:orderF];
    
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblNumber.frame) + 40, 0, 0)];
    lblContent.text = @"申诉内容:";
    lblContent.font = [UIFont systemFontOfSize:16];
    [lblContent sizeToFit];
    [self.view addSubview:lblContent];
    UITextView *contentV = [[UITextView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(lblContent.frame) + 5, SCREEN_WIDTH - 2, 180)];
    contentV.backgroundColor = [ UIColor whiteColor];
    _appealContent = contentV;
    [self.view addSubview:contentV];
    
    UILabel *lblWarn = [[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetMaxY(contentV.frame) + 10, SCREEN_WIDTH - 5, 60)];
    lblWarn.font = [UIFont systemFontOfSize:12];
    lblWarn.textColor = [UIColor grayColor];
    lblWarn.numberOfLines = 0;
    lblWarn.text = @"提示:如若对任务存在疑问，可先联系任务领取者协商解决。如无法协商解决或任务领取者无法处理可提价任务申诉。顺带工作人员会在2个工作日内对您的申诉进行处理。";
    [self.view addSubview:lblWarn];
    
    UIButton *btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 160, SCREEN_WIDTH - 40, 30)];
    btnSubmit.backgroundColor = UIColorFromRGB(0x0091d2);
    btnSubmit.layer.masksToBounds = YES;
    btnSubmit.layer.cornerRadius = 10;
    [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnSubmit];
    [btnSubmit addTarget:self action:@selector(submitAppeal) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submitAppeal{
    NSString *orderId = _orderNumber.text;
    NSString *message = _appealContent.text;
    if ([orderId isEqualToString:@""] || [message isEqualToString:@""]) {
        [self showWarnMessage:@"请填写完整信息！！！"];
        return;
    }
    [self showControllerMasterView:@"提交中..."];
    [[MyCenterManager shared] upLoadAppealInfo:[[Config Instance] getID] orderId:orderId appealMessage:message success:^(NSInteger code) {
        [self hiddenControllerMaskView];
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"任务申诉成功，‘顺带’工作人员会在两个工作日内进行处理 ！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        [self showWarnMessage:info];
    }];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
