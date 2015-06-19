//
//  DataEngine.h
//  FreeBao
//
//  Created by ye bingwei on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSingleton.h"
#import "DataDefine.h"
#import "RunInfo.h"
#import "Task.h"
#import "FBTaskResult.h"
#import "NSString+Utils.h"


//#define kHostUrl                        @"http://183.129.236.18:8888/fyd/api/v1/"
#define kHostUrl                        @"http://192.168.0.117:3000/"
//#define kHostUrl                        @"http://192.168.1.53:8888/fyd_2015.6.8/api/v1/"
//#define kHostUrl                        @"http://api.fuyidai.me/fyd/api/v1/"

#define kImageUrl                       @"http://183.129.236.18:8888/fyd/upload/"
//#define kImageUrl                       @"http://192.168.1.53:8888/fyd_2015.6.8/upload/"
//#define kImageUrl                       @"http://api.fuyidai.me/fyd/upload/"

#define kAppStore                       @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=961542273"

#define kPinpinAdvAdress                @"http://www.fuyidai.me/pinpin/pinpin.html"

#define kAppID                          @"961542273"
//设备注册
#define kRegDevice                      kHostUrl@"device/reg"

//1 用户登录
#define kLoginUrl                       kHostUrl@"user/account/login?"

//2 用户注册
#define kRegister                       kHostUrl@"user/account/register?"

//3 用户信息修改
#define kUpdateUser                     kHostUrl@"user/account/updateUser?"

//4 查询实名认证
#define kQueryAuthRealName              kHostUrl@"user/authenticate/queryAuthRealName?"

//5 实名认证(新增和修改)
#define kSaveAuthRealName               kHostUrl@"user/authenticate/saveAuthRealName?"

//6 查询学籍认证
#define kQueryAuthSchoolRoll            kHostUrl@"user/authenticate/queryAuthSchoolRoll?"

//7 学籍认证(新增和修改)
#define kSaveAuthSchoolRoll             kHostUrl@"user/authenticate/saveAuthSchoolRoll?"

//7 学籍认证(新增和修改)
#define kSaveManyAuthSchoolRoll         kHostUrl@"user/authenticate/saveManyAuthSchoolRoll?"

//查询学校 院系 高教园区
#define kQueryAllSchool                 kHostUrl@"user/authenticate/queryAllSchool?"

//8 查询银行卡关联
#define kQueryAuthCard                  kHostUrl@"user/authenticate/queryAuthCard?"

//10 获取银行卡签约信息
#define kQuerySignCardData               kHostUrl@"user/authenticate/querySignCardData?"

//10 银行卡关联(新增和修改)
#define kSaveAuthCard                   kHostUrl@"user/authenticate/saveAuthCard?"

//签约成功通知
#define kAuthSuccess                     kHostUrl@"user/authenticate/authSuccess?"

//11 查询收入支出证明
#define kQueryAuthOther                 kHostUrl@"user/authenticate/queryAuthOther?"

//12 收入证明(新增和修改)
#define kSaveAuthOther                  kHostUrl@"user/authenticate/saveAuthOther?"

//13 查询同学关联
#define kQueryAuthClassmate             kHostUrl@"user/authenticate/queryAuthClassmate?"

//14 同学关联(新增和修改)
#define kSaveAuthClassmate              kHostUrl@"user/authenticate/saveAuthClassmate?"

//15 删除收入支出证明图片
#define kDeleteAuthOtherImg             kHostUrl@"user/authenticate/deleteAuthOtherImg?"

//认证修改确认
#define kAcceptAuth                     kHostUrl@"user/authenticate/acceptAuth?"

//16 查询用户详情
#define kQueryUser                      kHostUrl@"user/myAccount/queryUser?"

//17 用户帐户
#define kQueryUserAccount               kHostUrl@"user/myAccount/queryUserAccount"

//查询用户所有账单
#define kQueryUserBill                  kHostUrl@"user/myBill/queryUserBill"

//查询用户账单详情
#define kQueryUserOrder                 kHostUrl@"user/myBill/queryUserOrder"

//网购代付申请
#define kOnlinePayApply                 kHostUrl@"user/myBill/onlinePayApply"

//线下支付确认
#define kOfflinePayConfirm              kHostUrl@"user/myBill/offlinePayConfirm"

//提交全额还款
#define kFullRepayment                  kHostUrl@"user/myBill/fullRepayment"

//提交全额还款支付处理结果
#define kProcessPaymentResult           kHostUrl@"user/myBill/processPaymentResult"

//查询分期账单详情
#define kQueryBillInstallmentRecord     kHostUrl@"user/myBill/queryBillInstallmentRecord"

//查询分期还款可选期数详情
#define kQueryInstallmentDetail         kHostUrl@"user/myBill/queryInstallmentDetail"

//提交分期分款详情
#define kSubmitInstallment              kHostUrl@"user/myBill/submitInstallment"

//单笔分期还款
#define kSingleInstallment              kHostUrl@"user/myBill/singleInstallment"

//查询用户消费记录
#define kQueryConsumerRecords              kHostUrl@"user/myBill/queryConsumerRecords"

//修改登录密码
#define kUpdatePwd                      kHostUrl@"user/myAccount/updatePwd"

//设置或修改支付密码
#define kSavePayPwd                     kHostUrl@"user/myAccount/savePayPwd"

//发送短信验证码
#define kSendSms                        kHostUrl@"user/account/sendSms"

//校验短信验证码
#define kVerifySms                      kHostUrl@"user/account/verifySms"

//忘记密码
#define kForgotPwd                      kHostUrl@"user/account/forgotPwd"

//用户头像上传
#define kUploadUserAvatar               kHostUrl@"user/myAccount/uploadUserAvatar"

//查询未读消息数量
#define kQueryUnreadMsgCounts           kHostUrl@"device/queryUnreadMsgCounts"

//查询未读消息列表
#define kQueryUnreadMsg                 kHostUrl@"device/queryUnreadMsg"

//查询消息详情
#define kQueryPushMessage               kHostUrl@"device/queryPushMessage"

//领取奖励
#define kReceiveActivitySer             kHostUrl@"device/receiveActivitySer"

//支行名称
#define kBrabankNameList                kHostUrl@"user/myBill/brabankNameList"

//获取提现信息
#define kQueryWithdrawInfo              kHostUrl@"user/myBill/queryWithdrawInfo"

//提交提现申请
#define kSubmitWithdraw                 kHostUrl@"user/myBill/submitWithdraw"

//查询提现明细
#define kQueryWithdrawDetail            kHostUrl@"user/myBill/queryWithdrawDetail"

//查询钱包提现信息
#define kQueryWalletWithdrawInfo        kHostUrl@"user/myBill/queryWalletWithdrawInfo"

//钱包提现申请
#define kSubmitWalletWithdraw           kHostUrl@"user/myBill/submitWalletWithdraw"

//查询钱包收支记录
#define kQueryWalletDetail              kHostUrl@"user/myBill/queryWalletWithdrawDetail"

//查询钱包提现记录
#define kQueryWalletDetail              kHostUrl@"user/myBill/queryWalletWithdrawDetail"

//收支记录
#define kQueryWalletBalance             kHostUrl@"user/myBill/queryWalletBalance"

//周边商家
#define kQueryNearbyShop                kHostUrl@"user/myAccount/queryNearbyShop"

//商家信息
#define kQueryShopInfo                  kHostUrl@"user/shop/queryByShopId"

//商户类型
#define kQueryShopCat                   kHostUrl@"user/shop/cat/query"

//查询广告位
#define kQueryShopAdv                   kHostUrl@"user/shop/adNearbyShop/query"

//获取拼拼活动时间配置
#define kQuerySphd                      kHostUrl@"pinpinActivity/querySphd"

//合成碎片
#define kGetPrize                       kHostUrl@"pinpinActivity/getPrize"

//用户删除已经拥有的碎片
#define kDeleteChip                     kHostUrl@"pinpinActivity/deleteChip"

//用户删除已经拥有的碎片(删除已合成)
#define kDeleteSyntheticChip            kHostUrl@"pinpinActivity/deleteSyntheticChip"

//随机获取9个拼拼碎片
#define kGetValuBefor                   kHostUrl@"pinpinActivity/getValuBefor"

//获取我的已合成碎片
#define kGetSyntheticChips              kHostUrl@"pinpinActivity/getSyntheticChips"

//获取我的未合成碎片
#define kGetMyChips                     kHostUrl@"pinpinActivity/getMyChips"

//获取背景图
#define kQueryJgg                       kHostUrl@"pinpinActivity/queryJgg"

//分配选中碎片
#define kGetRandomCardNum               kHostUrl@"pinpinActivity/getRandomCardNum"

//获取本次活动中赢得奖励的用户
#define kGetWinnerUser                  kHostUrl@"pinpinActivity/getWinnerUser"

//获取本次活动中赢得奖励的人数
#define kGetNumberOfUser                kHostUrl@"pinpinActivity/getNumberOfUser"

//现金兑换
#define kXianjinpinpinActivitySer       kHostUrl@"pinpinActivity/xianjinpinpinActivitySer"

//分享
#define kToShare                        kHostUrl@"pinpinActivity/toShare"

//查询多个关联同学
#define kQueryTwoAuthClassmate          kHostUrl@"user/authenticate/queryTwoAuthClassmate"

//多个关联同学修改
#define kSaveTwoAuthClassmate           kHostUrl@"user/authenticate/saveTwoAuthClassmate"

//查询用户是否通过基础认证
#define kQueryIsAuthed                  kHostUrl@"user/authenticate/queryIsAuthed"

//删除关联同学
#define kDeleteAuthClassmate            kHostUrl@"user/authenticate/deleteAuthClassmate"


#define kDefaultRequestPageSize         20

#define kMinImageQuality                1
#define kMidImageQuality                2
#define kMaxImageQuality                3


@interface DataEngine : NSSingleton
{
    // 用户名密码，当均不为空的时候表示登录成功过，用来实现自动登录
    NSString *username_;
    NSString *password_;
    NSString *USERID_;

    BOOL autoLoginEnabled_; // 自动登录
    
    NSInteger imageQuality_;
    
    BOOL autoClearCache_;
    BOOL guidePage_;
    
    BOOL remeberPwd_;
    
    NSString *version_;
}

@property(nonatomic,copy)   NSString *USERID;
@property(nonatomic,copy)   NSString *username;
@property(nonatomic,copy)   NSString *password;
@property(nonatomic,assign) BOOL autoLoginEnabled;
@property(nonatomic,assign) NSInteger imageQuality;
@property(nonatomic,assign) BOOL autoClearCache;
@property(nonatomic,assign) BOOL guidePage;
@property(nonatomic,copy)   NSString *version;
@property(nonatomic,assign) BOOL remeberPwd;

- (void)setUSERID:(NSString *)aUserId;
- (NSString *)getUSERID;

- (void)setUserName:(NSString *)aUsername;
- (NSString *)getUserName;
- (void)setPassWord:(NSString *)aPassword;
- (NSString *)getPassWord;
- (void)setAutoLoginEnabled:(BOOL)aAutoLoginEnabled;

- (void)setRemeberPwd:(BOOL)show;
- (BOOL)getRemeberPwd;

- (void)setVersion:(NSString *)ver;
- (NSString *)getVersion;

- (void)setPinpinAdvOpenedTaday;
- (BOOL)PinpinAdvOpenedTaday;

- (NSString *)htmStringWithString:(NSString *)aString;

- (Task *)downloadFileWithUrl:(NSString *)aUrl destFilePath:(NSString *)aFilePath observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext;

//设备注册
- (Task *)registerDev:(long)aUserId token:(NSString*)devToken observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext;

//用户登录
- (Task *)login:(NSString *)aUsername password:(NSString *)aPassword observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext;

//用户注册
- (Task *)userRegister:(NSString *)mobile password:(NSString *)aPassword sms:(NSString*)aSms recommended:(NSString*)aRecommended observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext;
@end
