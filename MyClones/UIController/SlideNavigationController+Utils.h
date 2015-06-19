//
//  NSString+Utils.h
//  Loan
//
//  Created by JeeRain 13-05-10.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationController.h"

@interface SlideNavigationController (Utils)

+ (BOOL)pushViewController:(NSString*)mainStoryboardID storyboardID:(NSString*)storyboardID animated:(BOOL)animated;


+ (BOOL)pushViewController:(NSString*)storyboardID animated:(BOOL)animated;

@end
