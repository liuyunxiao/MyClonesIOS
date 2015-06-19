//
//  HttpMgr.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "HttpMgr.h"
#import "HttpRequestTask.h"
#import "HttpDownloadTask.h"


@implementation HttpMgr
- (Task *)send:(NSString*)responseClass data:(NSDictionary*)dicData observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block context:(id)aContext
{
    NSParameterAssert(dicData!=nil);
    
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:responseClass];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kLoginUrl]];
    [request setRequestMethod:@"POST"];
    
    for(NSString* key in dicData)
    {
        [request setPostValue:dicData[key]  forKey:key];
    }
    [task setRequest:request];
    [request release];
    if(block)
    {
        [[MIndicatorView sharedInstance] showWithTitle:@"请稍后..." animated:YES];
    }
    [task start];
    return [task autorelease];
}

@end
