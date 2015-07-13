//
//  UserMgr.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "UserMgr.h"

@implementation UserMgr
@synthesize devToken = devToken_;
@synthesize name = name_;
@synthesize account = account_;
@synthesize accountType = accountType_;
@synthesize password = password_;
@synthesize headPic = headPic_;
@synthesize nickName = nickName_;
@synthesize age = age_;
@synthesize sex = sex_;
@synthesize cardId = cardId_;
@synthesize phone = phone_;
@synthesize login = login_;

-(id)init
{
    return [super init];
}

-(void)onLogin:(RevLogin*)revLogin
{
    if(!revLogin)
        return;
    
    headPic_ = revLogin.headPic;
    age_ = revLogin.age;
    sex_ = revLogin.sex;
    phone_ = revLogin.phone;
    nickName_ = revLogin.nickName;
    
    login_ = YES;
}

-(void)loginOut
{
    login_ = NO;
}
@end
