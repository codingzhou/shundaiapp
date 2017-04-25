//
//  ChangeInfoViewController.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/25.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "BaseViewController.h"
#import "UserDatialInfoViewController.h"

@interface ChangeInfoViewController : BaseViewController

@property (nonatomic,strong)UserDatialInfoViewController *presentVc;
@property (nonatomic, assign)NSInteger changeIndex;

@property (nonatomic,strong)NSArray *values;

@end
