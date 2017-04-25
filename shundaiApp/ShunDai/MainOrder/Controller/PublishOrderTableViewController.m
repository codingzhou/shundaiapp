//
//  PublishOrderTableViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "PublishOrderTableViewController.h"
#import "UserInfo.h"
#import "orderInfo.h"
#import "MainOrderManager.h"
#import "MainOrederVireController.h"


@interface PublishOrderTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    UITextField *_orderPhone;
    UITextField *_contactPhone;
    UILabel *_school;
    UILabel *_company;
    UITextView *_message;
    UITextField *_toAddress;
    UITextField *_money;
    UITextField *_orderName;
    
    UserInfo *_userInfo;
    
    NSMutableArray *_vauels;
    
    UIPickerView *_pickerView;
    
    NSString *_shooolExpressV;
}

@end

@implementation PublishOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布任务";
    [self initData];
    [self initView];
}

- (void)initData{
    _userInfo = [[Config Instance] getUserInfo];
    if (!_userInfo) {
        NSString *userId = [[Config Instance] getID];
        NSLog(@"%@",userId);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initView];
}

- (void)initView{
    UIScrollView *backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = kCommAppbackgroundColor;
    [self.view addSubview:backView];
    CGFloat baseVW = SCREEN_WIDTH - 2;
    CGFloat textW = baseVW - 80;
    UIView *baseV = [[UIView alloc] initWithFrame:CGRectMake(1, 5, baseVW, 205)];
    baseV.layer.borderWidth = 1;
    baseV.layer.borderColor = [UIColor grayColor].CGColor;
    [backView addSubview:baseV];
    
    baseV.backgroundColor = [UIColor whiteColor];
    _contactPhone = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, textW, 40)];
    [baseV addSubview:_contactPhone];
    _contactPhone.keyboardType = UIKeyboardTypePhonePad;
    UILabel *lblCtPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 40)];
    _contactPhone.text = _userInfo.phone;
    _contactPhone.font = [UIFont systemFontOfSize:14];
    lblCtPhone.text = @"联系手机:";
    //    lblCtPhone.backgroundColor = [UIColor greenColor];
    lblCtPhone.font = [UIFont systemFontOfSize:14];
    [backView addSubview:lblCtPhone];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, baseVW, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [baseV addSubview:line1];
    
    _orderPhone = [[UITextField alloc] initWithFrame:CGRectMake(90, 41, textW - 5, 40)];
    [baseV addSubview:_orderPhone];
    _orderPhone.keyboardType = UIKeyboardTypePhonePad;
    UILabel *lblOrPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 80, 40)];
    lblOrPhone.text = @"收货人手机:";
    //    lblOrPhone.backgroundColor = [UIColor greenColor];
    _orderPhone.placeholder = @"请填写快递预留号码";
    _orderPhone.font = [UIFont systemFontOfSize:14];
    lblOrPhone.font = [UIFont systemFontOfSize:14];
    [backView addSubview:lblOrPhone];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 81, baseVW, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [baseV addSubview:line2];
    
    _orderName = [[UITextField alloc] initWithFrame:CGRectMake(90, 82, textW - 5, 40)];
    [baseV addSubview:_orderName];
    _orderName.font = [UIFont systemFontOfSize:14];
    _orderName.placeholder = @"请填写快递预留名字";
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 82, 80, 40)];
    lblName.text = @"收货人姓名:";
    //    lblCompany.backgroundColor = [UIColor greenColor];
    lblName.font = [UIFont systemFontOfSize:14];
    [baseV addSubview:lblName];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 122, baseVW, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [baseV addSubview:line3];
    
    _school = [[UILabel alloc] initWithFrame:CGRectMake(80, 123, textW, 40)];
    [baseV addSubview:_school];
    UIView *schoolV = [[UIView alloc] initWithFrame:CGRectMake(80, 123, textW, 40)];
    schoolV.backgroundColor = [UIColor clearColor];
    [baseV addSubview:schoolV];
    schoolV.userInteractionEnabled =YES;
    [schoolV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCheckSchool)]];
    
    _school.font = [UIFont systemFontOfSize:14];
    UILabel *lblSchool = [[UILabel alloc] initWithFrame:CGRectMake(10, 128, 80, 40)];
    lblSchool.text = @"取货学校:";
    _school.text = _userInfo.school;
    //    lblCompany.backgroundColor = [UIColor greenColor];
    lblSchool.font = [UIFont systemFontOfSize:14];
    [backView addSubview:lblSchool];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 163, baseVW, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [baseV addSubview:line4];
    
    
    _company = [[UILabel alloc] initWithFrame:CGRectMake(80, 164, textW, 40)];
    [baseV addSubview:_company];
    UIView *companyV = [[UIView alloc] initWithFrame:CGRectMake(80, 164, textW, 40)];
    companyV.backgroundColor = [UIColor clearColor];
    [baseV addSubview:companyV];
    companyV.userInteractionEnabled =YES;
    [companyV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCheckCompany)]];
    UILabel *lblCompany = [[UILabel alloc] initWithFrame:CGRectMake(10, 169, 80, 40)];
    lblCompany.text = @"快递公司:";
    _company.font = [UIFont systemFontOfSize:14];
    //    lblCompany.backgroundColor = [UIColor greenColor];
    lblCompany.font = [UIFont systemFontOfSize:14];
    [backView addSubview:lblCompany];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, 204, baseVW, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [baseV addSubview:line5];
    //
    //取货地址
    //    UILabel *lblGetAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(baseV.frame) + 10, 0, 0)];
    //    lblGetAddress.text = @"取货地址";
    //    lblGetAddress.font = [UIFont systemFontOfSize:14];
    //    [lblGetAddress sizeToFit];
    //    [backView addSubview:lblGetAddress];
    
    //    UIButton *btncGetadd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CGRectGetMaxY(baseV.frame) + 10, 70, 20)];
    ////    btncGetadd.layer.borderWidth = 1;
    //    btncGetadd.backgroundColor = [UIColor whiteColor];
    //    [btncGetadd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [btncGetadd setTitle:@"选取地址" forState:UIControlStateNormal];
    //    [btncGetadd addTarget:self action:@selector(sleGetAddress) forControlEvents:UIControlEventTouchUpInside];
    //    btncGetadd.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [backView addSubview:btncGetadd];
    //    _getAddress = [[UITextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(lblGetAddress.frame) + 5, baseVW, 40)];
    //    _getAddress.layer.borderColor = [UIColor grayColor].CGColor;
    //    _getAddress.layer.borderWidth = 1;
    //    _getAddress.backgroundColor = [UIColor whiteColor];
    //    _getAddress.placeholder = @"请填写或选取取货地址";
    //    _getAddress.font = [UIFont systemFontOfSize:14];
    //    _getAddress.textAlignment = NSTextAlignmentJustified;
    //
    //    [backView addSubview:_getAddress];
    
    //收货地址
    UILabel *lblToAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(baseV.frame) + 10, 0, 0)];
    lblToAddress.text = @"收货地址";
    lblToAddress.font = [UIFont systemFontOfSize:14];
    [lblToAddress sizeToFit];
    [backView addSubview:lblToAddress];
    
    //    UIButton *btncToadd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CGRectGetMaxY(baseV.frame) + 10, 70, 20)];
    //    //    btncGetadd.layer.borderWidth = 1;
    //    btncToadd.backgroundColor = [UIColor whiteColor];
    //    [btncToadd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [btncToadd setTitle:@"选取地址" forState:UIControlStateNormal];
    //    [btncToadd addTarget:self action:@selector(sleGetAddress) forControlEvents:UIControlEventTouchUpInside];
    //    btncToadd.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [backView addSubview:btncToadd];
    
    _toAddress = [[UITextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(lblToAddress.frame) + 5 , baseVW, 40)];
    _toAddress.placeholder = @"请填写或选取收货地址";
    _toAddress.layer.borderColor = [UIColor grayColor].CGColor;
    _toAddress.layer.borderWidth = 1;
    _toAddress.font = [UIFont systemFontOfSize:14];
    _toAddress.backgroundColor = [UIColor whiteColor];
    _toAddress.text = _userInfo.address;
    [backView addSubview:_toAddress];
    
    //支付金额
    UILabel *lblMoney = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_toAddress.frame)+10,0, 0)];
    lblMoney.text = @"任务酬劳(单位:元)";
    lblMoney.font = [UIFont systemFontOfSize:14];
    [lblMoney sizeToFit];
    [backView addSubview:lblMoney];
    _money = [[UITextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(lblMoney.frame)+5, SCREEN_WIDTH - 2, 40)];
    _money.keyboardType = UIKeyboardTypePhonePad;
    _money.layer.borderColor = [UIColor grayColor].CGColor;
    _money.layer.borderWidth = 1;
    _money.backgroundColor = [UIColor whiteColor];
    [backView addSubview:_money];
    
    //领取短信
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_money.frame) + 10, 0, 0)];
    lblMessage.text = @"快递短信";
    lblMessage.font = [UIFont systemFontOfSize:14];
    [lblMessage sizeToFit];
    [backView addSubview:lblMessage];
    _message = [[UITextView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(lblMessage.frame) + 5, baseVW, 120)];
    _message.backgroundColor = [UIColor whiteColor];
    _message.layer.borderWidth = 1;
    _message.layer.borderColor = [UIColor grayColor].CGColor;
    [backView addSubview:_message];
    
    //发布按钮
    UIButton *btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(_message.frame) + 10, baseVW, 30)];
    [btnPublish setTitle:@"发布" forState:UIControlStateNormal];
    [btnPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnPublish.titleLabel.font = [UIFont systemFontOfSize:18];
    btnPublish.backgroundColor = UIColorFromRGB(0x0091d2); //[UIColor whiteColor];
    [backView addSubview:btnPublish];
    btnPublish.layer.masksToBounds = YES;
    btnPublish.layer.cornerRadius = 10;
    btnPublish.layer.borderColor = [UIColor grayColor].CGColor;
    btnPublish.layer.borderWidth = 1;
    [btnPublish addTarget:self action:@selector(publicOrder) forControlEvents:UIControlEventTouchUpInside];
    
    backView.contentSize = CGSizeMake(0, CGRectGetMaxY(btnPublish.frame)+110);
    
}

//显示dataPiacker
- (void)showCheckSchool{
 [self showPiceViewWithArray:@[@"贵州财经大学(花溪校区)",@"贵州医科大学(花溪校区)",@"贵州师范大学(花溪校区)",@"贵州城市学院(花溪校区)",@"贵州轻工职业技术学院",@"贵州民族大学花溪校区(花溪校区)"] andIndex:0];
    NSLog(@"asdf");
}
- (void)showCheckCompany{
    [self showPiceViewWithArray: @[@"韵达快递",@"申通快递",@"顺丰快递",@"EMS",@"圆通快递",@"中通快递",@"京东",@"百事汇通"]andIndex:1];
}

- (void)showPiceViewWithArray:(NSArray *)array andIndex: (NSInteger)index{
    if (!_vauels) {
        _vauels = [NSMutableArray array];
    }
    [_vauels removeAllObjects];
    [_vauels addObjectsFromArray:array];
     _shooolExpressV = _vauels[0];
    UIView *backView = [self getBackView];
    [self closeAllKeyBoard];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 280, SCREEN_WIDTH, 200)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:pickerView];
    pickerView.showsSelectionIndicator = YES;
    UIView *toobal = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 310, SCREEN_WIDTH, 30)];
    toobal.backgroundColor = UIColorFromRGB(0xf7f7f7);
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toobal addSubview:button];
    button.tag = index;
    [button addTarget:self action:@selector(changeSchoolExpress:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:toobal];
    
    [self.view addSubview:backView];
}

//更改学校或快递名称
- (void)changeSchoolExpress:(UIButton *)btn{
    if (btn.tag == 0) {
        _school.text = _shooolExpressV;
    }else{
        _company.text = _shooolExpressV;
    }
    [self removerBackView];
}

//选取地址
- (void)sleGetAddress{
    [self showWarnMessage:@"选取地址"];
}

//发布任务
- (void)publicOrder{
    [self closeAllKeyBoard];
    orderInfo *info  = [[orderInfo alloc] init];
    info.userId = _userInfo.userId;
    info.userName = _userInfo.nickName;
    info.userPhone = _contactPhone.text;
    info.school = _school.text;
    info.orderPhone = _orderPhone.text;
    info.address = _toAddress.text;
    info.orderName = _orderName.text;
    info.expressName = _company.text;
    info.message = _message.text;
    info.value = _money.text;
    [self showControllerMasterView:@"发布中...."];
    [[MainOrderManager shared] publishOrder:info success:^(NSInteger returnCode) {
        [self hiddenControllerMaskView];
        [self publishSuccess];
          } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
              [self showWarnMessage:info];
        NSLog(@"%@",info);
    }];
//    ApplicationDelegate.tabBarController.selectedIndex = 2;
}

- (void)publishSuccess{
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的任务已发送成功，请耐心等待顺带小哥为你派件。你可以在“我的任务”中查看派件进度" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alertV show];
    
    [self showWarnMessage:@"你的任务已发送成功，请耐心等待顺带小哥为你派件。你可以在“我的任务”中查看派件进度"];
    [self performSelector:@selector(goTOMainOreder) withObject:nil afterDelay:1];
   
}

//发布成功后跳到主界面
- (void)goTOMainOreder{
    [self hiddenWarnView];
    MainOrederVireController *vc = ApplicationDelegate.tabBarController.mainVc;
    vc.isNeedRelaod = YES;
    ApplicationDelegate.tabBarController.selectedIndex = 2;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     ApplicationDelegate.tabBarController.selectedIndex = 2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//关闭所有键盘
- (void)closeAllKeyBoard{
    [_orderPhone resignFirstResponder];
    [_contactPhone resignFirstResponder];
    [_school resignFirstResponder];
    [_company resignFirstResponder];
    [_message resignFirstResponder];
    [_toAddress resignFirstResponder];
    [_money resignFirstResponder];
    [_orderName resignFirstResponder];
    
}

#pragma makr  UIPickerView Function

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _vauels.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = title = _vauels[row];
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _shooolExpressV  = _vauels[row];
}

@end
