//
//  JModelResponseParser.m
//  loan
//
//  Created by lyx on 15/5/25.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "JModelResponseParser.h"

@implementation JModelResponseParser
@synthesize modelClassName = modelClassName_;

- (FBTaskResult *)parse:(NSData *)aData
{
    NSString *str = [[[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", str);
    
    JSONModelError* jError = nil;
    RevBase* model = [[NSClassFromString(modelClassName_) alloc] initWithString:str usingEncoding:NSUTF8StringEncoding error:&jError];
    
    FBTaskResult *result = nil;
    
    if(model == nil)
    {
        result =  [FBTaskResult resultWithErrorCode:-1 description:@"异常"];
    }
//    else if(model.resultCode != EHRC_Success)
//    {
//        result =  [FBTaskResult resultWithErrorCode:model.resultCode description:model.resultMsg];
//    }
    else
    {
        result = [FBTaskResult resultWithType:TASK_RESULT_SUCCESS value:model];
    }
    return result;
}
@end
