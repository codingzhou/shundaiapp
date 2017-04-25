//
//  NSString+Json.m
//  ShunDai
//
//  Created by Mac_key on 17/2/10.
//  Copyright © 2017年 com.ios. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString_Json

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        return responseJSON;
    }

    
@end
