//
//  JsonResponseParser.m
//  FreeBao
//
//  Created by ye bingwei on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JsonResponseParser.h"
#import "NSObject+JsonAddition.h"

@implementation JsonResponseParser

- (BOOL)isSuccess:(NSDictionary *)aData
{
    NSInteger resultCode=[(NSNumber*)[NSObject objectWithJsonValue:[aData objectForKey:@"resultCode"]] intValue];
    return resultCode==1?YES:NO;
}

- (NSInteger)errorCode:(NSDictionary *)aData
{
    if (aData == nil)
    {
        return -1;
    }
    
    return [(NSNumber*)[NSObject objectWithJsonValue:[aData objectForKey:@"resultCode"]] intValue];
}

- (NSString *)errorMessage:(NSDictionary *)aData
{
    if (aData == nil)
    {
        return @"未知错误";
    }
    
    return (NSString*)[NSObject objectWithJsonValue:[aData objectForKey:@"resultMsg"]];
}


- (NSString *)resultMessage:(NSDictionary *)aData
{
    return (NSString*)[NSObject objectWithJsonValue:[aData objectForKey:@"resultMsg"]];
}

@end
