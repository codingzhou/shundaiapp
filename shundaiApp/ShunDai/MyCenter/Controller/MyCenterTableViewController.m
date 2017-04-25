//
//  MyCenterTableViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MyCenterTableViewController.h"
#import "LaunchViewController.h"
#import "CustomNavigationController.h"
#import "UserDatialInfoViewController.h"
#import "UserInfo.h"
#import "MyCenterManager.h"
#import "Config.h"
#import "MyIdentifyViewController.h"
#import "OrderAppealViewController.h"
#import "AboutShunDaiViewController.h"
#import "CustomActionSheet.h"
#import "MessageListVc.h"

@interface MyCenterTableViewController ()<UITableViewDataSource,UITableViewDelegate,CustomActionSheetDelegate>
{
    UITableView *_tableView;
    UserInfo *_userInfo;
}

@end

@implementation MyCenterTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     [self initData];
    [self initTableView];
//    [self setFootView];
    self.title = @"个人中心";
}

- (void)initData{
//    _userInfo =  [[MyCenterManager shared].requestDic objectForKey:@"userInfo"];
    _userInfo = [[Config Instance] getUserInfo];
    if (!_userInfo) {
        NSString *userId = [[Config Instance] getID];
        NSLog(@"%@",userId);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self initTableView];
    _tableView.tableHeaderView = [self getHeaderView];
     self.tabBarController.tabBar.hidden = NO;
}

- (void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=kCommAppbackgroundColor;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableHeaderView = [self getHeaderView];
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [_tableView.superview addConstraint:tWidth];
    [_tableView.superview addConstraint:theight];
}

- (void)setLoginOtuViewWithCell: (UITableViewCell *)cell{
    UILabel *lblPay=[[UILabel alloc] init];
    lblPay.text=@"退出";
    lblPay.textAlignment=NSTextAlignmentCenter;
    lblPay.font=[UIFont systemFontOfSize:18];
    lblPay.textColor= [UIColor whiteColor];
    lblPay.backgroundColor=UIColorFromRGB(0xff3594);
    [lblPay sizeToFit];
    lblPay.userInteractionEnabled=YES;
    [lblPay addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToLoginOut)]];
    [cell addSubview:lblPay];
    
    lblPay.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *footViewLeft=[NSLayoutConstraint constraintWithItem:lblPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lblPay.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint *footViewRight=[NSLayoutConstraint constraintWithItem:lblPay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lblPay.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *footViewButtom=[NSLayoutConstraint constraintWithItem:lblPay attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:lblPay.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint *footViewH=[NSLayoutConstraint constraintWithItem:lblPay attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:48];
    [lblPay.superview addConstraints:@[footViewLeft,footViewButtom,footViewRight]];
    [lblPay addConstraint:footViewH];
//    [cell.contentView bringSubviewToFront:lblPay];

}

- (UIView *)getHeaderView{
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    headerV.backgroundColor = UIColorFromRGB(0x1b75ef);
    
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 30, 80, 80)];
    UIImage *iconImg = [self getIconImg];
    if (iconImg) {
        iconV.image = iconImg;
    }else{
           [iconV sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,  _userInfo.iconImageUrl]] placeholderImage:[UIImage imageNamed:@"defalut_logo"]];
    }

    
    iconV.layer.masksToBounds = YES;
    iconV.layer.cornerRadius = 5;
//    iconV.backgroundColor = [UIColor whiteColor];
    [iconV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToDetailInfo)]];
    iconV.userInteractionEnabled = YES;
    [headerV addSubview:iconV];
    
    UILabel *lblNmae = [[UILabel alloc] init];
    lblNmae.text = _userInfo.nickName;//@"keyLife";
    lblNmae.font = [UIFont systemFontOfSize:14];
    lblNmae.textColor = [UIColor whiteColor];
    CGSize sizeN = [lblNmae.text sizeWithAttributes:@{NSFontAttributeName:lblNmae.font}];
    lblNmae.frame = CGRectMake((SCREEN_WIDTH - sizeN.width)/2, CGRectGetMaxY(iconV.frame)+10, sizeN.width, sizeN.height);
    [headerV addSubview:lblNmae];
    
    UILabel *lblSign = [[UILabel alloc] init];
    lblSign.text = @"会打代码的bboy";
    lblSign.font = [UIFont systemFontOfSize:12];
    lblSign.textColor = [UIColor whiteColor];
    CGSize sizeS = [lblSign.text sizeWithAttributes:@{NSFontAttributeName:lblSign.font}];
    lblSign.frame = CGRectMake((SCREEN_WIDTH - sizeS.width)/2, CGRectGetMaxY(lblNmae.frame)+10, sizeS.width, sizeS.height);
    [headerV addSubview:lblSign];
    
    return headerV;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 6;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = @"";
    NSString *imageName = @"";
    //退出
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self setLoginOtuViewWithCell:cell];
        return cell;
    }
    
    switch (indexPath.row) {
        case 0:
            title = @"个人信息";
            imageName = @"person_renzhenxinxi";
            break;
        case 1:
            title = @"我的认证信息";
            imageName = @"imgpersonrenzhenxinxi";
            break;
        case 2:
            title = @"任务申诉";
            imageName = @"person_renwushensu";
            break;
        case 3:
            title = @"关于顺带";
            imageName = @"person_aboutshundai";
            break;
        case 4:
            title = @"分享";
            imageName = @"share";
            break;
        case 5:
            title = @"消息列表";
            imageName = @"person_renwushensu";
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
//    imgV.image = [UIImage imageNamed:imageName];
//    [cell addSubview:imgV];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self goToDetailInfo];
            break;
        case 1:
            [self goToMyIdentity];
            break;
        case 2:
            [self goToOrderAppeal];
            break;
        case 3:
            [self goToAboutShunDai];
            break;
        case 4:
            [self goToShare];
            break;
        case 5:
            [self goToMessageList];
            break;
        default:
            break;
    }
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)goToDetailInfo{
    UserDatialInfoViewController *vc = [[UserDatialInfoViewController alloc] init];
//    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goToMyIdentity{
    MyIdentifyViewController *vc = [[MyIdentifyViewController alloc] init];
    vc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goToOrderAppeal{
    OrderAppealViewController *vc = [[OrderAppealViewController alloc] init];
     vc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goToAboutShunDai{
    AboutShunDaiViewController *vc = [[AboutShunDaiViewController alloc] init];
    vc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToMessageList{
    MessageListVc *vc = [[MessageListVc alloc] init];
    vc.hidesBottomBarWhenPushed =YES;
    vc.title = @"最近消息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToLoginOut{
    
    NSLog(@"Login Out");
    [[Config Instance] setLoginStatus:NO];
    LaunchViewController *ctl = [[LaunchViewController alloc] init];
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:ctl];
    ApplicationDelegate.window.rootViewController = nav;

}

- (void)goToShare{
    [MyCenterManager shared].tencentDelegate = self;
    TencentOAuth *tenent = [MyCenterManager shared].tencent;
    //分享跳转URL
    NSString *url = KUrlBaseUrl;
    //分享图预览图URL地址
     UIImage *img = [UIImage imageNamed:@"APPlogo"];
    NSURL *strPath = [[NSBundle mainBundle] URLForResource:@"APPlogo.png" withExtension:nil];
     NSData *imgData =  UIImageJPEGRepresentation(img,1.0);
      QQApiNewsObject *news = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]    title: @"顺带在手，快递无忧" description:@"顺带是一款校园代取快递的APP 正所谓，顺带在在手，快递无忧" previewImageData:imgData];
    
       SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:news];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//    if ( sent  EQQAPISENDSUCESS) {
//        [self showWarnMessage:@"分享成功"];
//    }
}


@end
