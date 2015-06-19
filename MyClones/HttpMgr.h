//
//  HttpMgr.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "NSSingleton.h"
#import "Task.h"

@interface HttpMgr : NSSingleton


//发送请求（JModel解析)
- (Task *)send:(NSString*)responseClass data:(NSDictionary*)dicData observer:(id)aObserver selector:(SEL)aSelector block:(BOOL)block context:(id)aContext;
@end
