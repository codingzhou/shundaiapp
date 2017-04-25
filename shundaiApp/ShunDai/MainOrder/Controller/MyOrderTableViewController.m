//
//  MyOrderTableViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MyOrderTableViewController.h"
//#import <MJRefresh/MJRefresh.h>
#import "MainOrderManager.h"
#import "UserInfo.h"
#import "LaunchViewController.h"
#import "OrderDetailViewController.h"


@interface MyOrderTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _cornerIndex;//0-我发布的   1-我领取的
    UIButton *_btnPaid;
    UIButton *_btnDisPay;
    
    UIView *_selectedLine;
    CGFloat _lineRemove;
    UITableView *_tableView;
    UIView *_noDataView;
    
    NSMutableArray *_myPublish;
    NSMutableArray *_myReceive;
    
    UserInfo *_userInfo;
    
    CGPoint myPublichTbOff;
    CGPoint myReceiveTbOff;
    
}

@end

@implementation MyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    [super viewDidLoad];
    [self initHdaderView];
    [self initData];
    _cornerIndex=0;
     myPublichTbOff = CGPointMake(0, 0);
     myReceiveTbOff= CGPointMake(0, 0);
//    [self showNoOrderView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self checkLogin]) {
        LaunchViewController *ctl = [[LaunchViewController alloc] init];
        CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:ctl];
        ApplicationDelegate.window.rootViewController = nav;
    }
//    [self getData];
    if (self.isNeedRelaod) {
        [self getNewsData];
        self.isNeedRelaod = NO;
    }
   
    
}

- (UIView *)getFooterView
{
    UIView *foorterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    return foorterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---获得数据 筛选数据相关Funcation
- (void)initData{
    _userInfo = [[Config Instance]getUserInfo];
    _myPublish=[NSMutableArray array];
    _myReceive=[NSMutableArray array];
    
    [self showControllerMasterView:@"获取数据中..."];
    [[MainOrderManager shared] myPublishOrder: _userInfo.userId state:nil pageNumber:1 success:^(NSArray *array) {
        [self hiddenControllerMaskView];
        [_myPublish removeAllObjects];
        [_myPublish addObjectsFromArray:array];
        [_tableView removeFromSuperview];
        [_noDataView removeFromSuperview];
         [self initTableView];
        if (_myPublish.count < 10) {
            _tableView.footer = nil;
        }
    } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        NSLog(@"%@",info);
    }];
    [ [MainOrderManager shared] myReceiveOrder:_userInfo.userId state:nil pageNumber:1 success:^(NSArray *array) {
        [_myReceive removeAllObjects];
        [_myReceive addObjectsFromArray:array];
    } failure:^(NSString *info) {
        NSLog(@"%@",info);
    }];
    //update t_express_task set complete_user_id = '`t_express_task`E5018789-FBC3-E98C-B9A7-DC2DF4628924' where id ='B9EC9198-792C-5853-907E-285E58CDAAB1'
}
- (void)getNewsData{
//    [self showControllerMasterView:@"刷新数据中..."];
    if (_cornerIndex == 0) {
        [ [MainOrderManager shared] myPublishOrder: _userInfo.userId state:nil pageNumber:1 success:^(NSArray *array) {
            [self hiddenControllerMaskView];
            [_tableView.header endRefreshing];
            [_myPublish removeAllObjects];
            [_myPublish addObjectsFromArray:array];
//            [_tableView removeFromSuperview];
            [_tableView reloadData];
            if (_myPublish.count < 10) {
                _tableView.footer = nil;
            }
        } failure:^(NSString *info) {
             [_tableView.header endRefreshing];
            [self hiddenControllerMaskView];
             [self showWarnMessage:info];
            NSLog(@"%@",info);
        }];
    }else{
        [ [MainOrderManager shared] myReceiveOrder:_userInfo.userId state:nil pageNumber:1 success:^(NSArray *array) {
            [self hiddenControllerMaskView];
             [_tableView.header endRefreshing];
            [_myReceive removeAllObjects];
            [_myReceive addObjectsFromArray:array];
             [_tableView reloadData];
            [self initTableView];
            if (_myReceive.count < 10) {
                _tableView.footer = nil;
            }
        } failure:^(NSString *info) {
             [_tableView.header endRefreshing];
            [self hiddenControllerMaskView];
             [self showWarnMessage:info];
            NSLog(@"%@",info);
        }];
    }

}

- (void)getMoreData{
//    [self showControllerMasterView:@"加载数据中..."];
    if (_cornerIndex == 0) {
        [ [MainOrderManager shared] myPublishOrder: _userInfo.userId state:nil pageNumber:(_myPublish.count / 10 + 1) success:^(NSArray *array) {
            [self hiddenControllerMaskView];
            [_myPublish addObjectsFromArray:array];
            [_tableView reloadData];
            if (array.count < 10) {
                [_tableView.footer noticeNoMoreData];
            }
        } failure:^(NSString *info) {
            [self hiddenControllerMaskView];
            [self showWarnMessage:info];
            NSLog(@"%@",info);
        }];
    }else{
        [ [MainOrderManager shared] myReceiveOrder:_userInfo.userId state:nil pageNumber:(_myReceive.count / 10 + 1) success:^(NSArray *array) {
            [self hiddenControllerMaskView];
            [_myReceive addObjectsFromArray:array];
            if (array.count < 10) {
               [_tableView.footer noticeNoMoreData];
            }
        } failure:^(NSString *info) {
           [self hiddenControllerMaskView];
            [self showWarnMessage:info];
            NSLog(@"%@",info);
        }];
    }
}
- (void)initTableView{
    if (!_tableView) {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor=kCommAppbackgroundColor;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
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
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:- 80];
    [_tableView.superview addConstraint:tWidth];
    [_tableView.superview addConstraint:theight];
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSLayoutConstraint *tTop=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:42];
    [_tableView.superview addConstraint:tTop];
}
//初始化顶部选项卡
- (void)initHdaderView{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
    headerView.backgroundColor=[UIColor whiteColor];
    UIButton *btnPaid=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 40)];
    _btnPaid=btnPaid;
    btnPaid.titleLabel.font=[UIFont systemFontOfSize:18];
    btnPaid.titleLabel.text=@"我发布的";
    [btnPaid setTitle:@"我发布的" forState:UIControlStateNormal];
    [btnPaid setTitleColor:UIColorFromRGB(0x808080) forState:UIControlStateNormal];
    CGSize size=[btnPaid.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:btnPaid.titleLabel.font}];
    [btnPaid addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat linePaidX=((SCREEN_WIDTH/2)-size.width)/2;
    _lineRemove=linePaidX*2+size.width;
    UIView *linePaid=[[UIView alloc] initWithFrame:CGRectMake(linePaidX, 40, size.width, 1.5)];
    _selectedLine=linePaid;
    linePaid.backgroundColor=UIColorFromRGB(0x13a8ed);
    [headerView addSubview:btnPaid];
    [headerView addSubview:linePaid];
    
    UIButton *btnDisPay=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40)];
    _btnDisPay=btnDisPay;
    [btnDisPay setTitle:@"我领取的" forState:UIControlStateNormal];
    [btnDisPay setTitleColor:UIColorFromRGB(0x808080) forState:UIControlStateNormal];
    [btnDisPay addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnDisPay];
    
    [self.view addSubview:headerView];
}


#pragma mark---UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 41;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_cornerIndex==0) {
        return _myPublish.count;
    }
    return _myReceive.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strOreder=@"orderCell";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:strOreder];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strOreder];
    }
//    [self setCellValue:cell AndIndexPath:indexPath andTableView:tableView];
    [self setCellContentWithCell:cell andIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    orderInfo *info ;
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];

    if (_cornerIndex == 0) {
        info = _myPublish[indexPath.row];
         vc.type = Type_Order_MyPublic;
        vc.userIconUrl = [[Config Instance] getIconImgeUrl];
        if (!vc.userIconUrl) {
            vc.userIconUrl = [[Config Instance] getUserInfo].iconImageUrl;
        }
        vc.receivePhone = info.completePhone ? info.completePhone: @"";
        vc.receiveName = info.completeName ? info.completeName:@"";
        vc.aimId = info.completePhone;
        vc.aimName = info.completeName;
        vc.superVc = self;
    }else{
        info = _myReceive[indexPath.row];
         vc.type = Type_Order_MyReceivd;
        vc.userIconUrl = info.userIconImgUrl;
        vc.receiveName = [[Config Instance] getUserInfo].nickName;
        vc.receivePhone = [[Config Instance] getUserInfo].phone;
        vc.aimId = info.userPhone;
         vc.aimName = info.userName;
    }
        vc.orderId = info.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//设置cell 内容
- (void)setCellContentWithCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    for (UIView *subV in cell.contentView.subviews) {
        [subV removeFromSuperview];
    }
    orderInfo *info ;
    if (_cornerIndex == 0) {
        info = _myPublish[indexPath.row];
    }else{
        info = _myReceive[indexPath.row];
    }
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
    
    //    NSString *filePath = [NSString stringWithFormat:@"%@/%@",kPubImagePicFolder,orderInfo.imageName];
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
    //            UIImage *imageBg = [UIImage imageWithContentsOfFile:filePath];
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                [btnImage setBackgroundImage:imageBg forState:UIControlStateNormal];
    //            });
    //        });
    //    } else {
    //        NSString *requestStr = [NSString stringWithFormat:@"%@/%@",kAttachURL,orderInfo.imageName];
    //        NSLog(@"%@",requestStr);
    //        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestStr]];
    //        __weak UIButton *weakSelf = btnImage;
    //        [btnImage setBackgroundImageForState:UIControlStateNormal withURLRequest:request placeholderImage: [UIImage imageNamed:@"default_logo"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    //            [weakSelf setBackgroundImage:image forState:UIControlStateNormal];
    //            [[NSFileManager defaultManager] createFileAtPath:filePath contents:UIImageJPEGRepresentation(image, 1.0) attributes:nil];
    //        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
    //
    //        }];
    //    }
    //    [cell.contentView addSubview:btnImage];
    
}

//顶部选项卡发生更改时
- (void)changeTableView:(UIButton *)cornerBtn{

    CGRect lineFrame=_selectedLine.frame;
    if ([cornerBtn isEqual:_btnPaid]) {
        if (_cornerIndex==0) {
            return;
        }
        myReceiveTbOff = _tableView.contentOffset;
        _cornerIndex=0;
        [_btnPaid setTitleColor:UIColorFromRGB(0x13a8ed) forState:UIControlStateNormal];
        [_btnDisPay setTitleColor:UIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _selectedLine.frame=CGRectMake(lineFrame.origin.x-_lineRemove, lineFrame.origin.y,lineFrame.size.width,lineFrame.size.height);
    }else{
        if (_cornerIndex==1) {
            return;
        }
         myPublichTbOff = _tableView.contentOffset;
        [_btnDisPay setTitleColor:UIColorFromRGB(0x13a8ed) forState:UIControlStateNormal];
        [_btnPaid setTitleColor:UIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _selectedLine.frame=CGRectMake(lineFrame.origin.x+_lineRemove, lineFrame.origin.y,lineFrame.size.width,lineFrame.size.height);
        _cornerIndex=1;
    }
    
    [_tableView removeFromSuperview];
    [self initTableView];
    [_tableView reloadData];
    _tableView.contentOffset = CGPointMake(0, 0);
//    if (_cornerIndex == 0) {
//        _tableView.contentOffset = myPublichTbOff;
//    }else{
//        _tableView.contentOffset = myReceiveTbOff;
//    }

////    [_noDataView removeFromSuperview];
//    if ([self checkData]) {
//        
//    }else{
////        [self showNoOrderView];
//        //        _noDataView.hidden = NO;
//    }
}
//检查是否需要显示无数据背景S
- (BOOL)checkData{
    if (_cornerIndex==0&&_myPublish.count==0) {
        return NO;
    }
    if (_cornerIndex==1&&_myReceive.count==0) {
        return NO;
    }
    return YES;
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
    lbltext.text=@"你还没有相关订单!";
    lbltext.textColor=UIColorFromRGB(0xc4c7cc);
    lbltext.font=[UIFont systemFontOfSize:18];
    [lbltext sizeToFit];
    CGSize size=[lbltext.text sizeWithAttributes:@{NSFontAttributeName:lbltext.font}];
    lbltext.frame=CGRectMake((SCREEN_WIDTH-size.width)/2, CGRectGetMaxY(imageView.frame)+35, size.width, size.height);
    [noDataView addSubview:lbltext];
}


@end
