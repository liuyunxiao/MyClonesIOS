//
//  Task.h
//
//  Created by ye bingwei on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSingleton.h"

@class Task;
/*
 If the task creater returns an autorelease task, and the receiver doesnt retain the task, then the task will released if there
 is no a queue at background to retain the new created task, it will cause the asynchorous opertion result will never be notified
 through the task. 
 The task users can ignore this class completely, and the task designer just need to call [super start] or [super cancel] at the 
 begin of the start and cancel method to add or remove the task to (from) the queue;
 */
@interface RunningTaskQueue : NSSingleton
{
@private
    NSMutableArray *tasks_; // running tasks_;
    NSLock *tasksLock_; // tasks lock
}

// Add a running task to the queue with thread safe;
- (void)addTask:(Task *)aTask;

// Remove a running task from the queue with thread safe;
- (void)removeTask:(Task *)aTask;

// Remove all running tasks from the queue with thread safe;
- (void)removeAllTasks;

@end


/*
 The task result type, 
 */
typedef enum
{
    TASK_RESULT_SUCCESS,
    TASK_RESULT_STEP,
    TASK_RESULT_FAIL
} TaskResultType;

/*
 The task result, all the task should use this type of value to notify the result
 */
@interface TaskResult : NSObject
{
@private
    TaskResultType resultType_;
    
    // If the result type is success or step, use this value to access the result;
    id resultValue_;
    
    // If the result type is fail, use the values below;
    NSInteger errCode_;
    NSString *errDesc_;
}

@property(nonatomic, assign)    TaskResultType resultType;
@property(nonatomic, retain)    id resultValue;
@property(nonatomic, assign)    NSInteger errCode;
@property(nonatomic, copy)      NSString *errDesc;

// result accesser
+ (id)resultWithType:(TaskResultType)aResultType value:(id)aValue;

+ (id)resultWithErrorCode:(NSInteger)aErrCode description:(NSString *)aErrDesc;

- (BOOL)isSuccess;

- (BOOL)isFail;

- (BOOL)isStep;

@end


/*
 Task base class
 */
@interface Task : NSObject
{
    id observer_;
    SEL selector_;
    
    id context_;
}

@property(nonatomic, assign)    id observer;
@property(nonatomic, assign)    SEL selector;
@property(nonatomic, readonly)  id context;

// Task instance accessor
+ (id)taskWithObserver:(id)aObserver selector:(SEL)aSelector context:(id)aContext;

- (id)initWithObserver:(id)aObserver selector:(SEL)aSelector context:(id)aContext;

// Start the task, any derived task should call [super start] at the start method to retain a task on the running task queue;
- (void)start;

// Cancel a task, when cancel method is called the observer will never be notified, howerver, it does't make sure the task will stop the routine immediately;
// Any just like above, the derived class should call [super cancel] at the cancel method to release the task on the running task queue;
- (void)cancel;

// Notify the result to the observer, if the task is finised, set the aFinished parameter to YES which will remove the task on the running task queue;
- (void)notifyWithResultOnMainThread:(TaskResult *)aResult finished:(BOOL)aFinished;

@end
