//
//  HttpRequestTask.m
//  FreeBao
//
//  Created by ye bingwei on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HttpRequestTask.h"
#import "ResponseParser.h"
#import "JModelResponseParser.h"

@implementation HttpRequestTask

@synthesize request = request_;
@synthesize responseParserClassName = responseParserClassName_;
@synthesize modelClassName = modelClassName_;


- (void)issueParse:(NSData *)aData
{
    ResponseParser *parser = [[NSClassFromString(responseParserClassName_) alloc] init];
    if([parser isKindOfClass:[JModelResponseParser class]])
    {
        JModelResponseParser* jmodelResponseParser = (JModelResponseParser*)parser;
        [jmodelResponseParser setModelClassName:modelClassName_];
    }
    TaskResult *result = [parser parse:aData];
    [parser release];
    
    if(result.errCode==-100)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSessionTimeOut object:nil];
    }
    
    [self notifyWithResultOnMainThread:result finished:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *rspData = [request_ responseData];
    if ([request.responseCookies count] != 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSetCookieNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:request.responseCookies, @"cookies", nil]];
    }
    
    [self performSelectorOnMainThread:@selector(issueParse:) withObject:rspData waitUntilDone:NO];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSData *rspData = [request_ responseData];
    NSString *str = [[[NSString alloc] initWithData:rspData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", str);
    TaskResult *result = [TaskResult resultWithErrorCode:request.responseStatusCode description:@"网络连接错误"];
    [self notifyWithResultOnMainThread:result finished:YES];
    
    if(request.responseStatusCode==401)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSessionTimeOut object:nil];
    }
}

- (void)start
{
    [super start];
    
    [request_ setTimeOutSeconds:20.f];
    [request_ setDelegate:self];
    [request_ startAsynchronous];
}

- (void)cancel
{
    [super cancel];
    
    [request_ clearDelegatesAndCancel];
}

- (void)dealloc
{
    [request_ clearDelegatesAndCancel];
    [request_ release];
    
    [super dealloc];
}

@end
