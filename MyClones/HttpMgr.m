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
#import "Common.h"

@interface HttpCmdData ()
{
    NSString        *reqURL_;
    NSString        *name_;
    NSString        *resClass_;
}
@end

@implementation HttpCmdData
@synthesize reqURL = reqURL_;
@synthesize name = name_;
@synthesize resClass = resClass_;

@end

@interface HttpMgr ()
{
    NSString                *baseURL_;
    NSString                *port_;
    NSMutableDictionary     *dicCmdData_;
    NSString                *mainURL_;
}
@end

@implementation HttpMgr

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSetCookieNotification:) name:kSetCookieNotification object:nil];
        
        [self RegisterAllRequestData];
    }
    
    return self;
}

- (NSArray *)cookies
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:HTTP_Url]];
    if ([cookies count] == 0)
    {
        NSDictionary *properties = [[NSUserDefaults standardUserDefaults] objectForKey:Cach_Key_CookieProperties];
        if(properties)
            cookies = [NSArray arrayWithObject:[NSHTTPCookie cookieWithProperties:properties]];
    }
    
    return cookies;
}

- (void)onSetCookieNotification:(NSNotification *)aNotification
{
    // Save the cookie
    NSArray *cookies = [aNotification.userInfo objectForKey:@"cookies"];
    if ([cookies count] == 0)
    {
        return;
    }
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[NSURL URLWithString:HTTP_Url] mainDocumentURL:nil];
    
    for(int i=0;i<[cookies count];i++)
    {
        NSHTTPCookie *cookie = [cookies objectAtIndex:i];
        NSDictionary *properties = cookie.properties;
        NSString *name=[properties objectForKey:@"Name"];
        if([name isEqualToString:@"JSESSIONID"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:properties forKey:Cach_Key_CookieProperties];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else if([name isEqualToString:@"systemtime"])
        {
            NSString *systemtime=[properties objectForKey:@"Value"];
            NSLog(@"%@",systemtime);
            if(systemtime!=nil)
                [[RunInfo sharedInstance] setSystemTime:systemtime];
            
        }
    }
}

-(void)SetInitData:(NSString*)baseURL port:(NSString*)port
{
    baseURL_ = baseURL;
    port_ = port;
    mainURL_ = [[NSString alloc] initWithFormat:@"%@:%@/", baseURL, port];
    [mainURL_ retain];
}

-(void)RegisterAllRequestData
{
    if(!dicCmdData_)
    {
        dicCmdData_ = [[NSMutableDictionary alloc] init];
    }
    else
    {
        [dicCmdData_ removeAllObjects];
    }
    
    [self RegisterRequestData:@"SendLogin" reqURL:@"account/login" resClass:@"RevLogin"];
    [self RegisterRequestData:@"SendRegister" reqURL:@"account/register" resClass:@"RevBase"];
    [self RegisterRequestData:@"SendPhoneCode" reqURL:@"account/phonecode" resClass:@"RevBase"];
    [self RegisterRequestData:@"SendCheckAccount" reqURL:@"account/checkAccount" resClass:@"RevBase"];
    
    [self RegisterRequestData:@"SendQueryDynamicByType" reqURL:@"dynamic/queryDynamicByType" resClass:@"RevBase"];
    
    [self RegisterRequestData:@"SendChangeHeadPic" reqURL:@"self/changeHeadPic" resClass:@"RevBase"];
}

-(void)RegisterRequestData:(NSString*)name reqURL:(NSString*)reqURL resClass:(NSString*)resClass
{
    HttpCmdData *data = [[HttpCmdData alloc] init];
    data.name = name;
    data.reqURL = reqURL;
    data.resClass = resClass;
    
    [dicCmdData_ setObject:data forKey:name];
}

- (Task *)send:(NSString*)name data:(NSDictionary*)dicData files:(NSArray*)arryFiles observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block;
{
    HttpCmdData *data = [dicCmdData_ objectForKey:name];
    if(!data)
    {
        return nil;
    }
    
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:nil];
    
    [task setModelClassName:data.resClass];
    [task setResponseParserClassName:@"JModelResponseParser"];
    
    NSString *strURl = [NSString stringWithFormat:@"%@%@", mainURL_, data.reqURL];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
    
    [request setRequestMethod:@"POST"];
    //todo?
    if(![name isEqualToString:@"SendLogin"])
        [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    
    if(dicData)
    {
        for(NSString* key in dicData)
        {
            [request setPostValue:[dicData objectForKey:key]  forKey:key];
        }
    }
    
    if(arryFiles)
    {
        for(NSDictionary* dic in arryFiles)
        {
            [request addData:[dic objectForKey:@"data"] withFileName:[dic objectForKey:@"name"] andContentType:[dic objectForKey:@"type"] forKey:[dic objectForKey:@"key"]];
        }
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

- (Task *)send:(NSString*)name data:(NSDictionary*)dicData observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block
{
    return [self send:name data:dicData files:nil observer:aObserver selector:aSelector block:block];
}

@end
