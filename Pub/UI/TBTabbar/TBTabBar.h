//
//  TBTabBar.h
//  TweetBotTabBar
//
//  Created by Jerish Brown on 6/27/11.
//  Copyright 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBTabBarDelegate;
@interface TBTabBar : UIView {
    NSMutableArray *_buttonData;
    NSMutableArray *_buttons;
    NSMutableArray *_labels;
    NSMutableArray *_statusLights;
    id<TBTabBarDelegate> delegate;
    
    BOOL _isShowNotify;
    BOOL _isShowTitle;
    BOOL _isShowIcon;
    UIButton *badgeButton0;
    UIButton *badgeButton2;
}

@property (assign) id<TBTabBarDelegate> delegate;
@property (assign, nonatomic) BOOL isShowNotify;
@property (assign, nonatomic) BOOL isShowTitle;
@property (assign, nonatomic) BOOL isShowIcon;


-(id)initWithItems:(NSArray *)items;

-(void)showDefaults;

-(void)touchDownForButton:(UIButton*)button;
-(void)touchUpForButton:(UIButton*)button;

-(void)setSelectedByIndex:(NSInteger)index;

- (void)setBadge0Hidden:(BOOL)hide;
- (void)setBadge2Hidden:(BOOL)hide;
- (void)setBadgeValue:(NSInteger)num;
-(BOOL)isBadgeButton2Hidden;

@end

@protocol TBTabBarDelegate
-(void)switchViewController:(UIViewController*)vc;
@end