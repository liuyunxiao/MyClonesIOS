//
//  NSObject+JsonAddition.m
//  jsonDemo
//
//  Created by bw ye on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+JsonAddition.h"

@implementation NSObject(JsonAddition)

+ (NSObject *)objectWithJsonValue:(id)aValue
{
    NSObject *obj = nil;
    if (aValue != [NSNull null])
    {
        obj = aValue;
    }
    
    return obj;
}

@end
