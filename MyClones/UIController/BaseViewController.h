//
//  BaseViewController.h
//  loan
//
//  Created by Yu Zhenwei on 14-12-18.
//  Copyright (c) 2014年 Zhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "SlideNavigationController.h"
#import "DataEngine.h"
#import "InputHelper.h"

@interface BaseViewController : UIViewController
{
    PopViewType popType_;
}

@property(nonatomic,assign) PopViewType popType;
-(void)leftButtonClick:(id)sender;
- (void)pushViewControllerWithDuration:(NSString *)identifier animated:(BOOL)animated;

-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius;
-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius BorderWidth:(CGFloat)borderWidth;
-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor*)color;
-(void)setExtraCellLineHidden:(UITableView *)tableView;
@end
