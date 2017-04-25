//
//  ZXCommon.m
//  ZhiXingBus
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Common.h"
//#import "Config.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>  
//#import "DateTools.h"

const double a = 6378245.0;
const double ee = 0.00669342162296594323;

@implementation Common


/*邮箱验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark ----Nva

+ (void)setNavigationBarRightButtonTitleCenter:(UIViewController *)viewController withTitle:(NSString *) title withAction:(SEL)action
{
    UIButton *rightBtn = [[UIButton alloc] init] ;
    [rightBtn addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = 1;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:rightBtn.titleLabel.font}];
    rightBtn.frame = CGRectMake(0, 0,size.width+10,size.height+10);
    
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    [rightBtn setTitleColor:[UIColor whiteColor]/*UIColorFromRGB(0x41aad7)  UIColorFromRGB(0x333333)*/ forState:UIControlStateNormal];
//    [rightBtn setTitleColodsadasr:[UIColor grayColor]/*UIColorFromRGB(0xfab1b8)*/ forState:UIControlStateDisabled];
    UIBarButtonItem* right =  [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = - 13;
    [viewController.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:spaceButtonItem,right,nil]];
}

+ (void)setNavigationBarRightButton:(UIViewController *)viewController withBtnNormalImg:(UIImage *)normalImage withBtnPresImg:(UIImage *)pressImage withTitle:(NSString *)title withAction:(SEL)action
{
    UIButton *leftBtn = [[UIButton alloc] init] ;
    leftBtn.frame = CGRectMake(0, 0,normalImage.size.width + 5, normalImage.size.height + 5);
    [leftBtn setImage:normalImage forState:UIControlStateNormal];
    [leftBtn setImage:pressImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    leftBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    leftBtn.titleLabel.shadowColor = [UIColor blackColor];
    leftBtn.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,16,0,1)];
    
    UIBarButtonItem* left =  [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = 0;
    [viewController.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:spaceButtonItem,left,nil]];
}


+ (void)setNavigationBarLeftButton:(UIViewController *)viewController withBtnNormalImg:(UIImage *)normalImage withBtnPresImg:(UIImage *)pressImage withTitle:(NSString *)title withAction:(SEL)action
{
    UIButton *leftBtn = [[UIButton alloc] init] ;
    leftBtn.frame = CGRectMake(0, 0,normalImage.size.width, normalImage.size.height);
    [leftBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:pressImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    leftBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    leftBtn.titleLabel.shadowColor = [UIColor blackColor];
    leftBtn.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [leftBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,16,0,1)];
    
    
    UIBarButtonItem* left =  [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [viewController.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:spaceButtonItem,left,nil]];
}

+(void) setNavigationTitle:(UIViewController *)viewController withTitle:(NSString *)title{
    CGSize shadowOffset = CGSizeZero;
    UIColor *shadowColor = [UIColor clearColor];
    [self setNavigationTitle:viewController withTitle:title shadowOffsest:shadowOffset shadowColor:shadowColor];
}

+(void) setNavigationTitle:(UIViewController *) viewController withTitle:(NSString *) title shadowOffsest:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor
{
    [[viewController navigationItem] setTitle:title];
    UIFont *font = [UIFont systemFontOfSize:17.0f];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect labelrect = CGRectMake((320 - size.width)/2.0f, (viewController.navigationController.navigationBar.frame.size.height - size.height)/2.0f, size.width, size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:labelrect];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.shadowOffset = shadowOffset;
    label.shadowColor = shadowColor;
    label.textAlignment = NSTextAlignmentCenter;
    viewController.navigationItem.titleView = label;
}

#pragma mark ----dateTime
+ (NSString *)getNoTimeDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *returnStr = @"";
    returnStr = [dateFormatter stringFromDate:date];
    return returnStr;
}

+ (NSString *)getMessageTime:(NSInteger )msgTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSRange rangeDay;
    rangeDay.location = 8;
    rangeDay.length = 2;
    
    NSString *allStrMsg = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]];
    NSString *allStrToday = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]];
    
    
    NSString *stringMsgToday = [allStrMsg substringWithRange:rangeDay];
    NSString *stringNow = [allStrToday substringWithRange:rangeDay];
    
    
    if ([stringMsgToday isEqualToString:stringNow]) {
        NSDateFormatter *dateTimeFormat = [[NSDateFormatter alloc] init];
        [dateTimeFormat setDateStyle:NSDateFormatterMediumStyle];
        [dateTimeFormat setTimeStyle:NSDateFormatterShortStyle];
        [dateTimeFormat setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@",[dateTimeFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]]];
    } else {
        NSRange rangeYear;
        rangeYear.location = 0;
        rangeYear.length = 4;
        
        
        NSString *msgYear = [allStrMsg substringWithRange:rangeYear];
        NSString *nowYear = [allStrMsg substringWithRange:rangeYear];
        
        if ([msgYear isEqualToString:nowYear]) {
            NSRange otherRange;
            otherRange.location = 5;
            otherRange.length= 5;
            return [allStrMsg substringWithRange:otherRange];
        } else {
            return msgYear;
        }
    }
}

+ (NSString *)getMessageCellTime:(NSInteger )msgTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSRange rangeDay;
    rangeDay.location = 8;
    rangeDay.length = 2;
    
    NSString *allStrMsg = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]];
    NSString *allStrToday = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]];
    
    
    NSString *stringMsgToday = [allStrMsg substringWithRange:rangeDay];
    NSString *stringNow = [allStrToday substringWithRange:rangeDay];
    
    NSDateFormatter *dateTimeFormat = [[NSDateFormatter alloc] init];
    [dateTimeFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateTimeFormat setTimeStyle:NSDateFormatterShortStyle];
    [dateTimeFormat setDateFormat:@"HH:mm"];
    
    if ([stringMsgToday isEqualToString:stringNow]) {
        return [NSString stringWithFormat:@"%@",[dateTimeFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]]];
    } else {
        NSRange rangeYear;
        rangeYear.location = 0;
        rangeYear.length = 4;
        
        NSString *msgYear = [allStrMsg substringWithRange:rangeYear];
        NSString *nowYear = [allStrMsg substringWithRange:rangeYear];
        
        if ([msgYear isEqualToString:nowYear]) {
            NSRange otherRange;
            otherRange.location = 5;
            otherRange.length= 5;
            return [NSString stringWithFormat:@"%@ %@", [allStrMsg substringWithRange:otherRange],[dateTimeFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]]];
        } else {
            return [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:msgTime]];
        }
    }
}

+ (NSInteger )getTimeByString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //ApplicationDelegate.dateFormat;
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return [date timeIntervalSince1970];
}

#pragma mark --ImageFunction
+ (NSString *)getDayTime:(NSInteger )msgTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *returnStr = @"";
    returnStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:msgTime]];
    return returnStr;
}

+(UIImage *)imageWithTransImage:(UIImage *)useImage addtransparentImage:(UIImage *)transparentimg
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    [transparentimg drawInRect:CGRectMake(SCREEN_WIDTH - transparentimg.size.width - 30, SCREEN_HEIGHT - 80 - 30 - transparentimg.size.height,transparentimg.size.width, transparentimg.size.height) blendMode:kCGBlendModeOverlay alpha:0.4f];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)addImage:(UIImage *)image1
              toImage:(UIImage *)image2
            imageRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:rect];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

#pragma mark ---School And Express

+ (NSInteger)getExpressCodeWithName:(NSString *)name{
    
    if ([name isEqualToString: @"韵达快递"]) {
        return 1;
    }
    if ([name isEqualToString: @"申通快递"]) {
        return 2;
    }
    if ([name isEqualToString:@"顺丰快递"]) {
        return 3;
    }
    if ([name isEqualToString:@"EMS"]) {
        return 4;
    }
    if ([name isEqualToString:@"圆通快递"]) {
        return 5;
    }
    if ([name isEqualToString:@"中通快递"]) {
        return 6;
    }
    if ([name isEqualToString:@"百事汇通"]) {
        return 7;
    }
    if ([name isEqualToString:@"京东"]) {
        return 8;
    }
    return nil;
}

+ (NSString*)getExpressNameWithCode:(NSInteger)code{
    switch (code) {
        case 1:
            return @"韵达快递";
            break;
        case 2:
            return @"申通快递";
            break;
        case 3:
            return @"顺丰快递";
            break;
        case 4:
            return @"EMS";
            break;
        case 5:
            return @"圆通快递";
            break;
        case 6:
            return @"中通快递";
            break;
        case 7:
            return @"百事汇通";
        case 8:
            return @"京东";
            break;
        default:
            break;
    }
    return nil;

}

+ (NSInteger)getSchoolCodeWithName:(NSString *)name{
    
    if ([name isEqualToString: @"贵州财经大学(花溪校区)"]) {
        return 1;
    }
    if ([name isEqualToString: @"贵州医科大学(花溪校区)"]) {
        return 2;
    }
    if ([name isEqualToString:@"贵州师范大学(花溪校区)"]) {
        return 3;
    }
    if ([name isEqualToString:@"贵州城市学院(花溪校区)"]) {
        return 4;
    }
    if ([name isEqualToString:@"贵州轻工职业技术学院"]) {
        return 5;
    }
    if ([name isEqualToString:@"贵州民族大学花溪校区(花溪校区)"]) {
        return 6;
    }
    return nil;
}

+ (NSString*)getSchoolNameWithCode:(NSInteger)code{
    switch (code) {
        case 1:
            return @"贵州财经大学(花溪校区)";
            break;
        case 2:
            return @"贵州医科大学(花溪校区)";
            break;
        case 3:
            return @"贵州师范大学(花溪校区)";
            break;
        case 4:
            return @"贵州城市学院(花溪校区)";
            break;
        case 5:
            return @"贵州轻工职业技术学院";
            break;
        case 6:
            return @"贵州民族大学花溪校区(花溪校区)";
            break;
        default:
            break;
    }
    return nil;
}





+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length == 11) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)setLogOutTag
{
    return;
}

+ (double)transformLatWithX:(double)x y:(double)y {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

+ (double)transformLonWithX:(double)x y:(double)y {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}


// Get IP Address
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


+ (NSString *)converJsonString:(NSDictionary *)dic
{
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:dataJson encoding:NSUTF8StringEncoding];
    
//    return [strJons stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}


+ (NSString *)getModelName:(NSString *)apiStr
{
    if ([apiStr isEqualToString:@"Guipiao.getRecommentUserList"]
        || [apiStr isEqualToString:@"Guipiao.login"]
        || [apiStr isEqualToString:@"Guipiao.register"]
        || [apiStr isEqualToString:@"Guipiao.getUserDetail"]
        || [apiStr isEqualToString:@"Guipiao.getUserList"]
        || [apiStr isEqualToString:@"Guipiao.password"]) {
        return @"t_27_yonghuliebiao";
    } else if ([apiStr isEqualToString:@"Guipiao.getActiveCountByMonth"]) {
        return @"t_27_huodong";
    } else if ([apiStr isEqualToString:@"Guipiao.asklist"]) {
        return @"t_27_wenti";
    } else if ([apiStr isEqualToString:@"Guipiao.getRoadshowProject"]) {
        return @"t_27_dangqixiangmu";
    } else if ([apiStr isEqualToString:@"Grain.createOrder"]) {
        return @"t_26_order_info";
    } else if ([apiStr isEqualToString:@"Guipiao.getRoadshowProjectDetail"]) {
        return @"t_27_rongzixiangmu";
    }
    return @"";
}



+ (UILabel *)getSepLabel
{
    UILabel *sep = [[UILabel alloc] init];
    sep.backgroundColor = UIColorFromRGB(0xd9d9d9);
    sep.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    
    return sep;
}

@end
