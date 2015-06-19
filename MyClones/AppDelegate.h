//
//  AppDelegate.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate, ASIHTTPRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *trackViewURL;
@end
