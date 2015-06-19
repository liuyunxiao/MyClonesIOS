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



//多个同学关联(新增和修改)
//@protocol RevSaveTwoAuthClassmateInfo
//@end
//
//@interface RevSaveTwoAuthClassmateInfo : ModelBase
//@property(assign, nonatomic) long           id;
//@property(assign, nonatomic) long           userId;
//@property(strong, nonatomic) NSString*      linkPhone;
//@property(strong, nonatomic) NSString*      linkName;
//@property(assign, nonatomic) long           linkUserId;
//@property(assign, nonatomic) ERelationType  relation;
//@property(strong, nonatomic) NSString*      relationName;
//@property(assign, nonatomic) int            status;
//@property(assign, nonatomic) unsigned long  createTime;
//@property(assign, nonatomic) unsigned long  updateTime;
//@end
//
//@interface RevSaveTwoAuthClassmate : RevBase
//@property(strong, nonatomic) NSArray<RevSaveTwoAuthClassmateInfo>* content;
//@end



