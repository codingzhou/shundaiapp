//
//  MainOrederVireController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MainOrederVireController.h"
#import "orderInfo.h"
#import "MainOrderManager.h"
#import "OrderDetailViewController.h"
#import "OrderAppealViewController.h"
#import "KeyScroll.h"

@interface MainOrederVireController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_orders;
    UIView *_receiveBkV;
    orderInfo *_corneOrder;
    UIView *_checkBkV;
    
    NSMutableArray *_btnSchools;
    NSMutableArray *_btnExpresss;
    NSString *_school;
    NSString *_express;
    
    UIView *_noDataView;
    KeyScroll *_keyScrollView;
    
}

@end

@implementation MainOrederVireController

- (instancetype)init{
    if ( [super init]) {
        _corneOrder= nil;
        _corneOrder = nil;
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [Common setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"orderCheck"] withBtnPresImg:[UIImage imageNamed:@"orderCheck_sle"] withTitle:@"筛选" withAction:@selector(showCheckView)];
    [self initView];
}

- (void)initView{
    KeyScroll *view = [[KeyScroll alloc] init];
    _keyScrollView = view;
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
    [self.view addSubview:view];
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"一大波任务来袭，赶快去领取吧";
    lbl.textColor = UIColorFromRGB(0xB3B3B3);
    lbl.font = [UIFont systemFontOfSize:16];
    [lbl sizeToFit];
    [self.view addSubview:lbl];
    CGSize lblS = lbl.frame.size;
    CGFloat lbllienW = (SCREEN_WIDTH - lblS.width-10)/2;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(2.5, 115+lblS.height/2, lbllienW, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xB3B3B3);
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - lbllienW-2.5, 115+lblS.height/2, lbllienW, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xB3B3B3);
    lbl.frame = CGRectMake(lbllienW+2.5, 115, lblS.width, lblS.height);
    [self.view addSubview:line2];
    [self.view addSubview:line1];
    
    [self initTableView];
    [_keyScrollView StartScroll];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [_receiveBkV removeFromSuperview];
    if (self.isNeedRelaod) {
            [self getNewData];
         self.isNeedRelaod = NO;
        }

}

#pragma mark ---获得数据 筛选数据相关Funcation
- (void)initData{
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
     [self showControllerMasterView:@"刷新数据中...."];
    [[MainOrderManager shared] mainOrder:nil express:nil  pageNumber:1 success:^(NSArray *array) {
        [self hiddenControllerMaskView];
        [_orders removeAllObjects];
        [_orders addObjectsFromArray:array];
        [_tableView reloadData];
        if (_orders.count<1) {
            _tableView.footer = nil;
        }
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        NSLog(@"%@",info);
    }];
}
- (void)getNewsData{
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
    [self showControllerMasterView:@"刷新中...."];
    [[MainOrderManager shared] mainOrder:nil express:nil  pageNumber:1 success:^(NSArray *array) {
        [self hiddenControllerMaskView];
        [_tableView.header endRefreshing];
        [_orders removeAllObjects];
        [_orders addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSString *info) {
        [_tableView.header endRefreshing];
        [self hiddenControllerMaskView];
        NSLog(@"%@",info);
    }];
}

- (void)getMoreData{
    NSInteger page = _orders.count / 10 + 1;
    [self showControllerMasterView:@"加载中...."];
    [[MainOrderManager shared] mainOrder:nil express:nil  pageNumber:page success:^(NSArray *array) {
        if (array.count<10) {
//            _tableView.footer = nil;
            [_tableView.footer noticeNoMoreData];
        }
        [self hiddenControllerMaskView];
        [_orders addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        NSLog(@"%@",info);
    }];
}

- (void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=kCommAppbackgroundColor;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNewsData];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *tTop=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:140];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-140];
    [_tableView.superview addConstraint:tWidth];
    [_tableView.superview addConstraint:theight];
     [_tableView.superview addConstraint:tTop];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orders.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detialCell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self setCellContentWithCell:cell andIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    orderInfo *info = _orders[indexPath.row];
    [self showReceiveViewWithInfo:info];
    _corneOrder = info;
    
}
#pragma mark --领取任务视图
//弹窗提示是否领取任务
- (void)showReceiveViewWithInfo:(orderInfo*)info{
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    _receiveBkV = backV;
    CGFloat messageVH = 210;
    CGFloat messgeVW = SCREEN_WIDTH - 60;
    backV.backgroundColor = [UIColorFromRGB(0x0000) colorWithAlphaComponent:0.4];
    [self.view addSubview:backV];
    UIView *messageV = [[UIView alloc] initWithFrame:CGRectMake(30, (messgeVW)/2, messgeVW, messageVH)];
    messageV.layer.borderWidth = 2;
    messageV.layer.borderColor = [UIColor grayColor].CGColor;
    messageV.backgroundColor = [UIColor whiteColor];
    [backV addSubview:messageV];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, messgeVW, 20)];
    lblTitle.font = [UIFont systemFontOfSize:18];
    lblTitle.text = @"提示";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [messageV addSubview:lblTitle];
    
    UILabel *lblAsk = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lblTitle.frame) + 10, 0, 0)];
    lblAsk.font = [UIFont systemFontOfSize:16];
    lblAsk.text = @"你确定领取该任务 :";
    [lblAsk sizeToFit];
    [messageV addSubview:lblAsk];
    
    UILabel *lblSchool = [[UILabel alloc] initWithFrame: CGRectMake(5, CGRectGetMaxY(lblAsk.frame) + 10, 0, 0)];
    lblSchool.font = [UIFont systemFontOfSize:16];
    lblSchool.text = [NSString stringWithFormat:@"所在学校: %@",info.school ];
    [lblSchool sizeToFit];
    [messageV addSubview:lblSchool];
    
    UILabel *lblExpress = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lblSchool.frame) + 10, 0, 0)];
    lblExpress.font = [UIFont systemFontOfSize:16];
    lblExpress.text = [NSString stringWithFormat:@"快递公司: %@",info.expressNameStr];
    [lblExpress sizeToFit];
    [messageV addSubview:lblExpress];
    
    UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lblExpress.frame) + 10 , messgeVW,30)];
    lblAddress.font = [UIFont systemFontOfSize:16];
    lblAddress.text = [NSString stringWithFormat:@"目的地: %@",info.address ];
    lblAddress.numberOfLines = 0;
    [messageV addSubview:lblAddress];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, messageVH - 40, (messgeVW)/2, 40)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnCancel.layer.borderColor = [UIColor grayColor].CGColor;
    btnCancel.layer.borderWidth = 2;
    [messageV addSubview:btnCancel];
    [btnCancel addTarget: self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnOk = [[UIButton alloc] initWithFrame:CGRectMake((messgeVW)/2, messageVH - 40, (messgeVW)/2, 40)];
    [btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [btnOk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnOk.layer.borderColor = [UIColor grayColor].CGColor;
    btnOk.layer.borderWidth = 2;
    [messageV addSubview:btnOk];
    [btnOk addTarget:self action:@selector(clickOk) forControlEvents:UIControlEventTouchUpInside];
    
}
//设置CEll内容
- (void)setCellContentWithCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    for (UIView *subV in cell.contentView.subviews) {
        [subV removeFromSuperview];
    }
    orderInfo *info = _orders[indexPath.row];
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
    iconV.image = [UIImage imageNamed:@"order_logo_default"];
    [cell.contentView addSubview:iconV];
    
    UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(iconV.frame) + 5, 80, 40)];
    lblTime.font = [UIFont systemFontOfSize:12];
    lblTime.numberOfLines = 0;
    lblTime.text = info.launchTime;//@"14：30";
//    [lblTime sizeToFit];
    [cell.contentView addSubview:lblTime];
    
    UILabel *lblSchool = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetMaxX(iconV.frame) + 10, 5, 0, 0)];
    lblSchool.font = [UIFont systemFontOfSize:16];
    lblSchool.text = [NSString stringWithFormat:@"学校: %@",info.school ]; //@"学校: 贵州财经大学";
    [lblSchool sizeToFit];
    [cell.contentView addSubview:lblSchool];
    
    UILabel *lblExpress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconV.frame) + 10, CGRectGetMaxY(lblSchool.frame) + 5, 0, 0)];
    lblExpress.font = [UIFont systemFontOfSize:16];
    lblExpress.text =  [NSString stringWithFormat:@"快递: %@",info.expressNameStr ]; //@"快递: 顺丰快递";
    [lblExpress sizeToFit];
    [cell.contentView addSubview:lblExpress];
    
    UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconV.frame) + 10, CGRectGetMaxY(lblExpress.frame) + 5 , SCREEN_HEIGHT - CGRectGetMaxX(iconV.frame) -40, 20)];
    lblAddress.font = [UIFont systemFontOfSize:14];
    lblAddress.text =  [NSString stringWithFormat:@"目的地: %@",info.address ]; //@"目的地: 贵州财经大学丹桂苑3栋xxx";
    lblAddress.numberOfLines = 0;
    [cell.contentView addSubview:lblAddress];
    
}

#pragma mark --任务筛选视图
//显示筛选条件视图
- (void)showCheckView{
//    NSLog(@"asd");
    [_noDataView removeFromSuperview];
    if (_checkBkV) {
        _checkBkV.hidden = NO;
        return;
    }
    UIView *checkBkV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _checkBkV = checkBkV;
    checkBkV.backgroundColor = [UIColorFromRGB(0x0000) colorWithAlphaComponent:0.3];
    [self.view addSubview:checkBkV];
    [checkBkV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCheckBkV)]];
    
    CGFloat checkVW = SCREEN_WIDTH - 20;
    CGFloat checkVH = 460;
    UIView *checkV = [[UIView alloc] initWithFrame:CGRectMake(10, 10, checkVW, checkVH)];
    checkV.backgroundColor = [UIColor whiteColor];
    checkV.userInteractionEnabled = YES;
    [checkV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doCloseCheckView)]];
    [checkBkV addSubview:checkV];
    
    UILabel *lblSchool = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
    lblSchool.text = @"取货学校:";
    lblSchool.font = [UIFont systemFontOfSize:14];
    [checkV addSubview:lblSchool];
    //显示学校按钮
    NSArray *valueSc = @[@"贵州财经大学(花溪校区)",@"贵州医科大学(花溪校区)",@"贵州师范大学(花溪校区)",@"贵州城市学院(花溪校区)",@"贵州轻工职业技术学院",@"贵州民族大学花溪校区(花溪校区)",@"全部"];
    //学校部分 按钮
    CGFloat baseX = 10;
    CGFloat baseY = 50;
    CGFloat checkBtnW = 135;
    CGFloat checkBtnH = 35;
    _btnSchools = [NSMutableArray array];
    for (NSInteger i = 0; i < valueSc.count ; i++) {
        NSString *value = valueSc[i];
        UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(baseX, baseY, checkBtnW, checkBtnH)];
        checkBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [checkBtn setTitle:value forState:UIControlStateNormal];
        [checkBtn setTitleColor:UIColorFromRGB(0xe2e2e2) forState:UIControlStateNormal];
        checkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        checkBtn.layer.masksToBounds = YES;
        checkBtn.layer.cornerRadius = 13;
        checkBtn.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
        checkBtn.layer.borderWidth = 2;
        [checkBtn setBackgroundColor:[UIColor grayColor]];
        [checkV addSubview:checkBtn];
        [_btnSchools addObject:checkBtn];
        checkBtn.tag = i;
        if (baseX + 2*checkBtnW >checkVW) {
            baseX = 10;
            baseY += checkBtnH+10;
        }else{
            baseX += checkBtnW;
        }
        [checkBtn addTarget:self action:@selector(changeSchoolValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(5, checkVH/2  - 10, checkVW - 5, 2)];
    line4.backgroundColor = [UIColor grayColor];
    [checkV addSubview:line4];
    
    UILabel *lblCompany = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line4.frame) + 10, 80, 40)];
    lblCompany.text = @"快递公司:";
    lblCompany.font = [UIFont systemFontOfSize:14];
    [checkV addSubview:lblCompany];
    //显示快递按钮
    NSArray  *valueCp = @[@"韵达快递",@"申通快递",@"顺丰快递",@"EMS",@"圆通快递",@"中通快递",@"京东",@"百事汇通",@"全部"];
     baseX = 10;
     baseY = CGRectGetMaxY(lblCompany.frame);
    _btnExpresss = [NSMutableArray array];
    for (NSInteger i = 0; i < valueCp.count ; i++) {
        NSString *value = valueCp[i];
        
        UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(baseX, baseY, 90, 35)];
        [checkBtn setTitle:value forState:UIControlStateNormal];
        [checkBtn setTitleColor:UIColorFromRGB(0xe2e2e2) forState:UIControlStateNormal];
        checkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        checkBtn.layer.masksToBounds = YES;
        checkBtn.layer.cornerRadius = 13;
        checkBtn.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
        checkBtn.layer.borderWidth = 2;
        [checkBtn setBackgroundColor:[UIColor grayColor]];
        [checkV addSubview:checkBtn];
        [_btnExpresss addObject:checkBtn];
        checkBtn.tag = i;
        if (baseX + 180 >checkVW) {
            baseX = 10;
            baseY += 45;
        }else{
            baseX += 90;
        }
        [checkBtn addTarget:self action:@selector(changeExpressValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *btnGetNew = [[UIButton alloc] initWithFrame:CGRectMake(0, checkVH - 30, checkVW, 30)];
    [btnGetNew setTitle:@"确定" forState:UIControlStateNormal];
    [btnGetNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkV addSubview:btnGetNew];
    [btnGetNew addTarget:self action:@selector(getNewData) forControlEvents:UIControlEventTouchUpInside];
}

#pragma makr -- 筛选相关Funcation

- (void)changeSchoolValue:(UIButton *)btn
{
    _school = btn.titleLabel.text;
    for (UIButton *subBtn in _btnSchools) {
        if ([btn isEqual:subBtn]) {
            [subBtn setBackgroundColor:UIColorFromRGB(0x13a8ed)];
        }else{
            [subBtn setBackgroundColor:[UIColor grayColor]];
        }
    }
}
- (void)changeExpressValue:(UIButton *)btn
{
    _express = btn.titleLabel.text;
    for (UIButton *subBtn in _btnExpresss) {
        if ([btn isEqual:subBtn]) {
            [subBtn setBackgroundColor:UIColorFromRGB(0x13a8ed)];
        }else{
            [subBtn setBackgroundColor:[UIColor grayColor]];
        }
    }
}

- (void)doCloseCheckView{
}
- (void)getNewData{
    [self hiddenCheckBkV];
    NSLog(@"%@,    %@",_school,_express);
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
    [self showControllerMasterView:@"更新中...."];
    [[MainOrderManager shared] mainOrder:_school express:_express  pageNumber:1 success:^(NSArray *array) {
        [_noDataView removeFromSuperview];
        [self hiddenControllerMaskView];
        [_orders removeAllObjects];
        [_orders addObjectsFromArray:array];
        if (_orders.count == 0) {
            [self showNoOrderView];
            _tableView.footer = nil;
        }
    [_tableView reloadData];
        
        
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        NSLog(@"%@",info);
    }];
}

#pragma makr ---领取任务相关事件
-(void)hiddenCheckBkV{
    _checkBkV.hidden = YES;
    
}

- (void)clickCancel{
    [_receiveBkV removeFromSuperview];
}

- (void)clickOk{
    
    [self showControllerMasterView:@"领取中...."];
   UserInfo *info = [[Config Instance] getUserInfo];
//    [[MainOrderManager shared] getOrderDetial:_corneOrder.orderId userId:[[Config Instance] getID] success:^(orderInfo *info) {
        if ([info.iconImageUrl isEqualToString:_corneOrder.userIconImgUrl]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你不能领取自己发布的任务哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [self clickCancel];
             [self hiddenControllerMaskView];
            return ;
        }else{
            [[MainOrderManager shared] receiveOrder:_corneOrder.orderId completeUserId:[[Config Instance] getID]  success:^(orderInfo *info) {
                [self hiddenControllerMaskView];
                OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
                vc.orderId = info.orderId;
                vc.type = Type_Order_MyReceivd;
                vc.userIconUrl = [[Config Instance] getIconImgeUrl];
                if (!vc.userIconUrl) {
                    vc.userIconUrl = [[Config Instance] getUserInfo].iconImageUrl;
                }
                vc.receiveName = [[Config Instance] getUserInfo].nickName;
                vc.receivePhone = [[Config Instance] getUserInfo].phone;
                //移除领取的任务
                [_orders removeObject:_corneOrder];
                [_tableView reloadData];
                
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } failure:^(NSString *info) {
                [self hiddenControllerMaskView];
                [self showWarnMessage:info];
                NSLog(@"%@",info);
            }];
            
            [self clickCancel];
            
        }

//    } failure:^(NSString *info) {
//        [self hiddenControllerMaskView];
//        NSLog(@"%@",info);
//    }
//     ];
}
        
    
  

//显示没有数据背景
- (void)showNoOrderView{
    UIView *noDataView=[[UIView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT-41)];
    //    noDataView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:noDataView];
    _noDataView=noDataView;
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-49)/2, 107, 49, 65)];
    imageView.image=[UIImage imageNamed:@"my_center_noOrder"];
    [noDataView addSubview:imageView];
    UILabel *lbltext=[[UILabel alloc] init];
    lbltext.text=@"没有相关订单! 请重新筛选";
    lbltext.textColor=UIColorFromRGB(0xc4c7cc);
    lbltext.font=[UIFont systemFontOfSize:18];
    [lbltext sizeToFit];
    CGSize size=[lbltext.text sizeWithAttributes:@{NSFontAttributeName:lbltext.font}];
    lbltext.frame=CGRectMake((SCREEN_WIDTH-size.width)/2, CGRectGetMaxY(imageView.frame)+35, size.width, size.height);
    [noDataView addSubview:lbltext];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
