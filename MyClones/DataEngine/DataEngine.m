//
//  DataEngine.m
//  FreeBao
//
//  Created by ye bingwei on 11-11-22.
//

#import "DataEngine.h"
#import "HttpRequestTask.h"
#import "HttpDownloadTask.h"
#import "NSString+MD5Addition.h"
#import "NSObject+JSON.h"

#define kKeyOfUserID            @"kKeyOfUserID"
#define kKeyOfUsername          @"kKeyOfUsername"
#define kKeyOfPassword          @"kKeyOfPassword"
#define kKeyOfRememberPasswordEnabled   @"kKeyOfRememberPasswordEnabled"
#define kKeyOfAutoLoginEnabled  @"kKeyOfAutoLoginEnabled"
#define kKeyOfImageQuality      @"kKeyOfImageQuality"
#define kKeyOfAutoClearCache    @"kKeyOfAutoClearCache"
#define kKeyGuidePage           @"kKeyGuidePage"
#define kKeyVersion             @"kKeyVersion"
#define kKeyOfCookieProperties  @"kKeyOfCookieProperties"
#define kKeyPinpinAdvOpen       @"kKeyPinpinAdvOpen"


@implementation DataEngine

@synthesize USERID=USERID_;
@synthesize username = username_;
@synthesize password = password_;
@synthesize autoLoginEnabled = autoLoginEnabled_;
@synthesize imageQuality = imageQuality_;
@synthesize autoClearCache = autoClearCache_;
@synthesize guidePage=guidePage_;
@synthesize version=version_;

#pragma mark - Persistence

- (void)setUSERID:(NSString *)aUserId
{
    [[NSUserDefaults standardUserDefaults] setObject:aUserId forKey:kKeyOfUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUSERID
{
     return [[NSUserDefaults standardUserDefaults] objectForKey:kKeyOfUserID];
}

- (void)setUserName:(NSString *)aUsername
{
    [[NSUserDefaults standardUserDefaults] setObject:aUsername forKey:kKeyOfUsername];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kKeyOfUsername];
}

- (void)setPassWord:(NSString *)aPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:aPassword forKey:kKeyOfPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getPassWord
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kKeyOfPassword];
}

- (void)setAutoLoginEnabled:(BOOL)aAutoLoginEnabled
{
    [[NSUserDefaults standardUserDefaults] setBool:aAutoLoginEnabled forKey:kKeyOfAutoLoginEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)autoLoginEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyOfAutoLoginEnabled];
}

- (void)setRemeberPwd:(BOOL)rember{
    [[NSUserDefaults standardUserDefaults] setBool:rember forKey:kKeyOfRememberPasswordEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)getRemeberPwd
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kKeyOfRememberPasswordEnabled];
}

- (void)setGuidePage:(BOOL)aGuidePage
{
    [[NSUserDefaults standardUserDefaults] setBool:aGuidePage forKey:kKeyGuidePage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)guidePage
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyGuidePage];
}

- (void)setPinpinAdvOpenedTaday
{
    NSDate* date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:kKeyPinpinAdvOpen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)PinpinAdvOpenedTaday
{
    NSDate* dateNow = [NSDate date];
    NSDate* dateBefore = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyPinpinAdvOpen];
    if(!dateBefore)
    {
        return false;
    }
    
    long dd = (long)[dateNow timeIntervalSince1970] - [dateBefore timeIntervalSince1970];
//    if((dd/60) >= 1)
//    {
//        return false;
//    }
    
    if (dd/86400>=1)
    {
        return false;
    }
    
    return true;
}


- (void)setVersion:(NSString *)ver
{
    [[NSUserDefaults standardUserDefaults] setObject:ver forKey:kKeyVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kKeyVersion];
}


- (void)setAutoClearCache:(BOOL)aAutoClearCache
{
    [[NSUserDefaults standardUserDefaults] setBool:aAutoClearCache forKey:kKeyOfAutoClearCache];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)autoClearCache
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyOfAutoClearCache];
}

- (void)setImageQuality:(NSInteger)aImageQuality
{
    [[NSUserDefaults standardUserDefaults] setInteger:aImageQuality forKey:kKeyOfImageQuality];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)imageQuality
{
    imageQuality_ = [[NSUserDefaults standardUserDefaults] integerForKey:kKeyOfImageQuality];
    if (imageQuality_ <= 0)
    {
        [self setImageQuality:kMidImageQuality];
    }
    
    return imageQuality_;
}

- (NSString *)htmStringWithString:(NSString *)aString
{
    //aString = @"[adsf][[adsfa[no] [adsf]dfasdf]";
    if ([aString length] == 0)
    {
        return nil;
    }
    
    NSString *string = [NSString stringWithString:aString];
    NSMutableArray *emojis = [NSMutableArray array];
    
    NSRange leftRange = [string rangeOfString:@"["];
    while (leftRange.location != NSNotFound)
    {
        NSString *subString = [string substringFromIndex:leftRange.location+leftRange.length];

        NSRange rightRange = [subString rangeOfString:@"]"];
        if (rightRange.location == NSNotFound)
        {
            break;
        }
        
        NSString *str = [subString substringToIndex:rightRange.location];
        for (Emoji *emoji in [[RunInfo sharedInstance] emojis])
        {
            if ([[NSString stringWithFormat:@"[%@]",str] isEqualToString:emoji.text])
            {
                [emojis addObject:emoji];
                break;
            }
        }
        
        NSRange range = [subString rangeOfString:@"["];
        if (range.location == NSNotFound)
        {
            break;
        }
        else
        {
            leftRange = NSMakeRange(leftRange.location+leftRange.length+range.location, 1);
        }
    }
    
    for (Emoji *emoji in emojis)
    {
        NSRange range = [string rangeOfString:emoji.text];
        if (range.location == NSNotFound)
        {
            continue;
        }
        
        //NSString *imgUrl = [NSString stringWithFormat:@"<img src=\"http://freebao.com/face/%@\">", emoji.fileName];
        NSString *imgUrl = [NSString stringWithFormat:@"<img src=\"%@\">", emoji.fileName];
        
        string = [string stringByReplacingCharactersInRange:range withString:imgUrl];
    }
    
    return string;
}

- (NSArray *)cookies
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kHostUrl]];
    if ([cookies count] == 0)
    {
        NSDictionary *properties = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyOfCookieProperties];
        if(properties)
            cookies = [NSArray arrayWithObject:[NSHTTPCookie cookieWithProperties:properties]];
    }
    
    return cookies;
}

- (void)onSetCookieNotification:(NSNotification *)aNotification
{
    // Save the cookie
    NSArray *cookies = [aNotification.userInfo objectForKey:@"cookies"];
    if ([cookies count] == 0)
    {
        return;
    }
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[NSURL URLWithString:kHostUrl] mainDocumentURL:nil];
    
    // Persistent
   
    
    for(int i=0;i<[cookies count];i++)
    {
        NSHTTPCookie *cookie = [cookies objectAtIndex:i];
        NSDictionary *properties = cookie.properties;
        NSString *name=[properties objectForKey:@"Name"];
        if([name isEqualToString:@"JSESSIONID"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:properties forKey:kKeyOfCookieProperties];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else if([name isEqualToString:@"systemtime"])
        {
            NSString *systemtime=[properties objectForKey:@"Value"];
            NSLog(@"%@",systemtime);
            if(systemtime!=nil)
                [[RunInfo sharedInstance] setSystemTime:systemtime];
            
        }
    }
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSetCookieNotification:) name:kSetCookieNotification object:nil];
    }
    
    return self;
}


#pragma mark - async tasks;

- (Task *)downloadFileWithUrl:(NSString *)aUrl destFilePath:(NSString *)aFilePath observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpDownloadTask *task = [[HttpDownloadTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    if ([NSURL URLWithString:aUrl] == nil)
    {
        [task release];
        return nil;
    }
    
    [task setFileUrl:[NSURL URLWithString:aUrl]];
    
    [task start];
    
    return [task autorelease];
}

- (void)addCommonParameters:(ASIFormDataRequest *)request
{    
    //屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"print %f,%f",width,height);
    
    //分辨率
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    [request setPostValue:@"ios" forKey:@"os"];
    [request setPostValue:[[UIDevice currentDevice] systemVersion] forKey:@"version"];
    [request setPostValue:[NSNumber numberWithInt:width] forKey:@"width"];
    [request setPostValue:[NSNumber numberWithInt:height] forKey:@"height"];
    [request setPostValue:[NSNumber numberWithDouble:scale_screen] forKey:@"density"];
}

//设备注册
- (Task *)registerDev:(long)aUserId token:(NSString*)devToken observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kRegDevice]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:1] forKey:@"type"];
    [request setPostValue:@"" forKey:@"channelId"];
    [request setPostValue:devToken forKey:@"token"];
    [request setPostValue:[NSNumber numberWithInt:2] forKey:@"deviceType"];
    [request setPostValue:[[UIDevice currentDevice] model] forKey:@"name"];//手机型号
    [request setPostValue:[[UIDevice currentDevice] systemVersion] forKey:@"osVersion"];//系统版本
    
    [task setRequest:request];
    [request release];
    [task start];
    
    return [task autorelease];
    //return true;
    
}



//用户登录 OK
- (Task *)login:(NSString *)aUsername password:(NSString *)aPassword observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    NSParameterAssert(aUsername!=nil && aPassword!=nil);
    
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"LoginResponseParser"];

    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kLoginUrl]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:aUsername forKey:@"mphone"];
//    aPassword =[aPassword stringFromMD5];
    [request setPostValue:aPassword forKey:@"pwd"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//用户注册 OK
- (Task *)userRegister:(NSString *)mobile password:(NSString *)aPassword sms:(NSString*)aSms recommended:(NSString*)aRecommended observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    NSParameterAssert(mobile!=nil);
    
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kRegister]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:mobile forKey:@"mphone"];
    //aPassword =[aPassword stringFromMD5];
    [request setPostValue:aPassword forKey:@"pwd"];
    [request setPostValue:aSms forKey:@"sms"];
    if(aRecommended!=nil&&aRecommended.length>0)
        [request setPostValue:aRecommended forKey:@"recommended"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//用户信息修改
- (Task *)updateBaseInfo:(long)aUserId pwd:(NSString *)aPwd payPwd:(NSString *)aPayPwd name:(NSString *)aName sex:(NSInteger)aSex homeTown:(NSString*)aHomeTown observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"LoginResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kUpdateUser]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"id"];
    [request setPostValue:aPwd forKey:@"pwd"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    [request setPostValue:aName forKey:@"name"];
    [request setPostValue:[NSNumber numberWithInt:aSex] forKey:@"sex"];
    [request setPostValue:aHomeTown forKey:@"homeTown"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


//查询实名认证
- (Task *)queryAuthRealName:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAuthRealName]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
   [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//实名认证(新增和修改)
- (Task *)saveAuthRealName:(long)aId userId:(long)aUserId name:(NSString*)aName idCode:(NSString*)aIdCode sex:(NSInteger)aSex province:(NSString*)aProvince city:(NSString*)aCity file1:(NSData*)file1 file2:(NSData*)file2 lbs:(NSString*)lbs observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveAuthRealName]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aName forKey:@"name"];
    [request setPostValue:aIdCode forKey:@"idCode"];
    [request setPostValue:[NSNumber numberWithInt:aSex] forKey:@"sex"];
    [request setPostValue:aProvince forKey:@"province"];
    [request setPostValue:aCity forKey:@"city"];
    if(lbs)
    {
        [request setPostValue:lbs forKey:@"lbs"];
    }
    
    if (file1 != nil)
    {
        long long interval=[NSString getNowNSTimeInterval];
        NSString *fileName =[NSString stringWithFormat:@"%llu.jpg",interval*1000];
        [request setData:file1 withFileName:fileName andContentType:nil forKey:@"file1"];
    }
    
    if (file2 != nil)
    {
        long long interval=[NSString getNowNSTimeInterval];
        NSString *fileName =[NSString stringWithFormat:@"%llu.jpg",interval*1000];
        [request setData:file2 withFileName:fileName andContentType:nil forKey:@"file2"];
    }
    
    if(lbs)
    {
        [request setPostValue:lbs forKey:@"lbs"];
    }
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询学籍认证
- (Task *)queryAuthSchoolRoll:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAuthSchoolRoll]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//学籍认证(新增和修改)
- (Task *)saveAuthSchoolRoll:(long)aId userId:(long)aUserId facultyId:(long)aFacultyId eduZoneId:(long)aEduZoneId year:(NSString*)aYear totalYear:(NSInteger)totalYear roomAddr:(NSString*)aRoomAddr file1:(NSData*)file1 observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveAuthSchoolRoll]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithLong:aFacultyId] forKey:@"facultyId"];
    [request setPostValue:[NSNumber numberWithLong:aEduZoneId] forKey:@"eduZoneId"];
    [request setPostValue:aYear forKey:@"year"];
    [request setPostValue:[NSNumber numberWithInteger:totalYear] forKey:@"totalYear"];
    [request setPostValue:aRoomAddr forKey:@"roomAddr"];
    if (file1 != nil)
    {
        long long interval=[NSString getNowNSTimeInterval];
        NSString *fileName =[NSString stringWithFormat:@"%llu.jpg",interval*1000];
        [request setData:file1 withFileName:fileName andContentType:nil forKey:@"file1"];
    }
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//学籍认证(新增和修改),多张照片版
- (Task *)saveManyAuthSchoolRoll:(long)aId userId:(long)aUserId facultyId:(long)aFacultyId eduZoneId:(long)aEduZoneId year:(NSString*)aYear totalYear:(NSInteger)totalYear roomAddr:(NSString*)aRoomAddr files:(NSMutableArray*)files observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveManyAuthSchoolRoll]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithLong:aFacultyId] forKey:@"facultyId"];
    [request setPostValue:[NSNumber numberWithLong:aEduZoneId] forKey:@"eduZoneId"];
    [request setPostValue:aYear forKey:@"year"];
    [request setPostValue:[NSNumber numberWithInteger:totalYear] forKey:@"totalYear"];
    [request setPostValue:aRoomAddr forKey:@"roomAddr"];
    if(files)
    {
        for(int i = 0; i < [files count]; ++i)
        {
            long long interval=[NSString getNowNSTimeInterval] + 0.001*i;
            NSString *fileName =[NSString stringWithFormat:@"%llu.jpg",interval*1000];
            [request addData:[files objectAtIndex:i] withFileName:fileName andContentType:nil forKey:@"file1"];
        }
    }
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


// 查询学校 院系 高教园区
- (Task *)queryAllSchool:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAllSchool]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询银行卡关联
- (Task *)queryAuthCard:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAuthCard]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


//获取银行卡签约信息
- (Task *)querySignCardData:(long)aUserId cardNum:(NSString*)aCardNum observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQuerySignCardData]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aCardNum forKey:@"cardNum"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];

}

//新增(更换)银行卡关联
- (Task *)saveAuthCard:(long)aId userId:(long)aUserId cardNum:(NSString*)aCardNum mphone:(NSString*)aMphone payPwd:(NSString*)aPayPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveAuthCard]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    //[request setPostValue:[NSNumber numberWithInt:aCardType] forKey:@"cardType"];
    //[request setPostValue:aBankCode forKey:@"bankCode"];
    if(aPayPwd!=nil&&aPayPwd.length>0)
        [request setPostValue:aPayPwd forKey:@"payPwd"];
    [request setPostValue:aCardNum forKey:@"cardNum"];
    [request setPostValue:aMphone forKey:@"mphone"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//签约成功通知
- (Task *)authSuccess:(long)aId payPwd:(NSString*)aPayPwd noAgree:(NSString*)aNoAgree observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kAuthSuccess]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    if(aPayPwd!=nil&&aPayPwd.length>0)
        [request setPostValue:aPayPwd forKey:@"payPwd"];
    if(aNoAgree!=nil&&aNoAgree.length>0)
        [request setPostValue:aNoAgree forKey:@"noAgree"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询收入支出证明
- (Task *)queryAuthOther:(long)aUserId type:(NSInteger)aType observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAuthOther]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:aType] forKey:@"type"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//收入证明(新增和修改)
- (Task *)saveAuthOther:(long)aId userId:(long)aUserId money:(NSString*)aMoney type:(NSInteger)aType files:(NSMutableArray*)files observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveAuthOther]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aMoney forKey:@"money"];
    [request setPostValue:[NSNumber numberWithInt:aType] forKey:@"type"];
    if (files != nil&&files!=[NSNull null])
    {
        for(int i=0;i<[files count];i++)
        {
            NSData *file=[files objectAtIndex:i];
            long long interval=[NSString getNowNSTimeInterval];
            NSString *fileName =[NSString stringWithFormat:@"%llu%d.jpg",interval*1000,i];
            [request setData:file withFileName:fileName andContentType:nil forKey:@"fileName"];
        }
       
    }
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询同学关联
- (Task *)queryAuthClassmate:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryAuthClassmate]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//同学关联(新增和修改)
- (Task *)saveAuthClassmate:(long)aId userId:(long)aUserId linkPhone:(NSString*)aLinkPhone linkName:(NSString*)aLinkName observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveAuthClassmate]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aId>0)
        [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aLinkPhone forKey:@"linkPhone"];
    [request setPostValue:aLinkName forKey:@"linkName"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//删除收入支出证明图片
- (Task *)deleteAuthOtherImg:(long)authOtherId imgPath:(NSString*)aImgPath observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kDeleteAuthOtherImg]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:authOtherId] forKey:@"authOtherId"];
    [request setPostValue:aImgPath forKey:@"imgPath"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 认证修改确认
- (Task *)acceptAuth:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kAcceptAuth]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


//查询用户详情
- (Task *)queryUser:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUser]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"id"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询用户账户
- (Task *)queryUserAccount:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUserAccount]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询用户所有账单
- (Task *)queryUserBill:(long)aUserId status:(NSInteger)aStatus isInstalments:(NSInteger)aIsInstalments page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUserBill]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    if(aStatus>=0)
        [request setPostValue:[NSNumber numberWithInt:aStatus] forKey:@"status"];
    if(aIsInstalments>=0)
        [request setPostValue:[NSNumber numberWithInt:aIsInstalments] forKey:@"isInstalments"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询用户账单详情
- (Task *)queryUserOrder:(long)aBillId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUserOrder]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"billId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//网购代付申请
- (Task *)onlinePayApply:(long)aUserId userName:(NSString*)aUserName orderCode:(NSString*)aOrderCode channelType:(NSInteger)aChannelType amount:(float)aAmount payPwd:(NSString*)aPayPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kOnlinePayApply]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aUserName forKey:@"userName"];
    [request setPostValue:aOrderCode forKey:@"payOrderCode"];
    [request setPostValue:[NSNumber numberWithInt:aChannelType] forKey:@"channelType"];
    [request setPostValue:[NSNumber numberWithFloat:aAmount] forKey:@"amount"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//线下支付确认
- (Task *)offlinePayConfirm:(long)aUserId shopManagerId:(long)aShopManagerId payPwd:(NSString*)aPayPwd productName:(NSString*)aProductName amount:(NSString*)aAmount orderId:(NSString*)aOrderId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kOfflinePayConfirm]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    //[request setPostValue:[NSNumber numberWithLong:aShopManagerId] forKey:@"shopManagerId"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    [request setPostValue:aProductName forKey:@"productName"];
    [request setPostValue:aAmount forKey:@"amount"];
    [request setPostValue:aOrderId forKey:@"orderId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//提交全额还款
- (Task *)fullRepayment:(long)aBillId payPwd:(NSString*)aPayPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kFullRepayment]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"id"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//提交全额还款支付处理结果 提交分期还款支付处理结果
- (Task *)processPaymentResult:(NSString*)aSign sign_type:(NSString*)aSign_type oid_partner:(NSString*)aOid_partner dt_order:(NSString*)aDt_order no_order:(NSString*)aNo_order oid_paybill:(NSString*)aOid_paybill money_order:(NSString*)aMoney_order result_pay:(NSString*)aResult_pay settle_date:(NSString*)aSettle_date info_order:(NSString*)aInfo_order pay_type:(NSString*)aPay_type bank_code:(NSString*)aBank_code observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kProcessPaymentResult]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:aSign forKey:@"sign"];
    [request setPostValue:aSign_type forKey:@"sign_type"];
    [request setPostValue:aOid_partner forKey:@"oid_partner"];
    [request setPostValue:aDt_order forKey:@"dt_order"];
    [request setPostValue:aNo_order forKey:@"no_order"];
    [request setPostValue:aOid_paybill forKey:@"oid_paybill"];
    [request setPostValue:aMoney_order forKey:@"money_order"];
    [request setPostValue:aResult_pay forKey:@"result_pay"];
    [request setPostValue:aSettle_date forKey:@"settle_date"];
    [request setPostValue:aInfo_order forKey:@"info_order"];
    [request setPostValue:aPay_type forKey:@"pay_type"];
    [request setPostValue:aBank_code forKey:@"bank_code"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询分期账单详情
- (Task *)queryBillInstallmentRecord:(long)aBillId  observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryBillInstallmentRecord]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"billId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}



//查询分期还款可选期数详情
- (Task *)queryInstallmentDetail:(long)aBillId  observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryInstallmentDetail]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"billId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//提交分期分款详情
- (Task *)submitInstallment:(long)aBillId number:(NSInteger)aNumber observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSubmitInstallment]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"billId"];
    [request setPostValue:[NSNumber numberWithInt:aNumber] forKey:@"number"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//单笔分期还款
- (Task *)singleInstallment:(long)aBillId payPwd:(NSString*)aPayPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSingleInstallment]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aBillId] forKey:@"id"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//提交分期还款支付处理结果

//查询用户消费记录
- (Task *)queryConsumerRecords:(long)aUserId start:(NSString*)aStart end:(NSString*)aEnd page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryConsumerRecords]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aUserId>0)
        [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    if(aStart!=nil&&aStart.length>0)
        [request setPostValue:aStart forKey:@"start"];
    if(aEnd!=nil&&aEnd.length>0)
        [request setPostValue:aEnd forKey:@"end"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//修改登录密码
- (Task *)updatePwd:(long)aId pwd:(NSString*)aPwd oldPwd:(NSString*)aOldPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kUpdatePwd]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:aPwd forKey:@"pwd"];
    [request setPostValue:aOldPwd forKey:@"oldPwd"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//设置或修改支付密码
- (Task *)savePayPwd:(long)aId payPwd:(NSString*)aPayPwd oldPayPwd:(NSString*)aOldPayPwd observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSavePayPwd]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aId] forKey:@"id"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    if(aOldPayPwd!=nil&&aOldPayPwd.length>0)
        [request setPostValue:aOldPayPwd forKey:@"oldPayPwd"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//发送短信验证码
- (Task *)sendSms:(NSInteger)aType phone:(NSString*)aPhone observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSendSms]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithInt:aType] forKey:@"type"];
    [request setPostValue:aPhone forKey:@"phone"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//校验短信验证码
- (Task *)verifySms:(NSString*)aPhone sms:(NSString*)aSms observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kVerifySms]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:aPhone forKey:@"phone"];
    [request setPostValue:aSms forKey:@"sms"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//忘记密码
- (Task *)forgotPwd:(NSString*)aPhone password:(NSString*)aPassword type:(NSInteger)aType observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kForgotPwd]];
    //    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:aPhone forKey:@"phone"];
    [request setPostValue:aPassword forKey:@"pwd"];
    [request setPostValue:[NSNumber numberWithInteger:aType] forKey:@"type"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//用户头像上传
- (Task *)uploadUserAvatar:(long)aUserId file1:(NSData*)aFile1 observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kUploadUserAvatar]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    
    if (aFile1 != nil)
    {
        long long interval=[NSString getNowNSTimeInterval];
        NSString *fileName =[NSString stringWithFormat:@"%llu.jpg",interval*1000];
        [request setData:aFile1 withFileName:fileName andContentType:nil forKey:@"file1"];
    }
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 查询未读消息数量
- (Task *)queryUnreadMsgCounts:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUnreadMsgCounts]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"recipient"];
    [request setPostValue:[NSNumber numberWithInteger:1] forKey:@"recipientType"];
//    [request setPostValue:[NSNumber numberWithInteger:1] forKey:@"type"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 查询未读消息列表
- (Task *)queryUnreadMsg:(long)aUserId msgType:(NSInteger)aType page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryUnreadMsg]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"recipient"];
    [request setPostValue:[NSNumber numberWithInteger:1] forKey:@"recipientType"];
    [request setPostValue:[NSNumber numberWithInteger:aType] forKey:@"type"];
    [request setPostValue:[NSNumber numberWithInteger:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInteger:aSize] forKey:@"size"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 查询消息详情
- (Task *)queryMsgDetail:(long)aMsgId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryPushMessage]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aMsgId] forKey:@"id"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 领取奖励
- (Task *)receiveActivitySer:(long)aUserId userType:(NSInteger)aUserType activityId:(long)aActivityId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kReceiveActivitySer]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithLong:aUserType] forKey:@"userType"];
    [request setPostValue:[NSNumber numberWithLong:aActivityId] forKey:@"activityId"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 查询支行列表
- (Task *)brabankNameList:(NSString*)aBankCode cityCode:(NSString*)aCityCode brabankName:(long)aBrabankName observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kBrabankNameList]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:aBankCode forKey:@"bankCode"];
    [request setPostValue:aCityCode forKey:@"cityCode"];
    [request setPostValue:aBrabankName forKey:@"brabankName"];
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取提现信息
- (Task *)queryWithdrawInfo:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryWithdrawInfo]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//提交提现申请  提现类型cashType  0：额度提现 1：钱包提现
- (Task *)submitWithdraw:(long)aUserId payPwd:(NSString*)aPayPwd amount:(NSString*)aAmount prcptcd:(NSString*)aPrcptcd cashType:(NSInteger)aCashType observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request =nil;
    if(aCashType==1)
    {
        request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSubmitWalletWithdraw]];
    }
    else
    {
        request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSubmitWithdraw]];
    }
    
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:aPayPwd forKey:@"payPwd"];
    [request setPostValue:aAmount forKey:@"amount"];
    if(aPrcptcd!=nil&&aPrcptcd.length>0)
        [request setPostValue:aPrcptcd forKey:@"prcptcd"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

// 查询提现明细
- (Task *)queryWithdrawDetail:(long)aUserId page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryWithdrawDetail]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询钱包提现信息
- (Task *)queryWalletWithdrawInfo:(long)aUserId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryWalletWithdrawInfo]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询钱包提现记录
- (Task *)queryWalletDetail:(long)aUserId page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryWalletDetail]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    //1[request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//收支记录
- (Task *)queryWalletBalance:(long)aUserId page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryWalletBalance]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    //1[request setPostValue:[NSNumber numberWithLong:aUserId] forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//周边商家
- (Task *)queryNearbyShop:(NSString*)catId latitude:(double)latitude longitude:(double) longitude distance:(NSInteger)distance page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryNearbyShop]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(distance>0)
    {
        [request setPostValue:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
        [request setPostValue:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
        [request setPostValue:[NSNumber numberWithInt:distance] forKey:@"distance"];
    }
    if(catId)
    {
        [request setPostValue:[NSNumber numberWithInt:[catId longLongValue]] forKey:@"catId"];
    }
    
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

-(Task*)queryShopInfo:(NSString*)indexID observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryShopInfo]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:indexID forKey:@"id"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//商家类型
-(Task*)queryShopCat:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryShopCat]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//商家广告
-(Task*)queryShopAdv:(long) indexID province:(NSString*)provinceName city:(NSString*)cityName observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryShopAdv]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(provinceName != nil && cityName != nil && ![provinceName isEqual:@""] && ![cityName isEqual:@""])
    {
        [request setPostValue:provinceName forKey:@"provinceName"];
        [request setPostValue:[cityName substringToIndex:[cityName length] - 1] forKey:@"cityName"];
    }
    else
    {
        [request setPostValue:[NSNumber numberWithLong:indexID] forKey:@"id"];
    }
    
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取拼拼活动时间配置
- (Task *)querySphd:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQuerySphd]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//合成碎片
- (Task *)getPrize:(long)aActivityId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetPrize]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aActivityId] forKey:@"activityId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//用户删除已经拥有的碎片
- (Task *)deleteChip:(long)activitySerId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kDeleteChip]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:activitySerId] forKey:@"activitySerId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//用户删除已经拥有的碎片(删除已合成)
- (Task *)deleteSyntheticChip:(long)syntheticChipId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kDeleteSyntheticChip]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:syntheticChipId] forKey:@"syntheticChipId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//随机获取9个拼拼碎片
- (Task *)getValuBefor:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetValuBefor]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取我的已合成碎片
- (Task *)getSyntheticChips:(NSInteger)aType page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetSyntheticChips]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aType>0)
        [request setPostValue:[NSNumber numberWithInt:aType] forKey:@"type"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取我的未合成碎片
- (Task *)getMyChips:(NSInteger)aType page:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetMyChips]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    if(aType>0)
        [request setPostValue:[NSNumber numberWithInt:aType] forKey:@"type"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取背景图
- (Task *)queryJgg:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryJgg]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//分配选中碎片
- (Task *)getRandomCardNum:(long)aChipId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetRandomCardNum]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aChipId] forKey:@"id"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取本次活动中赢得奖励的用户
- (Task *)getWinnerUser:(NSInteger)aPage size:(NSInteger)aSize observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetWinnerUser]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithInt:aPage] forKey:@"page"];
    [request setPostValue:[NSNumber numberWithInt:aSize] forKey:@"size"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//获取本次活动中赢得奖励的人数
- (Task *)getNumberOfUser:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetNumberOfUser]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//现金碎片兑换
- (Task *)xianjinpinpinActivitySer:(long)aChipId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kXianjinpinpinActivitySer]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aChipId] forKey:@"id"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//分享
- (Task *)toShare:(long)aChipId activityId:(long)aActivityId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kToShare]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:aChipId] forKey:@"syntheticChipId"];
    [request setPostValue:[NSNumber numberWithLong:aActivityId] forKey:@"activityId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//查询多个关联同学
- (Task *)queryTwoAuthClassmate:(long)userID observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    //[task setResponseParserClassName:@"JModelResponseParser"];
    //[task setModelClassName:@"RevQueryTwoAuthClassmate"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryTwoAuthClassmate]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:userID] forKey:@"userId"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//多个关联同学修改
- (Task *)saveTwoAuthClassmate:(long)userID classmateID:(long)classmateID relationship:(ERelationType)relationship phone:(NSString*)phone name:(NSString*)name observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    //[task setModelClassName:@"RevSaveTwoAuthClassmate"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kSaveTwoAuthClassmate]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:userID] forKey:@"userId"];
    //[request setPostValue:[NSNumber numberWithLong:classmateID] forKey:@"id"];
    [request setPostValue:[NSNumber numberWithShort:relationship] forKey:@"relation"];
    [request setPostValue:phone forKey:@"linkPhone"];
    [request setPostValue:name forKey:@"linkName"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


//查询用户是否通过基础认证
- (Task *)queryIsAuthed:(NSString*)phone observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    //[task setModelClassName:@"RevQueryIsAuthed"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kQueryIsAuthed]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:phone forKey:@"mphone"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}

//删除关联同学
- (Task *)deleteAuthClassmate:(long)userId observer:(id)aObserver selector:(SEL)aSelector context:(id)aContext
{
    HttpRequestTask *task = [[HttpRequestTask alloc] initWithObserver:aObserver selector:aSelector context:aContext];
    
    [task setResponseParserClassName:@"RequestResponseParser"];
    //[task setModelClassName:@"ModelBase"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kDeleteAuthClassmate]];
    [request setRequestCookies:[NSMutableArray arrayWithArray:[self cookies]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSNumber numberWithLong:userId] forKey:@"id"];
    [task setRequest:request];
    [request release];
    
    [task start];
    
    return [task autorelease];
}


- (void)dealloc
{
    RELEASE_OBJECT(username_);
    RELEASE_OBJECT(password_);
    
    [super dealloc];
}

@end
