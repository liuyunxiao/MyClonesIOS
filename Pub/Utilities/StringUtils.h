//
//  StringUtils.h
//  StockTrader
//
//  Created by hnbc8848 on 12-10-20.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils: NSObject

+ (NSString*)StringDateWithFormat:(NSString*)dateStr;

+ (NSString*)StringDateWithFormat:(NSString*)dateStr format:(NSString*)format;

+(NSTimeInterval)getNSTimeInterval:(NSString*)dateStr;

+(long long)getNowNSTimeInterval;
@end
