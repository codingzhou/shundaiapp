//
//  SchoolInfo.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/21.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "SchoolInfo.h"

@implementation SchoolInfo

+ (SchoolInfo *)getSchoolWithId:(NSInteger) Id{
    SchoolInfo *info = [[SchoolInfo alloc] init];
    //查看本地学校学校。
    
    //更新服务器学校信息
    
    info.schoolId = @"13";
    info.name = @"贵州财经大学";
    info.remak = @"";
    return info;
}


@end
