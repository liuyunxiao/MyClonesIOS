//
//  NSString+Utils.h
//  Loan
//
//  Created by JeeRain 13-05-10.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSDate *)dateWithStringFormat:(NSString *)dateString format:(NSString *)formatStr;

+ (NSString *)stringFromDateWithFormat:(NSDate *)date format:(NSString*)fmt;

+ (NSString*)stringDateWithFormat:(NSString*)dateStr;

+ (NSString*)stringDateWithFormat:(NSString*)dateStr format:(NSString*)format;

+ (NSTimeInterval)getNSTimeInterval:(NSString*)dateStr;

+ (NSDate *)dateFromString:(NSString *)dateStr;

+ (long long)getNowNSTimeInterval;

+ (BOOL)isMobileNumber:(NSString*)mobileNum;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isEmailAddress:(NSString *)aString;

+ (BOOL)verifyIDCardNumber:(NSString *)value; 
@end
