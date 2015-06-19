//
//  DataDefine.h
//  FreeBao
//
//  Created by ye bingwei on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define kNotificationLoginSuccess    @"kNotificationLoginSuccess"
#define kNotificationLogOut          @"kNotificationLogOut"

#define kSetCookieNotification       @"kSetCookieNotification"
#define kPushMessageNotification     @"kPushMessageNotification"
#define kSessionTimeOut              @"kSessionTimeOut"
#define kReloginNotification         @"kReloginNotification"
#define kNotificationRegSuccess      @"kNotificationRegSuccess"
#define kOtherLoginNotification      @"kOtherLoginNotification"

#define kNotificationBillDoRefresh   @"kNotificationBillRefresh"
#define kNotificationBillRefreshed   @"kNotificationBillRefreshed"
#define kNotificationMsgStatus       @"kNotificationMsgStatus"
#define kNotificationUserRefresh     @"kNotificationUserRefresh"
#define kNotificationDeviceToken     @"kNotificationDeviceToken"
#define kNotificationPinpinClose     @"kNotificationPinpinClose"

#define kPageOfSize 200


////正式环境 认证支付商户号
//#define kVerifyPayID  @"201408071000001543"
//#define kVerifyPayKey @"201408071000001543test_20140812"
//
////正式环境 快捷支付商户号
//#define kQuickPayID  @"201408071000001546"
//#define kQuickPayKey @"201408071000001546_test_20140815"

typedef enum
{
    CS      = 0,    //初始值
    DRZ     = 1,    //待认证
    RZTG    = 2,    //认证通过
    RZSB    = 3     //认证失败
}AuthStatus;

typedef enum
{
    SM      = 1,    //实名认证
    XJ      = 2,    //学籍认证
    JHK     = 4,    //银行卡关联
    SR      = 8,    //收入证明
    ZC      = 16,   //支出证明
    TX      = 32    //同学关联
}AuthType;

typedef enum
{
    WHK     =0,     //未还款
    YHK     =1,     //已还款
    YQ      =2      //逾期
}BillStatus;

typedef enum
{
    PopPRE  =0,     //上一步
    PopROOT =1,     //root
    PopTO   =2      //指定
}PopViewType;

typedef enum
{
    WZH     =0,     //正在审核中
    YZH     =1,     //已支付
    WWC     =2      //支付失败
}OrderStatus;

typedef enum
{
    DNXF    =1,     //店内消费
    WGDF    =2,     //网购代付
    YHTX    =3,     //用户提现
    QEQE    =4,     //全额还款
    FQHK    =5      //分期还款
}OrderType;


typedef enum
{
    SEX     =1000,  //性别
    PROVINCE=1001,  //省份
    CITY    =1002,  //城市
    XX      =1003,  //学校
    ZY      =1004,  //专业
    GJYQ    =1005,  //高教园区
    YEAR    =1006,   //入学年份
    BANK    =1007,   //银行
    TOTALYEAR    =1008   //学制
}PickerViewType;

typedef enum
{
    ZCXX    =1,  //注册消息 1
    RZXX    =2,  //认证消息 1
    DFXX    =3,  //代付消息 1
    XXXFXX  =4,  //下消费消息 1
    ZDTZ    =5,  //账单通知消息 1
    ZDYQ    =6,  //逾期消息 1
    HD      =7,  //活动消息 2
    GG      =8,  //广告消息 2
    XT      =9   //系统消息 1
}MsgType;

typedef enum
{
//    sy(1, "收银"), yj(2, "佣金"), df(3, "网购代付"), xx(4, "线下消费"), hk(5, "还款"), tx(
//                                                                         6, "提现"), fqsxf(7, "分期手续费"), yqsxf(8, "逾期手续费"), txsxf(9,
//                                                                                                                               "提现手续费"), tjrjl(10, "推荐人奖励"), byqrjl(11, "被邀请人奖励"), qbtx(12,
//                                                                                                                                                                                        "钱包提现"), qbtxsxf(13, "钱包提现手续费"), ppxjjl(14, "拼拼现金奖励");
    SY=1,
    YJ=2,
    DF=3,
    XXXF=4,
    HK=5,
    EDTX=6,
    FQSXF=7,
    YQSXF=8,
    TXSXF=9,
    TJRJL=10,
    BYQRJL=11,
    QBTX=12,
    QBTXSXF=13,
    PPXJJL=14,
    ZZCGJL=15
}BillType;

typedef enum
{
    ERT_Null = -1,
    ERT_Couple,
    ERT_Roommate,
    ERT_Friend,
    ERT_Classmate,
    ERT_All,
}ERelationType;


typedef enum
{
    ERST_Null,
    ERST_Auditing,
    ERST_NoPass,
    ERST_Complete,
    ERST_All,
}ERelaionStateType;

#define BillStatusDesc(key,value)({if(key==WHK) value=@"未还款";else if(key==YHK) value=@"已还款";else value=@"逾期";})

#define OrderStatusDesc(key,value)({if(key==WZH) value=@"正在审核中";else if(key==YZH) value=@"已支付";else value=@"支付失败";})

#define OrderTypeDesc(key,value)({if(key==DNXF) value=@"店内消费";else if(key==WGDF) value=@"网购代付";else if(key==YHTX) value=@"用户提现";else if(key==QEQE) value=@"全额还款";else if(key==FQHK) value=@"分期还款";else value=@"未知";})

#define BillTypeDesc(key,value)({if(key==SY) value=@"收银";else if(key==YJ) value=@"佣金";else if(key==DF) value=@"网购代付";else if(key==XXXF) value=@"线下消费";else if(key==HK) value=@"还款";else if(key==EDTX) value=@"提现";else if(key==FQSXF) value=@"分期手续费";else if(key==YQSXF) value=@"逾期手续费";else if(key==TXSXF) value=@"提现手续费";else if(key==TJRJL) value=@"推荐人奖励";else if(key==BYQRJL) value=@"被邀请人奖励";else if(key==QBTX) value=@"钱包提现";else if(key==QBTXSXF) value=@"钱包提现手续费";else if(key==PPXJJL) value=@"拼拼现金奖励";else if(key==ZZCGJL) value=@"注册成功奖励";})

@interface PageInfo : NSObject
{
@private
    NSInteger totalPage_;
    BOOL    firstPage_;
    BOOL    lastPage_;
    NSInteger numberOfElements_;
    
    NSInteger sort;
    NSInteger pageSize_;
}

@property(nonatomic, assign) NSInteger totalPage;
@property(nonatomic, assign) BOOL firstPage;
@property(nonatomic, assign) BOOL lastPage;
@property(nonatomic, assign) NSInteger numberOfElements;
@property(nonatomic, assign) NSInteger sortType;
@property(nonatomic, assign) NSInteger pageSize;

+ (id)pageInfoWithDictionary:(NSDictionary*)aDic;

- (BOOL)moreContent;

@end

// 排序数据结构
@interface SortInfo : NSObject
{
@private
    NSInteger type_;
    NSInteger property_;      //
    NSInteger asi_; 
}

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign) NSInteger property;
@property(nonatomic, assign) NSInteger asi;

+ (id) sortInfoWithDictionary:(NSDictionary *)aDic;

@end


@interface HZLocation : NSObject
{
    @private
    NSString    *_country;
    NSString    *_state;
    NSString    *_city;
    NSString    *_district;
    NSString    *_street;
    double      _latitude;
    double      _longitude;
}

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end

@interface UserAccount : NSObject
{
@private
    long        userID_;
    NSString    *availableAmount_;
    NSInteger   status_;
    NSString    *freeAmount_;
    NSString    *creditAmount_;
    NSString    *createTime_;
    NSString    *updateTime_;
    NSString    *walletAmount_;
}
@property(nonatomic,assign)   long      userID;
@property(nonatomic,copy)   NSString    *availableAmount;
@property(nonatomic,assign) NSInteger   status;
@property(nonatomic,copy)   NSString    *freeAmount;
@property(nonatomic,copy)   NSString    *creditAmount;
@property(nonatomic,copy)   NSString    *createTime;
@property(nonatomic,copy)   NSString    *updateTime;
@property(nonatomic,copy)   NSString    *walletAmount;

+ (id)userAccountWithJsonDictionary:(NSDictionary *)aDic;

@end


// 用户信息
@interface UserInfo : NSObject
{
@private
    
    long        userID_;            //用户ID
    NSString    *mphone_;           //手机号码
    NSString    *payPwd_;           //支付密码
    NSString    *pwd_;              //密码
    NSString    *salt_;             //salt
    NSString    *name_;             //姓名
    NSString    *avatar_;
    NSInteger   sex_;               //姓别 1:男 2:女
    NSString    *homeTown_;         //籍贯
    NSInteger   status_;            //状态 1:有效 2:禁用
    NSString    *creditLevel_;       //信用等级
    NSInteger   level_;             //会员等级
    NSInteger   facultyId_;         //所属院系
    NSInteger   authenticateType_;  //认证类型
    NSInteger   authenticateStatus_;//认证状态
    long        adminId_;           //认证操作员
    NSString    *createTime_;       //创建时间
    NSString    *updateTime_;       //更新时间
    NSInteger   payPwdStatus_;
    NSString    *authFailMsg_;
    UserAccount *userAccount_;
}

@property(nonatomic,assign)   long      userID;
@property(nonatomic,copy)   NSString    *mphone;
@property(nonatomic,copy)   NSString    *payPwd;
@property(nonatomic,copy)   NSString    *pwd;
@property(nonatomic,copy)   NSString    *salt;
@property(nonatomic,copy)   NSString    *name;
@property(nonatomic,copy)   NSString    *avatar;
@property(nonatomic,assign) NSInteger   sex;
@property(nonatomic,copy)   NSString    *homeTown;
@property(nonatomic,assign) NSInteger   status;
@property(nonatomic,copy)   NSString    *creditLevel;
@property(nonatomic,assign) NSInteger   level;
@property(nonatomic,assign) NSInteger   facultyId;
@property(nonatomic,assign) NSInteger   authenticateType;
@property(nonatomic,assign) NSInteger   authenticateStatus;
@property(nonatomic,assign) long        adminId;
@property(nonatomic,copy)   NSString    *createTime;
@property(nonatomic,copy)   NSString    *updateTime;
@property(nonatomic,assign) NSInteger   payPwdStatus;
@property(nonatomic,copy)   NSString    *authFailMsg;
@property(nonatomic,retain) UserAccount *userAccount;

+ (id)userInfoWithJsonDictionary:(NSDictionary *)aDic;

@end

@interface ActivityInfo : NSObject
{
    long        ID_;
    NSString    *toolName_;
    NSString    *title_;
    NSInteger   type_;
    NSInteger   target_;
    NSString    *endDate_;
    NSString    *beginDate_;
    NSString    *targetCondition_;
    NSString    *pic_;
    NSString    *filePath_;
    NSString    *des_;
    NSInteger   status_;
    NSString    *createTime_;
    NSString    *updateTime_;
    NSString    *typeString_;
    NSString    *targetString_;
}

@property(nonatomic,assign) long        ID;
@property(nonatomic,copy)   NSString    *toolName;
@property(nonatomic,copy)   NSString    *title;
@property(nonatomic,assign) NSInteger   type;
@property(nonatomic,assign) NSInteger   target;
@property(nonatomic,copy)   NSString    *endDate;
@property(nonatomic,copy)   NSString    *beginDate;
@property(nonatomic,copy)   NSString    *targetCondition;
@property(nonatomic,copy)   NSString    *pic;
@property(nonatomic,copy)   NSString    *filePath;
@property(nonatomic,copy)   NSString    *des;
@property(nonatomic,assign) NSInteger   status;
@property(nonatomic,copy)   NSString    *createTime;
@property(nonatomic,copy)   NSString    *updateTime;
@property(nonatomic,copy)   NSString    *typeString;
@property(nonatomic,copy)   NSString    *targetString;

+ (id)activityInfoWithDic:(NSDictionary *)aDic;

@end


//消息
@interface MessageInfo : NSObject
{
    @private
    
    long        msgId_;
    int         type_;
    int         detailType_;
    NSString    *recipient_;
    int         recipientType_;
    NSString    *title_;
    int         status_;
    int         sendCount_;
    NSString    *content_;
    NSString    *createTime_;
    NSString    *updateTime_;
    ActivityInfo *activity_;
}

@property(nonatomic,assign) long        msgId;
@property(nonatomic,assign) int         type;
@property(nonatomic,assign) int         detailType;
@property(nonatomic,copy)   NSString    *recipient;
@property(nonatomic,assign) int         recipientType;
@property(nonatomic,copy)   NSString    *title;
@property(nonatomic,assign) int         status;
@property(nonatomic,assign) int         sendCount;
@property(nonatomic,copy)   NSString    *content;
@property(nonatomic,copy)   NSString    *createTime;
@property(nonatomic,copy)   NSString    *updateTime;
@property(nonatomic,retain) ActivityInfo *activity;

+ (id)messageInfoWithDic:(NSDictionary *)aDic;

@end
