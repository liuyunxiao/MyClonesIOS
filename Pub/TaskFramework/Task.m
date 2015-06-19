//
//  Task.m
//  HairSalon
//
//  Created by ye bingwei on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Task.h"

#pragma mark - TaskQueue

@implementation RunningTaskQueue

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        tasks_ = [[NSMutableArray alloc] init];
        tasksLock_ = [[NSLock alloc] init];
    }
    
    return self;
}

- (void)addTask:(Task *)aTask
{
    NSParameterAssert(aTask!=nil);
    
    [tasksLock_ lock];
    [tasks_ addObject:aTask];
    [tasksLock_ unlock];
}

- (void)removeTask:(Task *)aTask
{
    if (aTask == nil)
    {
        return;
    }
    
    [tasksLock_ lock];
    [tasks_ removeObject:aTask];
    [tasksLock_ unlock];
}

- (void)removeAllTasks
{
    [tasksLock_ lock];
    [tasks_ removeAllObjects];
    [tasksLock_ unlock];
}

- (void)dealloc
{
    [tasks_ release];
    [tasksLock_ release];
    
    [super dealloc];
}

@end

#pragma mark - TaskResult

@implementation TaskResult

@synthesize resultType = resultType_;
@synthesize resultValue = resultValue_;
@synthesize errCode = errCode_;
@synthesize errDesc = errDesc_;

+ (id)resultWithType:(TaskResultType)aResultType value:(id)aResultValue
{
    NSAssert(aResultType!=TASK_RESULT_FAIL, @"Use resultWithErrorCode:description to create a fail result");
    
    TaskResult *result = [[TaskResult alloc] init];
    
    [result setResultType:aResultType];
    [result setResultValue:aResultValue];

    return [result autorelease];
}

+ (id)resultWithErrorCode:(NSInteger)aErrCode description:(NSString *)aErrDesc
{
    TaskResult *result = [[TaskResult alloc] init];
    
    [result setResultType:TASK_RESULT_FAIL];
    [result setErrCode:aErrCode];
    [result setErrDesc:aErrDesc];
    
    return [result autorelease];
}

- (BOOL)isSuccess
{
    return (resultType_ == TASK_RESULT_SUCCESS);
}

- (BOOL)isFail
{
    return (resultType_ == TASK_RESULT_FAIL);    
}

- (BOOL)isStep
{
    return (resultType_ == TASK_RESULT_STEP);
}

- (void)dealloc 
{
    [resultValue_ release];
    [errDesc_ release];
    
    [super dealloc];
}

@end

#pragma mark - Task

@implementation Task

@synthesize observer = observer_;
@synthesize selector = selector_;
@synthesize context = context_;

+ (id)taskWithObserver:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    Task *task = [[Task alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    return [task autorelease];
}

- (id)initWithObserver:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    self = [super init];
    if (self != nil)
    {
        self.observer = aObserver;
        self.selector = aSelector;

        context_ = [aContext retain];
    }
    
    return self;
}

- (void)start
{
    [[RunningTaskQueue sharedInstance] addTask:self];
}

- (void)cancel
{
    self.observer = nil;
    [[RunningTaskQueue sharedInstance] removeTask:self];
}

- (void)notifyWithResult:(TaskResult *)aResult
{
    [observer_ performSelector:selector_ withObject:aResult withObject:context_];
}

- (void)notifyWithResultOnMainThread:(TaskResult *)aResult finished:(BOOL)aFinished
{
    [self performSelectorOnMainThread:@selector(notifyWithResult:) withObject:aResult waitUntilDone:NO];
    
    if (aFinished)
    {
        [[RunningTaskQueue sharedInstance] removeTask:self];
    }
}

- (void)dealloc
{
    [context_ release];

    [super dealloc];
}

@end
