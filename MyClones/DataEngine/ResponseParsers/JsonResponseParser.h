//
//  JsonResponseParser.h
//  FreeBao
//
//  Created by ye bingwei on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResponseParser.h"

#import "Json.h"
#import "DataDefine.h"
#import "NSObject+JsonAddition.h"
#import "NSString+ErrorAddition.h"

@interface JsonResponseParser : ResponseParser
{
 
}

- (BOOL)isSuccess:(NSDictionary *)aData;

- (NSInteger)errorCode:(NSDictionary *)aData;

- (NSString *)errorMessage:(NSDictionary *)aData;

- (NSString *)resultMessage:(NSDictionary *)aData;

@end
