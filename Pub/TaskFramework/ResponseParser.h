//
//  ResponseParser.h
//  SoccerAlarm
//
//  Created by ye bingwei on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "NSObject+JsonAddition.h"

@interface ResponseParser : NSObject

- (TaskResult *)parse:(NSData *)aData;

@end
