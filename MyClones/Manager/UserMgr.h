//
//  UserMgr.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "NSSingleton.h"
#import "Common.h"

@interface UserMgr : NSSingleton
{
    NSString        *devToken_;
    NSString        *name_;
    NSString        *account_;
    EAccountType    accountType_;
    NSString        *password_;
}
@property(nonatomic, strong) NSString       *devToken;
@property(nonatomic, assign) BOOL           sendDevToken;

-(BOOL)isLogin;
@end
