//
//  Emoji.m
//  FreeBao
//
//  Created by ye bingwei on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Emoji.h"

@implementation Emoji

@synthesize key = key_;
@synthesize text = text_;
@synthesize fileName = fileName_;

- (void)dealloc
{
    [key_ release];
    [text_ release];
    [fileName_ release];
    
    [super dealloc];
}

@end
