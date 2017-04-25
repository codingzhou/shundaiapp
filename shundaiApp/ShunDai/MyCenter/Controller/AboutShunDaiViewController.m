//
//  AboutShunDaiViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "AboutShunDaiViewController.h"

@interface AboutShunDaiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation AboutShunDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于顺带";
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=kCommAppbackgroundColor;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self getTableHeaderView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [_tableView.superview addConstraint:tWidth];
    [_tableView.superview addConstraint:theight];
}

- (UIView *)getTableHeaderView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    UIImageView *logoV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 30, 120, 120)];
//    logoV.backgroundColor = [UIColor blackColor];
    logoV.image = [UIImage imageNamed:@"APPlogo"];
    [headerV addSubview:logoV];
    return headerV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSString *title = @"";
    switch (indexPath.row) {
        case 0:
            title = @"检测更新";
            break;
        case 1:
            title = @"清除缓存";
            break;
        case 2:
            title = @"联系我们";
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *warnStr = @"";
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前版本为最新版本!!!" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    if (indexPath.row == 1) {
        [self showControllerMasterView:@"清除中"];
        [self performSelector:@selector(deleteCashData) withObject:nil afterDelay:2];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay), dispatch_queue_t queue, ^{
//            
//        });
    }
    if (indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://119.29.140.85"]];
    }
}

- (void)deleteCashData{
    [self hiddenControllerMaskView];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存数据已清除!" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
