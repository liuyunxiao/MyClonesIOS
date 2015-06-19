//
//  RequestResponseParser.m
//  FreeBao
//
//  Created by ye bingwei on 11-12-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RequestResponseParser.h"

@implementation RequestResponseParser

- (FBTaskResult *)parse:(NSData *)aData
{
    NSString *str = [[[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", str);
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dic = [parser objectWithData:aData];
    [parser release];
    
    FBTaskResult *result = nil;
    
    // 判断是否成功先
    if (![self isSuccess:dic])
    {
        NSInteger code = [self errorCode:dic];
        result =  [FBTaskResult resultWithErrorCode:code description:[self resultMessage:dic]];
    }
    else
    {
        NSDictionary *content=[dic objectForKey:@"content"];
        result = [FBTaskResult resultWithType:TASK_RESULT_SUCCESS value:content];
    }
    
    return result;

}

@end
