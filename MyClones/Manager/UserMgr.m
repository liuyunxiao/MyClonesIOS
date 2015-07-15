//
//  UserMgr.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "UserMgr.h"

@implementation UserData
@synthesize userId = userId_;
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
@synthesize district = district_;
@synthesize signature = signature_;
@end

@implementation UserMgr
@synthesize login = login_;
@synthesize userData = userData_;
-(id)init
{
    return [super init];
}

-(void)onLogin:(RevLogin*)revLogin
{
    if(!revLogin)
        return;
    
    if(!userData_)
    {
        userData_ = [[UserData alloc] init];
    }
    userData_.userId = revLogin.userId;
    userData_.headPic = revLogin.headPic;
    userData_.age = revLogin.age;
    userData_.sex = revLogin.sex;
    userData_.phone = revLogin.phone;
    userData_.nickName = revLogin.nickName;
    userData_.name = revLogin.name;
    userData_.account = revLogin.account;
    userData_.password = revLogin.password;
    userData_.cardId = revLogin.cardId;
    userData_.district = revLogin.district;
    userData_.signature = revLogin.signature;
    login_ = YES;
}

-(void)loginOut
{
    login_ = NO;
}
@end
