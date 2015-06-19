//
//  NSString+Utils.m
//  Loan
//
//  Created by JeeRain 13-05-10.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+ (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter release];
    
    return destDateString;
    
}

+ (NSDate *)dateWithStringFormat:(NSString *)dateString format:(NSString *)formatStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatStr];
    
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    [dateFormatter release];
    
    return destDate;
    
}


+ (NSString *)stringFromDateWithFormat:(NSDate *)date format:(NSString*)fmt{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:fmt];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter release];
    
    return destDateString;
    
}

+ (NSString*)stringDateWithFormat:(NSString*)dateStr
{
    NSString *str=[NSString stringWithFormat:@"%@",dateStr];
    NSTimeInterval time=[str longLongValue];
    NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *fomater=[[[NSDateFormatter alloc] init]autorelease];
    [fomater setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *stringDate=[fomater stringFromDate:modifyDate];
    return stringDate;
}

+ (NSString*)stringDateWithFormat:(NSString*)dateStr format:(NSString*)format
{
    NSString *str=[NSString stringWithFormat:@"%@",dateStr];
    NSTimeInterval time=[str longLongValue];
    NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *fomater=[[[NSDateFormatter alloc] init]autorelease];
    [fomater setDateFormat:format];
    NSString *stringDate=[fomater stringFromDate:modifyDate];
    return stringDate;
}

+ (NSTimeInterval)getNSTimeInterval:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:dateStr];
    NSTimeInterval interval=[date timeIntervalSince1970]*1000;
    
    return interval;
}

+ (NSDate *)dateFromString:(NSString *)dateStr{
    NSString *str=[NSString stringWithFormat:@"%@",dateStr];
    NSTimeInterval time=[str longLongValue];
    NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    return modifyDate;
}


+ (long long)getNowNSTimeInterval
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    //    NSTimeInterval interval=[dat timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    return dTime;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isMobileNumber:(NSString*)mobileNum
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobileNum];
}

+ (BOOL)isEmailAddress:(NSString *)aString
{
    BOOL legal = NO;
    
    do {
        NSString *username = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([username length] == 0) {
            break;
        }
        
        NSUInteger i;
        for (i=0; i<[username length]; i++) {
            unichar c = [username characterAtIndex:i];
            
            if (c > 127) {
                break;
            }
        }
        if (i != [username length]) {
            break;
        }
        
        NSRange range;
        
        range = [username rangeOfString:@"."];
        if (range.location == NSNotFound) {
            break;
        }
        
        range = [username rangeOfString:@"@"];
        if (range.location == NSNotFound) {
            break;
        }
        
        range = [username rangeOfString:@","];
        if (range.location != NSNotFound) {
            break;
        }
        
        range = [username rangeOfString:@".."];
        if (range.location != NSNotFound) {
            break;
        }
        
        range = [username rangeOfString:@" "];
        if (range.location != NSNotFound) {
            break;
        }
        
        range = [username rangeOfString:@"@."];
        if (range.location != NSNotFound) {
            break;
        }
        
        if ([username hasPrefix:@"@"]) {
            break;
        }
        
        if ([username hasSuffix:@"."]) {
            break;
        }
        
        range = [username rangeOfString:@"@"];
        NSString *stringAfter = [username
                                 substringFromIndex:range.location+range.length];
        NSString *stringBefore = [username substringToIndex:range.location];
        
        range = [stringAfter rangeOfString:@"@"];
        if (range.location != NSNotFound) {
            break;
        }
        
        range = [stringBefore rangeOfString:@"@"];
        if (range.location != NSNotFound) {
            break;
        }
        
        range = [stringAfter rangeOfString:@"."];
        if (range.location == NSNotFound) {
            break;
        }
        
        legal = YES;
    } while (NO);
    
    return legal;
}

//验证身份证
//必须满足以下规则
//1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
//2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
//3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
//4. 第17位表示性别，双数表示女，单数表示男
//5. 第18位为前17位的校验位
//算法如下：
//（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
//（2）余数 ＝ 校验和 % 11
//（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
//6. 出生年份的前两位必须是19或20
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

@end
