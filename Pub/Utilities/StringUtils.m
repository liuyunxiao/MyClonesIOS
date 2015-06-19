//
//  StringUtils.m
//  StockTrader
//
//  Created by hnbc8848 on 12-10-20.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString*)StringDateWithFormat:(NSString*)dateStr
{
    NSString *str=[NSString stringWithFormat:@"%@",dateStr];
    NSTimeInterval time=[str longLongValue];
    NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *fomater=[[[NSDateFormatter alloc] init]autorelease];
    [fomater setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *stringDate=[fomater stringFromDate:modifyDate];
    return stringDate;
}

+ (NSString*)StringDateWithFormat:(NSString*)dateStr format:(NSString*)format
{
    NSString *str=[NSString stringWithFormat:@"%@",dateStr];
    NSTimeInterval time=[str longLongValue];
    NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *fomater=[[[NSDateFormatter alloc] init]autorelease];
    [fomater setDateFormat:format];
    NSString *stringDate=[fomater stringFromDate:modifyDate];
    return stringDate;
}

+(NSTimeInterval)getNSTimeInterval:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];   
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; 
    NSDate* date = [formatter dateFromString:dateStr];
    NSTimeInterval interval=[date timeIntervalSince1970]*1000;
    
    return interval;
}

+(long long)getNowNSTimeInterval
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval interval=[dat timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    return dTime;
}


@end
