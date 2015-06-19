//
//  DBHelper.m
//  loan
//
//  Created by Yu Zhenwei on 13-8-14.
//  Copyright (c) 2013年 Zhenwei. All rights reserved.
//

#import "DBHelper.h"

#define tablename @"message"

@implementation DBHelper


- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [self openAndCreate];
    }
    
    return self;
}

- (void)openAndCreate
{
    //打开数据库 创建表
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    
    NSString *cacheDir = [dir stringByAppendingPathComponent:@"Caches"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheDir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    cacheDir = [cacheDir stringByAppendingPathComponent:@"fuyidai.db"];
    
    dataBase= [[FMDatabase databaseWithPath:cacheDir] retain];
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        NSLog(@"begin create table");
        [dataBase beginTransaction];
        
        [dataBase executeUpdate:@"create table if not exists message(id INTEGER PRIMARY KEY autoincrement,msgId VARCHAR(20),uid VARCHAR(20),toId VARCHAR(20),type INTEGER,detailType INTEGER,recipientType INTEGER,title VARCHAR(100),content VARCHAR(1000),createTime VARCHAR(20),updateTime VARCHAR(20),sendCount INTEGER,status INTEGER)"];
        
        [dataBase executeUpdate:@"create table if not exists activity(id INTEGER PRIMARY KEY autoincrement,uid VARCHAR(20),msgId VARCHAR(20),activityId VARCHAR(20),checkNo VARCHAR(50),cardNo VARCHAR(50),checkId VARCHAR(20))"];
        
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [dataBase commit];
        [dataBase close];
    }
    else
    {
        NSLog(@"open db failed");
    }
}

- (void)updataMessages:(MessageInfo*)msgItem UID:(NSString*)uid
{
    [dataBase open];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE message SET status=1 WHERE msgId=%@ AND uid=%@ AND toId=%@",[[NSNumber numberWithLong:msgItem.msgId] stringValue],uid,msgItem.recipient];
    
    BOOL a = [dataBase executeUpdate:sql];
    if (!a) {
        NSLog(@"失败");
    }
    
    [dataBase close];
}

- (BOOL)deleteMsgWithId:(NSInteger)seqId
{
    BOOL flag=NO;
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        //开始删除操作
        [dataBase beginTransaction];
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM message where id=%d",seqId];
        flag = [dataBase executeUpdate:sql];
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [dataBase commit];
        //[dataBase close];
    }
    else
    {
        flag=NO;
        NSLog(@"open db failed");
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
    }
    
    return flag;
}

- (int)hasRecord:(MessageInfo*)msgItem UID:(NSString *)uid
{
    int result = -1;
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        
        //开始查询操作
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM message WHERE uid=%@ AND msgId=%@ AND toId=%@",uid,[[NSNumber numberWithLong:msgItem.msgId] stringValue],msgItem.recipient];
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while([rs next])
        {
            result=[rs intForColumn:@"id"];
            break;
        }
        
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [rs close];
        //[dataBase close];
    }
    return result;
}


- (void)insertData:(NSMutableArray *)array UID:(NSString *)uid
{
    [dataBase open];
    //[dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        int count=[array count];
        for (int i = 0; i<count; i++) {
            MessageInfo *item=[array objectAtIndex:i];
            int ret=[self hasRecord:item UID:uid];
            if(ret>=0)
            {
                [self deleteMsgWithId:ret];
            }
            
            NSString *sql = @"INSERT INTO message (msgId,uid,toId,type,detailType,recipientType,title,content,createTime,updateTime,sendCount,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
            
            BOOL a = [dataBase executeUpdate:sql,[[NSNumber numberWithLong:item.msgId] stringValue],
                      [NSString stringWithFormat:@"%@",uid],
                      [NSString stringWithFormat:@"%@",item.recipient],
                      [NSNumber numberWithInt:item.type],
                      [NSNumber numberWithInt:item.detailType],
                      [NSNumber numberWithInt:item.recipientType],
                      [NSString stringWithFormat:@"%@",item.title],
                      [NSString stringWithFormat:@"%@",item.content],
                      [NSString stringWithFormat:@"%@",item.createTime],
                      [NSString stringWithFormat:@"%@",item.updateTime],
                      [NSNumber numberWithInt:item.sendCount],
                      [NSNumber numberWithInt:item.status]];
            
            if (!a) {
                NSLog(@"插入失败");
            }
            
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
    }
    @finally {
        if (!isRollBack) {
            [dataBase commit];
        }
    }
    [dataBase close];
}


- (NSMutableArray *)getCacheDataWithUserID:(NSString *)uid type:(int)aType
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        
        //开始查询操作
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM message WHERE uid=%@ AND type=%d order by createTime desc",uid,aType];
        FMResultSet *rs = [dataBase executeQuery:sql];
        BOOL haveResult = NO;
        while([rs next])
        {
            haveResult = YES;
            MessageInfo *msgItem = [[MessageInfo alloc] init];
            msgItem.msgId = [[rs stringForColumn:@"msgId"] longLongValue];
            msgItem.type = [rs intForColumn:@"type"];
            msgItem.detailType = [rs intForColumn:@"detailType"];
            msgItem.recipient = [rs stringForColumn:@"toId"];
            msgItem.recipientType = [rs intForColumn:@"recipientType"];
            msgItem.title = [rs stringForColumn:@"title"];
            msgItem.content = [rs stringForColumn:@"content"];
            msgItem.status = [rs intForColumn:@"status"];
            msgItem.sendCount = [rs intForColumn:@"sendCount"];
            msgItem.createTime = [rs stringForColumn:@"createTime"];
            msgItem.updateTime = [rs stringForColumn:@"updateTime"];
            
            [array addObject:msgItem];
            [msgItem release];
        }
        if(!haveResult)
        {
       
        }
        
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [rs close];
        [dataBase close];
    }
    return [array autorelease];
}



- (void)insertActivity:(NSString *)uid msgId:(NSString*)aMsgId activityId:(NSString*)aActivityId checkNo:(NSString*)aCheckNo cardNo:(NSString*)aCardNo checkId:(NSString*)aCheckId
{
    [dataBase open];
    
    BOOL isRollBack = NO;
    @try {
        NSString *sql = @"INSERT INTO activity (uid,msgId,activityId,checkNo,cardNo,checkId) VALUES (?,?,?,?,?,?)";
        
        BOOL a = [dataBase executeUpdate:sql,
                  [NSString stringWithFormat:@"%@",uid],
                  [NSString stringWithFormat:@"%@",aMsgId],
                  [NSString stringWithFormat:@"%@",aActivityId],
                  [NSString stringWithFormat:@"%@",aCheckNo],
                  [NSString stringWithFormat:@"%@",aCardNo],
                  [NSString stringWithFormat:@"%@",aCheckId]];
        
        if (!a) {
            NSLog(@"插入失败");
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
    }
    @finally {
        if (!isRollBack) {
            [dataBase commit];
        }
    }
    [dataBase close];
}


- (BOOL)deleteActivityWithId:(NSString *)uid msgId:(NSString*)aMsgId
{
    BOOL flag=NO;
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        //开始删除操作
        [dataBase beginTransaction];
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM activity where uid=%@ AND msgId=%@",uid,aMsgId];
        flag = [dataBase executeUpdate:sql];
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [dataBase commit];
        //[dataBase close];
    }
    else
    {
        flag=NO;
        NSLog(@"open db failed");
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
    }
    
    return flag;

}


- (int)hasActivityRecord:(NSString *)uid msgId:(NSString*)aMsgId activityId:(NSString*)aActivityId checkNo:(NSString**)aCheckNo cardNo:(NSString**)aCardNo checkId:(NSString**)aCheckId
{
    int result = -1;
    if([dataBase open])
    {
        [dataBase setShouldCacheStatements:YES];
        
        //开始查询操作
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM activity WHERE uid=%@ AND msgId=%@ AND activityId=%@",uid,aMsgId,aActivityId];
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while([rs next])
        {
            result=[rs intForColumn:@"id"];
            
            NSString *s1=[rs stringForColumn:@"checkNo"];
            NSString *s2=[rs stringForColumn:@"cardNo"];
            NSString *s3=[rs stringForColumn:@"checkId"];
            *aCheckNo = [s1 copy];
            *aCardNo = [s2 copy];
            *aCheckId=[s3 copy];
            break;
        }
        
        if([dataBase hadError])
        {
            NSLog(@"Error %d : %@",[dataBase lastErrorCode],[dataBase lastErrorMessage]);
        }
        [rs close];
        //[dataBase close];
    }
    return result;
}


@end
