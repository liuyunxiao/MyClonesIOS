//
//  JModelResponseParser.h
//  loan
//
//  Created by lyx on 15/5/25.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "ResponseParser.h"
#import "DataModel.h"

@interface JModelResponseParser : ResponseParser

@property(nonatomic, copy) NSString *modelClassName;
@end
