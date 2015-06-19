//
//  DataDefine.m
//  FreeBao
//
//  Created by ye bingwei on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DataDefine.h"
//#import "DataEngine.h"
#import "NSObject+JsonAddition.h"


@implementation PageInfo

@synthesize firstPage = firstPage_;
@synthesize totalPage = totalPage_;
@synthesize lastPage = lastPage_;
@synthesize numberOfElements = numberOfElements_;
@synthesize sortType = sort;
@synthesize pageSize = pageSize_;

+ (id)pageInfoWithDictionary:(NSDictionary*)aDic
{
    PageInfo *info = [[PageInfo alloc] init];

    [info setFirstPage:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"firstPage"]] boolValue]];
    [info setTotalPage:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"totalPages"]] intValue]];
    [info setPageSize:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"size"]] intValue]];
    //[info setSortType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"sort"]] intValue]];
    [info setPageSize:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"numberOfElements"]] intValue]];
    [info setLastPage:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"lastPage"]] boolValue]];

    return [info autorelease];
}

- (BOOL)moreContent
{
    return (!lastPage_);
}

@end


@implementation SortInfo
@synthesize type = type_;
@synthesize property = property_;
@synthesize asi = asi_;

+ (id) sortInfoWithDictionary:(NSDictionary *)aDic
{
    SortInfo *info = [[SortInfo alloc] init];
    
    [info setType:[(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"type"]] intValue]];
    [info setProperty:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"parentId"]] intValue]];
    [info setAsi:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"name"]] intValue]];
    return [info autorelease];
}
@end


@implementation HZLocation

@synthesize country = _country;
@synthesize state = _state;
@synthesize city = _city;
@synthesize district = _district;
@synthesize street = _street;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

-(void)dealloc
{
    [_country release];
    [_state release];
    [_city release];
    [_district release];
    [_street release];
    [super dealloc];
}

@end

@implementation UserAccount

@synthesize userID=userID_;
@synthesize availableAmount=availableAmount_;
@synthesize status=status_;
@synthesize freeAmount=freeAmount_;
@synthesize creditAmount=creditAmount_;
@synthesize createTime=createTime_;
@synthesize updateTime=updateTime_;
@synthesize walletAmount=walletAmount_;

+ (id)userAccountWithJsonDictionary:(NSDictionary *)aDic
{
    if (aDic == nil)
    {
        return nil;
    }
    UserAccount *accInfo = [[UserAccount alloc] init];
    
    [accInfo setUserID:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"id"]] longValue]];
    [accInfo setStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"status"]] intValue]];
    [accInfo setAvailableAmount:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"availableAmount"]]];
    [accInfo setFreeAmount:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"freeAmount"]]];
    [accInfo setCreditAmount:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"creditAmount"]]];
    [accInfo setCreateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"createTime"]]];
    [accInfo setUpdateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"updateTime"]]];
    [accInfo setWalletAmount:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"walletAmount"]]];
    return [accInfo autorelease];
}

- (void)dealloc
{
    [availableAmount_ release];
    [freeAmount_ release];
    [creditAmount_ release];
    [createTime_ release];
    [updateTime_ release];
    [super dealloc];
}

@end

@implementation UserInfo

@synthesize userID = userID_;
@synthesize mphone=mphone_;
@synthesize payPwd=payPwd_;
@synthesize pwd=pwd_;
@synthesize salt=salt_;
@synthesize name=name_;
@synthesize avatar=avatar_;
@synthesize sex=sex_;
@synthesize homeTown=homeTown_;
@synthesize status=status_;
@synthesize creditLevel=creditLevel_;
@synthesize level=level_;
@synthesize facultyId=facultyId_;
@synthesize authenticateStatus=authenticateStatus_;
@synthesize authenticateType=authenticateType_;
@synthesize adminId=adminId_;
@synthesize createTime=createTime_;
@synthesize updateTime=updateTime_;
@synthesize payPwdStatus=payPwdStatus_;
@synthesize authFailMsg=authFailMsg_;
@synthesize userAccount=userAccount_;

+ (id)userInfoWithJsonDictionary:(NSDictionary *)aDic
{
    if (aDic == nil)
    {
        return nil;
    }
    UserInfo *userInfo = [[UserInfo alloc] init];
    
    [userInfo setUserID:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"id"]] longValue]];
    [userInfo setMphone:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"mphone"]]];
    [userInfo setPayPwd:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"payPwd"]]];
    [userInfo setPwd:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"pwd"]]];
    [userInfo setSalt:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"salt"]]];
    [userInfo setName:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"name"]]];
    [userInfo setAvatar:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"avatar"]]];
    [userInfo setSex:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"sex"]] intValue]];
    [userInfo setHomeTown:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"homeTown"]]];
    [userInfo setStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"status"]] intValue]];
    [userInfo setCreditLevel:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"creditLevel"]]];
    [userInfo setLevel:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"level"]] intValue]];
    [userInfo setFacultyId:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"facultyId"]] intValue]];
    [userInfo setAuthenticateType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"authenticateType"]] intValue]];
    [userInfo setAuthenticateStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"authenticateStatus"]] intValue]];
    [userInfo setAdminId:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"adminId"]] longValue]];
    [userInfo setCreateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"createTime"]]];
    [userInfo setUpdateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"updateTime"]]];
    [userInfo setPayPwdStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"payPwdStatus"]] intValue]];
    [userInfo setAuthFailMsg:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"authFailMsg"]]];
    [userInfo setUserAccount:[UserAccount userAccountWithJsonDictionary:[aDic objectForKey:@"userAccount"]]];
    return [userInfo autorelease];
}

- (void)dealloc
{
    [mphone_ release];
    [payPwd_ release];
    [pwd_ release];
    [salt_ release];
    [name_ release];
    [homeTown_ release];
    [createTime_ release];
    [updateTime_ release];
    [creditLevel_ release];
    [super dealloc];
}

@end


@implementation ActivityInfo
@synthesize ID=ID_;
@synthesize toolName=toolName_;
@synthesize title=title_;
@synthesize type=type_;
@synthesize target=target_;
@synthesize endDate=endDate_;
@synthesize beginDate=beginDate_;
@synthesize targetCondition=targetCondition_;
@synthesize pic=pic_;
@synthesize filePath=filePath_;
@synthesize des=des_;
@synthesize status=status_;
@synthesize createTime=createTime_;
@synthesize updateTime=updateTime_;
@synthesize typeString=typeString_;
@synthesize targetString=targetString_;

+ (id)activityInfoWithDic:(NSDictionary *)aDic
{
    ActivityInfo *msgInfo = [[ActivityInfo alloc] init];
    
    [msgInfo setID:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"id"]] longValue]];
    [msgInfo setToolName:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"toolName"]]];
    [msgInfo setTitle:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"title"]]];
    [msgInfo setType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"type"]] intValue]];
    [msgInfo setTarget:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"target"]] intValue]];
    [msgInfo setEndDate:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"endDate"]]];
    [msgInfo setBeginDate:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"beginDate"]]];
    [msgInfo setTargetCondition:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"targetCondition"]]];
    [msgInfo setPic:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"pic"]]];
    [msgInfo setFilePath:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"filePath"]]];
    [msgInfo setDes:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"des"]]];
    [msgInfo setStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"status"]] intValue]];
    [msgInfo setCreateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"createTime"]]];
    [msgInfo setUpdateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"updateTime"]]];
    [msgInfo setTypeString:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"typeString"]]];
    [msgInfo setTargetString:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"targetString"]]];
    return [msgInfo autorelease];
}

-(void)dealloc
{
    [toolName_ release];
    [title_ release];
    [endDate_ release];
    [beginDate_ release];
    [targetCondition_ release];
    [pic_ release];
    [filePath_ release];
    [des_ release];
    [createTime_ release];
    [updateTime_ release];
    [typeString_ release];
    [targetString_ release];
    [super dealloc];
}

@end


@implementation MessageInfo
@synthesize msgId=msgId_;
@synthesize type=type_;
@synthesize detailType=detailType_;
@synthesize recipient=recipient_;
@synthesize recipientType=recipientType_;
@synthesize title=title_;
@synthesize status=status_;
@synthesize sendCount=sendCount_;
@synthesize content=content_;
@synthesize updateTime=updateTime_;
@synthesize createTime=createTime_;
@synthesize activity=activity_;

+ (id)messageInfoWithDic:(NSDictionary *)aDic
{
    MessageInfo *msgInfo = [[MessageInfo alloc] init];
    
    [msgInfo setMsgId:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"id"]] longLongValue]];
    [msgInfo setType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"type"]] intValue]];
    [msgInfo setDetailType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"detailType"]] intValue]];
    [msgInfo setRecipient:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"recipient"]]];
    [msgInfo setRecipientType:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"recipientType"]] intValue]];
    [msgInfo setTitle:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"title"]]];
    [msgInfo setStatus:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"status"]] intValue]];
    [msgInfo setSendCount:[(NSNumber*)[NSObject objectWithJsonValue:[aDic objectForKey:@"sendCount"]] intValue]];
    [msgInfo setContent:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"content"]]];
    [msgInfo setCreateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"createTime"]]];
    [msgInfo setUpdateTime:(NSString*)[NSObject objectWithJsonValue:[aDic objectForKey:@"updateTime"]]];
    
    NSData *jsonData = [[aDic objectForKey:@"content"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    [msgInfo setActivity:[ActivityInfo activityInfoWithDic:temp]];
    
    return [msgInfo autorelease];
}

-(void)dealloc
{
    [recipient_ release];
    [title_ release];
    [content_ release];
    [createTime_ release];
    [updateTime_ release];
    [super dealloc];
}

@end
