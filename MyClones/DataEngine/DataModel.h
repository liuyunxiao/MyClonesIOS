//
//  DataModel.h
//  loan
//
//  Created by lyx on 15/5/25.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "JSONModel.h"
#import "DataDefine.h"
#import "Common.h"

@interface ModelBase : JSONModel
@end

@interface RevBase : ModelBase
@property(assign, nonatomic) EHttpRevCode   resultCode;
@property(strong, nonatomic) NSString       *resultMsg;
@end

@interface RevLogin : RevBase
@property(nonatomic, strong) NSString       *userId;
@property(nonatomic, strong) NSString       *name;
@property(nonatomic, strong) NSString       *headPic;
@property(nonatomic, strong) NSString       *nickName;
@property(nonatomic, strong) NSString       *cardId;
@property(nonatomic, strong) NSString       *phone;
@property(nonatomic, assign) ESexType       sex;
@property(nonatomic, assign) int            age;
@property(nonatomic, strong) NSString       *account;
@property(nonatomic, strong) NSString       *password;
@property(nonatomic, strong) NSString       *district;
@property(nonatomic, strong) NSString       *signature;
@end

@interface RevChangeHeadPic : RevBase
@property(nonatomic, strong) NSString       *headPic;
@end



