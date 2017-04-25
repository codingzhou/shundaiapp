//
//  ManagerBase.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//


#import "ManagerBase.h"


@implementation ManagerBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:kNotifyClearData object:nil];
    }
    return self;
}

- (void)resetData
{
    NSLog(@"子类调用");
}

@end
