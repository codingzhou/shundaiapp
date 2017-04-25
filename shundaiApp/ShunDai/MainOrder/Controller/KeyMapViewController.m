//
//  KeyMapViewController.m
//  ShunDai
//
//  Created by Mac_key on 17/2/18.
//  Copyright © 2017年 com.ios. All rights reserved.
//

#import "KeyMapViewController.h"
#import "Constant.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface KeyMapViewController (){
    MAMapView *_mapView;
    UIButton *_openBtn;
}

@end

@implementation KeyMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}


- (void)initView{
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 240, 50)];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIBarButtonItem *item  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    [rightBtn setTitle:@"model" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(changeModel) forControlEvents:UIControlEventTouchUpInside];
    //导航栏右边按钮--切换地图模式
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"model" style:UIBarButtonItemStylePlain target:self action:@selector(changeModel)];

    self.navigationItem.rightBarButtonItem = item;

    //打开/关闭 实时路况
    CGFloat btnw = 120;
    CGFloat btnH = 30;
    _openBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- btnw - 10, (SCREEN_HEIGHT - btnH)/6, btnw, btnH)];
    [_openBtn setTitle:@"打开实时路况" forState:UIControlStateNormal];
    [self.view addSubview:_openBtn];
    _openBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _openBtn.titleLabel.textColor = [UIColor whiteColor];
    _openBtn.backgroundColor = [UIColor grayColor];
    [_openBtn addTarget:self action:@selector(presentOpe) forControlEvents:UIControlEventTouchUpInside];
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    //初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    self.title = @"线路规划";
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //设置高德logo位置
    _mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);
     // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.showsCompass= YES;
    //设置指南针位置
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22);
    //设置成NO表示不显示比例尺；YES表示显示比例尺
    _mapView.showsScale= YES;
    //设置比例尺位置
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);
    //显示路况按钮放到顶层
    [self.view bringSubviewToFront:_openBtn];
}

- (void)changeModel{
    
    switch (_mapView.mapType) {
        case MAMapTypeStandard:
             [_mapView setMapType:MAMapTypeStandardNight];
            break;
        case MAMapTypeStandardNight:
            [_mapView setMapType:MAMapTypeNavi];
            break;
        case MAMapTypeNavi:
            [_mapView setMapType:MAMapTypeSatellite];
            break;
        case MAMapTypeSatellite:
            [_mapView setMapType:MAMapTypeStandard];
            break;
            
        default:
            break;
    }
   
    
    
}

- (void)presentOpe{
    NSString *title = _openBtn.titleLabel.text;
    if ([title isEqualToString:@"打开实时路况"]) {
         [_openBtn setTitle:@"关闭实时路况" forState:UIControlStateNormal];
        _mapView.showTraffic = YES;
    }else{
        [_openBtn setTitle:@"打开实时路况" forState:UIControlStateNormal];
        _mapView.showTraffic = NO;
    }
    NSLog(@"sdfsd");
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
