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


- (void)dealloc
{
    RELEASE_OBJECT(username_);
    RELEASE_OBJECT(password_);
    
    [super dealloc];
}

@end
