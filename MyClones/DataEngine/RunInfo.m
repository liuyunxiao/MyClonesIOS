//
//  RunInfo.m
//  FreeBao
//
//  Created by ye bingwei on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RunInfo.h"

@implementation RunInfo

@synthesize passId = passId_;
@synthesize uId = uId_;
@synthesize password=password_;
@synthesize isLogined = isLogined_;
@synthesize emojis = emojis_;
@synthesize deviceToken=deviceToken_;
@synthesize loginUserInfo = loginUserInfo_;

@synthesize currentLongitude=currentLongitude_;
@synthesize currentLatidude=currentLatidude_;
@synthesize province = province_;
@synthesize city = city_;
@synthesize lbsAddress = lbsAddress_;

@synthesize noticeType=noticeType_;

@synthesize realNameDic=realNameDic_;
@synthesize schoolDic=schoolDic_;
@synthesize bankCardDic=bankCardDic_;
@synthesize cell9CoverDic=cell9CoverDic_;
@synthesize cell9ValueDic=cell9ValueDic_;
@synthesize currentPlayDic=currentPlayDic_;
@synthesize shopCatArray=shopCatArray_;
@synthesize isPlaying=isPlaying_;

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
        emojis_ = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
    }
    
    return self;
}

-(void)setSystemTime:(NSString*)time
{
    systemTime_=[time longLongValue];
    
    if(taskListTimer==nil)
    {
        taskListTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
}

-(NSDate*)SystemTime
{
    long long int time=systemTime_/1000;
    NSDate *now =[NSDate dateWithTimeIntervalSince1970:time];
    return now;
}

-(void)timeFireMethod
{
    systemTime_+=1000;
}

- (void)dealloc
{
    [taskListTimer invalidate];
    if(realNameDic_!=nil)
    {
        [realNameDic_ release];
        realNameDic_=nil;
    }
    
    if(schoolDic_!=nil)
    {
        [schoolDic_ release];
        schoolDic_=nil;
    }
    
    if(bankCardDic_!=nil)
    {
        [bankCardDic_ release];
        bankCardDic_=nil;
    }
    
    if(cell9CoverDic_!=nil)
    {
        [cell9CoverDic_ release];
        cell9CoverDic_=nil;
    }
    
    if(shopCatArray_ != nil)
    {
        [shopCatArray_ release];
        shopCatArray_ = nil;
    }
    [passId_ release];
    [uId_ release];
    [super dealloc];
}

@end
