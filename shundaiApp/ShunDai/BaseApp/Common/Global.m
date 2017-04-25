//
//  Global.m
//  ZhiXingBus
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Global.h"
#import "Config.h"
//#import "md5_utils.h"
//#import <ZAActivityBar/ZAActivityBar.h>
//#import "ChineseToPinyin.h"
//#import "Pinyin.h"
//#import "UserCardManager.h"
//#import "FriendManager.h"
//#import "MyCenterManager.h"

@implementation Global


NSInteger getAgeFromDate(NSString* birthDay)
{
    if (birthDay.length < 4) {
        return -1;
    }
    if (birthDay && ![birthDay isEqualToString:@"0"]) {
        NSDateFormatter* dateF = [[NSDateFormatter alloc] init];
        [dateF setDateStyle:NSDateFormatterMediumStyle];
        [dateF setTimeStyle:NSDateFormatterShortStyle];
        [dateF setDateFormat:@"yyyy-MM-dd"];
        
        //由日期转换年龄
        NSString *currentDateStr = [dateF stringFromDate:[NSDate date]];
        
        //用时间差计算年龄，暂未用
        /*
         NSDate *dd=[dateFormatter dateFromString:dateStr];
         NSTimeInterval distance = [[NSDate date] timeIntervalSinceDate:dd];
         NSTimeInterval iyear=distance/(365*24*3600);
         NSLog(@"====%f",iyear)
         */
        
        //用年份减法
        int year1 = [[birthDay substringToIndex:4] intValue];
        int year2 = [[currentDateStr substringToIndex:4] intValue];
        
        int age = year2-year1;
        
        if (age <= 0) {
            age = 1;
        }
        
        return age;
    } else {
        return -1;
    }
}

NSString* getMasterToken()
{
    return [[Config Instance] getAppToken];
}

NSString* getPhone()
{
    return [[Config Instance] getPhone];
}

void showToastMsg(NSString* apMsg)
{
//    [ZAActivityBar showWithStatus:apMsg];
}

NSString* getMasterAccpimtName()
{
    return ([[Config Instance] getAccountName])?[[Config Instance] getAccountName]:@"";
}

//void showSuccessToastMsg(NSString* apMsg)
//{
//    [ZAActivityBar showSuccessWithStatus:apMsg];
//}
//
//void showErrorToastMsg(NSString *msg)
//{
//    [ZAActivityBar showErrorWithStatus:msg];
//}

NSString* getAppCachePathEx()
{
    NSArray* lpPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* result = nil;
    if([lpPaths count]>0) {
        result = [NSString stringWithFormat:@"%@/%ld",[lpPaths objectAtIndex:0],(long)getMasterID()];
        BOOL isDirectory = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath:result isDirectory:&isDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:result withIntermediateDirectories:NO attributes:nil error:nil];
            return result;
        } else {
            return result;
        }
    }
    return nil;
}

NSString* getPublicPathEx()
{
    NSArray* lpPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* result = nil;
    if([lpPaths count]>0) {
        result = [NSString stringWithFormat:@"%@/Public",[lpPaths objectAtIndex:0]];
        BOOL isDirectory = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath:result isDirectory:&isDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:result withIntermediateDirectories:NO attributes:nil error:nil];
            return result;
        } else {
            return result;
        }
    }
    return nil;
}

//NSString* makeMD5(NSString* src)
//{
//    MD5Context context;
//    MD5Init(&context);
//    
//    const uint8_t* lpBuf = (const uint8_t*) [src UTF8String];
//    unsigned liLen = (unsigned)strlen((const char*)lpBuf);
//    
//    MD5Update(&context, lpBuf, liLen);
//    
//    uint8_t md5[16];
//    
//    MD5Final(md5, &context);
//    
//    NSString* lpMD5Key = [NSString stringWithFormat:
//                          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                          md5[0], md5[1], md5[2], md5[3],
//                          md5[4], md5[5], md5[6], md5[7],
//                          md5[8], md5[9], md5[10], md5[11],
//                          md5[12], md5[13], md5[14], md5[15]];
//    
//    return lpMD5Key;
//}

NSString* getAppDocumentPathEx()
{
    NSArray* lpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* result = nil;
    if([lpPaths count]>0) {
        result = [NSString stringWithFormat:@"%@/%ld",[lpPaths objectAtIndex:0],(long)getMasterID()];
        BOOL isDirectory = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath:result isDirectory:&isDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:result withIntermediateDirectories:NO attributes:nil error:nil];
        }
        return result;
    } else {
        return result;
    }
}

NSString *getRedPackPwd()
{
    if ([[Config Instance] getServerPwd] && ![[[Config Instance] getServerPwd] isEqualToString:@""]) {
        return  [[Config Instance] getServerPwd];
    }
    return @"";
}

NSString *getMasterPwd()
{
    if ([[Config Instance] getPwd] && ![[[Config Instance] getPwd] isEqualToString:@""]) {
        return  [[Config Instance] getPwd];
    }
    return @"";
}

NSInteger getMasterID()
{
    return [[Config Instance] getID];
}


//NSString* getFirstLetterOfString(NSString* apText)
//{
//    if (!apText || [apText isEqualToString:@""]) {
//        return @"#";
//    }
////    char lpFirsthar=pinyinFirstLetter([apText characterAtIndex:0]);
//    if((lpFirsthar>='a' && lpFirsthar<='z')||(lpFirsthar>='A' && lpFirsthar<='Z'))
//    {
//        NSString* lpFirstLetter = nil;
//        if([Global searchResult:apText searchText:@"曾"])
//            lpFirstLetter = @"Z";
//        else if([Global searchResult:apText searchText:@"解"])
//            lpFirstLetter = @"X";
//        else if([Global searchResult:apText searchText:@"仇"])
//            lpFirstLetter = @"Q";
//        else if([Global searchResult:apText searchText:@"朴"])
//            lpFirstLetter = @"P";
//        else if([Global searchResult:apText searchText:@"查"])
//            lpFirstLetter = @"Z";
//        else if([Global searchResult:apText searchText:@"能"])
//            lpFirstLetter = @"N";
//        else if([Global searchResult:apText searchText:@"乐"])
//            lpFirstLetter = @"Y";
//        else if([Global searchResult:apText searchText:@"单"])
//            lpFirstLetter = @"S";
//        else
//        {
//            lpFirstLetter = [[NSString stringWithFormat:@"%c",
//                              pinyinFirstLetter([apText characterAtIndex:0])] uppercaseString];
//        }
//        
//        return lpFirstLetter;
//    }
//    else
//        return @"#";
//}


+(BOOL)searchResult:(NSString *)contactName
         searchText:(NSString *)searchT
{
    NSComparisonResult result = [contactName compare:searchT
                                             options:NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame)
        return YES;
    else
        return NO;
    
    
}

@end
