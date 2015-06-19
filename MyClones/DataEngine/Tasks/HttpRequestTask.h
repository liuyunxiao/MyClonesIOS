//
//  HttpRequestTask.h
//  FreeBao
//
//  Created by ye bingwei on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface HttpRequestTask : Task
{
    ASIHTTPRequest *request_;

    NSString *responseParserClassName_;
    NSString *modelClassName_;
}

@property(nonatomic, retain) ASIHTTPRequest *request;
@property(nonatomic, copy) NSString *responseParserClassName;
@property(nonatomic, copy) NSString *modelClassName;
@end
