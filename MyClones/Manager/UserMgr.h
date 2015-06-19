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
    NSString        *name;
    NSString        *account;
    EAccountType    accountType;
    NSString        *password;
    
    
}
@end
