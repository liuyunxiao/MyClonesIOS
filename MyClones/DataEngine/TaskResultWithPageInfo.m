//
//  FBTaskResult.m
//  FreeBao
//
//  Created by ye bingwei on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FBTaskResult.h"

@implementation FBTaskResult

@synthesize pageInfo = pageInfo_;
@synthesize sortInfo = sortInfo_;

- (BOOL)moreContent
{
    return [pageInfo_ moreContent];
}

+ (id)successResultWithPageInfo:(PageInfo *)aPageInfo Sort:(SortInfo*)sortInfo value:(id)aResultValue
{
    FBTaskResult *result = [[FBTaskResult alloc] init];
    [result setPageInfo:aPageInfo];
    [result setResultType:TASK_RESULT_SUCCESS];
    [result setResultValue:aResultValue];
    
    return [result autorelease];
}

+ (id)successResultWithPageInfo:(id)aResultValue
{
    FBTaskResult *result = [[FBTaskResult alloc] init];
    [result setResultType:TASK_RESULT_SUCCESS];
    [result setResultValue:aResultValue];
    
    return [result autorelease];
}

- (void)dealloc
{
    [pageInfo_ release];
    
    [super dealloc];
}

@end
