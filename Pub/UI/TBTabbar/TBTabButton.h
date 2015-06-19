//
//  TBTabButton.h
//  TweetBotTabBar
//
//  Created by Jerish Brown on 6/27/11.
//  Copyright 2011 i3Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBTabNotification.h"

@interface TBTabButton : NSObject {
    NSString *title;
    UIColor *_titleColor;
    UIColor *_titleHighColor;
    UIColor *_backgroudColor;
    UIColor *_backgroudHighColor;
    UIImage *icon;
    UIImage *highlightedIcon;
    NSMutableArray *_notifications;
    TBTabNotification *_light;
}

@property (retain,nonatomic) NSString *title;
@property (retain,nonatomic) UIColor *titleColor;
@property (retain,nonatomic) UIColor *titleHighColor;
@property (retain,nonatomic) UIColor *backgroudColor;
@property (retain,nonatomic) UIColor *backgroudHighColor;
@property (retain) UIImage *icon;
@property (retain) UIImage *highlightedIcon;

-(id)initWithIcon:(UIImage*)icon;

-(void)addNotification:(NSDictionary *)notif;
-(void)removeNotificationAtIndex:(NSUInteger)index;
-(void)clearNotifications;
-(NSInteger)notificationCount;

-(TBTabNotification*)notificationView;

@end
