//
//  AppDelegate.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Json.h"
#import "HttpMgr.h"
#import "Common.h"
#import "UserMgr.h"

BMKMapManager* _mapManager;

@implementation AppDelegate

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * tokenAsString = [[[deviceToken description]
                                 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str = [NSString stringWithFormat:@"Device Token=%@",tokenAsString];
    
    NSLog(@"%@", str);
    [[UserMgr sharedInstance] setDevToken:[tokenAsString copy]];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_DeviceToken object:nil];
}

- (void)application:(UIApplication*)appdidFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:userInfo];
    UIApplicationState appState=[UIApplication sharedApplication].applicationState;
//    if(!(appState==UIApplicationStateActive))
//    {
//        [dic setObject:[NSNumber numberWithBool:YES] forKey:@"NType"];
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    }
//    else{
//        [dic setObject:[NSNumber numberWithBool:NO] forKey:@"NType"];
//    }
//    
//    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"smsreceived" withExtension:@"caf"];
//    if (fileURL != nil)
//    {
//        SystemSoundID theSoundID;
//        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
//        if (error == kAudioServicesNoError){
//            AudioServicesPlaySystemSound(theSoundID);
//        }else {
//            NSLog(@"Failed to create sound ");
//        }
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushMessageNotification object:dic];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[HttpMgr sharedInstance] SetInitData:HTTP_Url port:HTTP_Port];
    
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
															 bundle: nil];
    NSString* str = [[UserMgr sharedInstance] devToken];
    
//    if(![[DataEngine sharedInstance] guidePage])
//    {
//        WelcomeViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
//        
//        [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
//    }

    //ios8注册推送
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //register to receive notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    }
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"U2lvQe0UCfMCoGbPaDD1jhDQ" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    // Override point for customization after application launch.
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:_trackViewURL]];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    //return  [UMSocialSnsService handleOpenURL:url];
//}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    //return  [UMSocialSnsService handleOpenURL:url];
//}
//


- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
@end
