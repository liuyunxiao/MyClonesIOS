//
//  FBTaskResult.h
//  FreeBao
//
//  Created by ye bingwei on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Task.h"
@interface FBTaskResult : TaskResult
{
    PageInfo *pageInfo_;
    SortInfo *sortInfo;
}

@property(nonatomic, retain) PageInfo *pageInfo;
@property(nonatomic, retain) SortInfo *sortInfo;

+ (id)successResultWithPageInfo:(PageInfo *)aPageInfo  Sort:(SortInfo*)sortInfo value:(id)aResultValue;
+ (id)successResultWithPageInfo:(id)aResultValue;
- (BOOL)moreContent;

@end
