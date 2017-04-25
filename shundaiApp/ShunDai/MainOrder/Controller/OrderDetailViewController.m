//
//  OrderDetailViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "orderInfo.h"
#import "MainOrderManager.h"
#import "OrderAppealViewController.h"
#import "MessageSigleViewController.h"
#import "KeyMapViewController.h"


@interface OrderDetailViewController ()<UIAlertViewDelegate>
{
    orderInfo *_orderInfo;
}

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";
    [self initData];
    self.view.backgroundColor = UIColorFromRGB(0xEEF3FA);;
    // Do any additional setup after loading the view.
}

- (void)initData{
    if (!_orderInfo) {
        [self showControllerMasterView:@"数据加载中...."];
        [[MainOrderManager shared]  getOrderDetial:_orderId userId:[[Config Instance]getID]  success:^(orderInfo *info) {
            [self hiddenControllerMaskView];
            _orderInfo = info;
            [self initView];
        } failure:^(NSString *info) {
            [self hiddenControllerMaskView];
            [self showWarnMessage:info];
        }];
        
    }

}

- (void)initView{
    UIScrollView *backV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backV];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    lineT.backgroundColor = UIColorFromRGB(0xcccccc);
    [backV addSubview:lineT];
    
    CGFloat userInfoVH = 80;
    UIView *userInfoV = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, userInfoVH)];
//    userInfoV.backgroundColor = UIColorFromRGB(0xEEF3FA);
    [backV addSubview:userInfoV];
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    iconV.image = [UIImage imageNamed:@"defalut_logo"];
    NSString *ssss = [NSString stringWithFormat:@"%@%@",KUrlBaseUrl,  self.userIconUrl];
    [iconV sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,  self.userIconUrl]] placeholderImage:[UIImage imageNamed:@"defalut_logo"]];
//    [iconV sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,  _orderInfo.iconImageUrl]] placeholderImage:[UIImage imageNamed:@"defalut_logo"]];
    [iconV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(gotoMap)]];
    iconV.userInteractionEnabled = YES;
    [userInfoV addSubview:iconV];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconV.frame) + 20, 20, 0, 0)];
    lblName.font = [UIFont systemFontOfSize:14];
    lblName.text = _orderInfo.userName;//@"keylife";
    [lblName sizeToFit];
    [userInfoV addSubview:lblName];
    UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconV.frame) + 20, CGRectGetMaxY(lblName.frame) + 10, 0, 0)];
    lblNumber.font = [UIFont systemFontOfSize:14];
    lblNumber.text= [NSString stringWithFormat:@"任务单号: %@",_orderInfo.orderNumber];//@"任务单号: 121364521";
    [lblNumber sizeToFit];
    [userInfoV addSubview:lblNumber];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0,  userInfoVH- 2, SCREEN_WIDTH, 2)];
    line1.backgroundColor = UIColorFromRGB(0xcccccc);
    [userInfoV addSubview:line1];
    
    UIView *OrderInfoV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userInfoV.frame), SCREEN_WIDTH, 255)];
    [backV addSubview:OrderInfoV];
//    OrderInfoV.backgroundColor = [UIColor greenColor];
    UILabel *lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 0, 0)];
    lblPhone.font = [UIFont systemFontOfSize:14];
    lblPhone.text =  [NSString stringWithFormat:@"手机: %@",_orderInfo.userPhone];// @"手机: 134564321";
    [lblPhone sizeToFit];
    [OrderInfoV addSubview:lblPhone];
    UILabel *lblCompany = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblPhone.frame) + 5, 0, 0)];
    lblCompany.font = [UIFont systemFontOfSize:14];
    lblCompany.text = [NSString stringWithFormat:@"快递公司: %@",_orderInfo.expressNameStr];
    [lblCompany sizeToFit];
    [OrderInfoV addSubview:lblCompany];
    UILabel *lblSchool = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblCompany.frame) + 5, 0, 0)];
    lblSchool.font = [UIFont systemFontOfSize:14];
    lblSchool.text = [NSString stringWithFormat:@"校区：%@",_orderInfo.schoolStr];// @"校区：贵州财经大学";
    [lblSchool sizeToFit];
    [OrderInfoV addSubview:lblSchool];
    UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblSchool.frame) + 5, 0, 0)];
    lblAddress.font = [UIFont systemFontOfSize:14];
    lblAddress.text = [NSString stringWithFormat:@"收货地址: %@",_orderInfo.address];//@"收货地址: 贵州财经大学丹桂33323";
    [lblAddress sizeToFit];
    [OrderInfoV addSubview:lblAddress];
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblAddress.frame) + 5, 0, 0)];
    lblMessage.font = [UIFont systemFontOfSize:14];
    lblMessage.text = @"快递取件信息:";
    [lblMessage sizeToFit];
    [OrderInfoV addSubview:lblMessage];
    UITextView *lblMesINfo = [[UITextView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblMessage.frame) + 5, SCREEN_WIDTH - 80, 80)];
    lblMesINfo.font = [UIFont systemFontOfSize:14];
    lblMesINfo.backgroundColor = [UIColor whiteColor];
//    lblMesINfo.numberOfLines = 0;
    lblMesINfo.userInteractionEnabled = NO;
    lblMesINfo.text = _orderInfo.message;//@"afas阿斯蒂阿斯顿发送到第三方代发是打发斯蒂芬 芬打法的飒飒的阿斯顿发斯蒂芬";
    [OrderInfoV addSubview:lblMesINfo];
    UILabel *lblReceive = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblMesINfo.frame) + 10, 0, 0)];
    lblReceive.font = [UIFont systemFontOfSize:14];
    lblReceive.text = [NSString stringWithFormat:@"领取人: %@",self.receiveName ];//@"领取人: 快递熊阿哥";
    [lblReceive sizeToFit];
    [OrderInfoV addSubview:lblReceive];
    UILabel *lblRcePhone = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblReceive.frame) + 5, 0, 0)];
    lblRcePhone.font = [UIFont systemFontOfSize:14];
    lblRcePhone.text = [NSString stringWithFormat:@"手机: %@",self.receivePhone ];//@"手机: 234354354";
    [lblRcePhone sizeToFit];
    [OrderInfoV addSubview:lblRcePhone];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,  253, SCREEN_WIDTH, 2)];
    line2.backgroundColor = UIColorFromRGB(0xcccccc);
    [OrderInfoV addSubview:line2];
    
    UIView *orderStateV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(OrderInfoV.frame), SCREEN_WIDTH, 190)];
//    orderStateV.backgroundColor = [UIColor greenColor];
    [backV addSubview:orderStateV];
    UILabel *lblState = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 0, 0)];
    lblState.font = [UIFont systemFontOfSize:14];
    lblState.text = @"任务进度";
    [lblState sizeToFit];
    [orderStateV  addSubview:lblState];
    
    NSArray *array = @[@{@"time":@"1203",@"content":@"进度更新"},@{@"time":@"1203",@"content":@"进度更新"},@{@"time":@"1203",@"content":@"进度更新"}];
    CGFloat baseY = CGRectGetMaxY(lblState.frame) + 5;
    CGFloat stateVH = 50;
    for (NSDictionary *dic in array) {
        UIView *stateV = [[UIView alloc] initWithFrame:CGRectMake(40, baseY, SCREEN_WIDTH - 40, stateVH)];
//        stateV.backgroundColor = [UIColor whiteColor];
        UIImageView *circleV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
        circleV.image = [UIImage imageNamed:@"bullet_blue"];
        [stateV addSubview:circleV];
        UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 0, 0)];
        lblContent.font = [UIFont systemFontOfSize:12];
        lblContent.text = dic[@"content"];
        [lblContent sizeToFit];
        [stateV addSubview:lblContent];
        UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lblContent.frame) + 5, 0, 0)];
        lblTime.font = [UIFont systemFontOfSize:12];
        lblTime.text = dic[@"time"];
        [lblTime sizeToFit];
        [stateV addSubview:lblTime];
        UIView *cellLine = [[UIView alloc] initWithFrame:CGRectMake(40, stateVH - 1, SCREEN_WIDTH - 40, 1)];
        cellLine.backgroundColor =  UIColorFromRGB(0xcccccc);
        [stateV addSubview:cellLine];
        
        [orderStateV addSubview:stateV];
        baseY += stateVH;
    }
    

    UIButton *buttomBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(orderStateV.frame) + 20, SCREEN_WIDTH - 60, 30)];
    buttomBtn.backgroundColor = UIColorFromRGB(0x0091d2);
   
    if (self.type == Type_Order_MyPublic) {
        if (_orderInfo.state == 0) {
            [buttomBtn setTitle:@"取消任务" forState:UIControlStateNormal];
            [buttomBtn addTarget:self action:@selector(OrderCancel) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [buttomBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [buttomBtn addTarget:self action:@selector(OrderFlish) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }else{
         [buttomBtn setTitle:@"任务申诉" forState:UIControlStateNormal];
        [buttomBtn addTarget:self action:@selector(clickButtomBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    buttomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    buttomBtn.layer.masksToBounds = YES;
    buttomBtn.layer.cornerRadius = 10;
    [backV addSubview:buttomBtn];
    backV.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(buttomBtn.frame) + 100);
    
    if (self.type == Type_Order_MyPublic &&  _orderInfo.state == 1) {
        //添加任务申诉按钮-----任务已经被领取并且没有完成
        UIButton *buttomBtn222 = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(buttomBtn.frame) + 10, SCREEN_WIDTH - 60, 30)];
        [buttomBtn222 setTitle:@"任务申诉" forState:UIControlStateNormal];
        buttomBtn222.backgroundColor = UIColorFromRGB(0x0091d2);
        buttomBtn222.titleLabel.font = [UIFont systemFontOfSize:18];
        buttomBtn222.layer.masksToBounds = YES;
        buttomBtn222.layer.cornerRadius = 10;
        [backV addSubview:buttomBtn222];
        [buttomBtn222 addTarget:self action:@selector(clickButtomBtn) forControlEvents:UIControlEventTouchUpInside];
        backV.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(buttomBtn222.frame) + 100);
        
    }
    
    if (_orderInfo.state == 2) {
        //取消按钮--任务完成
        UIButton *buttomBtnFinish = [[UIButton alloc] initWithFrame:buttomBtn.frame];
        [buttomBtnFinish setTitle:@"任务已完成" forState:UIControlStateNormal];
        buttomBtnFinish.backgroundColor = UIColorFromRGB(0x0091d2);
        buttomBtnFinish.titleLabel.font = [UIFont systemFontOfSize:18];
//        buttomBtnFinish.layer.masksToBounds = YES;
//        buttomBtnFinish.layer.cornerRadius = 10;
        [backV addSubview:buttomBtnFinish];
        [buttomBtn removeFromSuperview];
        backV.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(buttomBtnFinish.frame) + 60);
    }
    
    UIImageView *socialView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 0, 0)];
    socialView.image = [UIImage imageNamed:@"contactImg"];
    [socialView addGestureRecognizer:[[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(contract)]];
    socialView.userInteractionEnabled = YES;
//    socialView.m
    [self.view addSubview:socialView];
//    socialView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"contactImg"]];
    
    socialView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *tBottom=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:socialView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [socialView.superview addConstraints:@[tWidth,tBottom]];
    [socialView addConstraint:theight];
}

//取消任务
- (void)OrderCancel{
    NSLog(@"CancelOrder");
    [self showControllerMasterView:@"删除中...."];
    [[MainOrderManager shared] deleteOrder:_orderInfo.userId orderId:_orderInfo.orderId success:^(NSInteger code) {
        [self hiddenControllerMaskView];
        [self showWarnMessage:@"删除成功"];
        
        [self performSelector:@selector(goBackAndRelaod) withObject:nil afterDelay:1];
        
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        [self showWarnMessage:info];
    }];
    
}

- (void)goBackAndRelaod{
    [self hiddenWarnView];
    if (self.superVc) {
        self.superVc.isNeedRelaod = YES;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//确认收货
- (void)OrderFlish{
    NSLog(@"FinlishOrder");
    [[MainOrderManager shared] finishOrder:_orderInfo.orderId  userId:_orderInfo.userId success:^(NSInteger code) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收货成功！O(∩_∩)O谢谢使用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        
    } failure:^(NSString *info) {
        NSLog(@"%@",info);
        [self showWarnMessage:info];
    }];
    
}

//任务申诉
- (void)clickButtomBtn{
        OrderAppealViewController *vc = [[OrderAppealViewController alloc] init];
        vc.orderNum = _orderInfo.orderNumber;
        [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)contract{
    NSString *launch = [[Config Instance] getPhone];
    NSString *aimID = self.aimId ? self.aimId:_orderInfo.userPhone;
    NSString *aimName = self.aimName ? self.aimName:_orderInfo.userName;
    //NSLog(@"contract   %@,,,,%@",launch,aimID);
    if([aimName isEqualToString:@""]) aimName = @"该用户没有填写昵称";
    MessageSigleViewController *vc = [[MessageSigleViewController alloc]initWithConversationChatter:aimID conversationType:EMConversationTypeChat];
    vc.title = aimName;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *显示地图界面--高德
 */
- (void)gotoMap{
    KeyMapViewController *vc = [[KeyMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
