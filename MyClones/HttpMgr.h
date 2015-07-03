//
//  HttpMgr.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "NSSingleton.h"
#import "Task.h"

@interface HttpCmdData : NSObject
{
}
@property(nonatomic, retain)NSString    *reqURL;
@property(nonatomic, retain)NSString    *name;
@property(nonatomic, retain)NSString    *resClass;
@end

@interface HttpMgr : NSSingleton
{
}

-(void)SetInitData:(NSString*)baseURL port:(NSString*)port;
-(void)RegisterAllRequestData;
-(void)RegisterRequestData:(NSString*)name reqURL:(NSString*)reqURL resClass:(NSString*)resClass;

//发送请求（JModel解析)
- (Task *)send:(NSString*)name data:(NSDictionary*)dicData observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block;

- (Task *)send:(NSString*)name data:(NSDictionary*)dicData files:(NSArray*)arryFiles observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block;
@end
