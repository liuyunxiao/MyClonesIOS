//
//  DBHelper.h
//  guanxin
//
//  Created by Yu Zhenwei on 13-8-14.
//  Copyright (c) 2013年 Zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DataEngine.h"

@interface DBHelper : NSSingleton
{
    @private
    FMDatabase *dataBase;
}


- (void)updataMessages:(MessageInfo*)msgItem UID:(NSString *)uid;
- (void)insertData:(NSMutableArray *)array UID:(NSString *)uid;
- (NSMutableArray *)getCacheDataWithUserID:(NSString *)uid type:(int)aType;

- (int)hasRecord:(MessageInfo*)msgItem UID:(NSString *)uid;
- (BOOL)deleteMsgWithId:(NSInteger)seqId;

- (void)insertActivity:(NSString *)uid msgId:(NSString*)aMsgId activityId:(NSString*)aActivityId checkNo:(NSString*)aCheckNo cardNo:(NSString*)aCardNo checkId:(NSString*)aCheckId;
- (BOOL)deleteActivityWithId:(NSString *)uid msgId:(NSString*)aMsgId;
- (int)hasActivityRecord:(NSString *)uid msgId:(NSString*)aMsgId activityId:(NSString*)aActivityId checkNo:(NSString**)aCheckNo cardNo:(NSString**)aCardNo checkId:(NSString**)aCheckId;;
@end
