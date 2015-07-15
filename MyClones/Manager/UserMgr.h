//
//  UserMgr.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "NSSingleton.h"
#import "Common.h"
#import "DataModel.h"

@interface UserData : NSObject
{
    NSString        *userId_;
    NSString        *devToken_;
    NSString        *name_;
    NSString        *account_;
    EAccountType    accountType_;
    NSString        *password_;
    NSString        *headPic_;
    NSString        *nickName_;
    NSInteger       age_;
    ESexType        sex_;
    NSString        *cardId_;
    NSString        *phone_;
    NSString        *district_;
    NSString        *signature_;
}
@property(nonatomic, strong)NSString        *userId;
@property(nonatomic, strong)NSString        *devToken;
@property(nonatomic, strong)NSString        *name;
@property(nonatomic, strong)NSString        *account;
@property(nonatomic, assign)EAccountType    accountType;
@property(nonatomic, strong)NSString        *password;
@property(nonatomic, strong)NSString        *headPic;
@property(nonatomic, strong)NSString        *nickName;
@property(nonatomic, assign)NSInteger       age;
@property(nonatomic, assign)ESexType        sex;
@property(nonatomic, strong)NSString        *cardId;
@property(nonatomic, strong)NSString        *phone;
@property(nonatomic, strong)NSString        *district;
@property(nonatomic, strong)NSString        *signature;

@end

@interface UserMgr : NSSingleton
{
    UserData        *userData_;
    BOOL            login_;
}

@property(nonatomic, assign) BOOL           login;
@property(nonatomic, strong) UserData       *userData;
-(void)onLogin:(RevLogin*)revLogin;

-(void)loginOut;
@end
