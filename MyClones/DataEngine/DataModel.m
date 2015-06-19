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

