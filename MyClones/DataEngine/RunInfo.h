//
//  RunInfo.h
//  FreeBao
//
//  Created by ye bingwei on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSingleton.h"
#import "Emoji.h"

@interface RunInfo : NSSingleton
{
@private
    NSString        *passId_;
    NSString        *uId_;
    
    NSString         *password_;
    
    BOOL            isLogined_;
    
    NSMutableDictionary  *emojis_;
    
    
    NSString *deviceToken_;
    
    UserInfo        *loginUserInfo_;
    double currentLongitude_;
    double currentLatidude_;
    NSString *province_;
    NSString *city_;
    NSString *lbsAddress_;
    
    NSInteger noticeType_;
    
    NSDictionary *realNameDic_;
    NSDictionary *schoolDic_;
    NSDictionary *bankCardDic_;
    NSDictionary *cell9CoverDic_;
    NSMutableArray *cell9ValueDic_;
    NSDictionary *currentPlayDic_;
    long long int  systemTime_;
    NSTimer *taskListTimer;
    
    //商户类型
    NSArray *shopCatArray_;
    
    BOOL isPlaying_;
}

@property(nonatomic, retain) NSString *passId;
@property(nonatomic, retain) NSString *uId;
@property(nonatomic, assign) double currentLongitude;
@property(nonatomic, assign) double currentLatidude;
@property(nonatomic, retain) NSString *province;
@property(nonatomic, retain) NSString *city;
@property(nonatomic, retain) NSString *lbsAddress;

@property(nonatomic, retain) NSString *password;
@property(nonatomic, assign) BOOL isLogined;
@property(nonatomic, retain) NSMutableDictionary *emojis;

@property(nonatomic,copy) NSString *deviceToken;
@property(nonatomic, retain) UserInfo *loginUserInfo;



@property(nonatomic,assign) NSInteger noticeType;

@property(nonatomic, retain) NSDictionary *realNameDic;
@property(nonatomic, retain) NSDictionary *schoolDic;
@property(nonatomic, retain) NSDictionary *bankCardDic;
@property(nonatomic, retain) NSDictionary *cell9CoverDic;
@property(nonatomic, retain) NSMutableArray *cell9ValueDic;
@property(nonatomic, retain) NSDictionary *currentPlayDic;
@property(nonatomic, retain) NSArray *shopCatArray;
@property(nonatomic, assign) BOOL isPlaying;

-(void)setSystemTime:(NSString*)time;
-(NSDate*)SystemTime;
@end
