//
//  NSString+Utils.m
//  Loan
//
//  Created by JeeRain 13-05-10.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "SlideNavigationController+Utils.h"
#import "BaseViewController.h"

@implementation SlideNavigationController (Utils)

+ (BOOL)pushViewController:(NSString*)mainStoryboardID storyboardID:(NSString*)storyboardID animated:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:mainStoryboardID
                                                             bundle: nil];
    if(!mainStoryboard)
        return NO;
    
    BaseViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:storyboardID];
    
    if(!vc)
        return NO;
    
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:animated];
    
    return YES;
}


+ (BOOL)pushViewController:(NSString*)storyboardID animated:(BOOL)animated
{
    
    return [SlideNavigationController pushViewController:@"MainStoryboard_iPhone" storyboardID:storyboardID animated:animated];
}

@end
