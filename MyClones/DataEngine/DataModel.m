//
//  DataModel.m
//  loan
//
//  Created by lyx on 15/5/25.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "DataModel.h"


@implementation ModelBase

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

-(void)dealloc
{
    [super dealloc];
}
@end

@implementation RevBase

-(void)dealloc
{
    [_resultMsg release];
    [super dealloc];
}
@end

@implementation RevSaveTwoAuthClassmateInfo
-(void)dealloc
{
    [_linkPhone release];
    [_linkName release];
    [_relationName release];
    [super dealloc];
}
@end

@implementation RevSaveTwoAuthClassmate
-(void)dealloc
{
    [_content release];
    [super dealloc];
}
@end

@implementation RevQueryTwoAuthClassmateInfo
-(void)dealloc
{
    [_linkPhone release];
    [_linkName release];
    [_relationName release];
    [super dealloc];
}
@end

@implementation RevQueryTwoAuthClassmate
-(void)dealloc
{
    [_content release];
    [super dealloc];
}
@end
