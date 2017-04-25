//
//  SchoolInfo.h
//  ShunDai
//
//  Created by Mac_Key on 16/5/21.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolInfo : NSObject


//学校表主键	INT(10)	10
//SCHOOL_NAME	学校名称	VARCHAR(60)	60
//REMARK	备注	VARCHAR(60)	60

@property (nonatomic,copy)NSString *schoolId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *remak;

+ (SchoolInfo *)getSchoolWithId:(NSInteger) Id;


@end
