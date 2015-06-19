//
//  CLHome.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLHome.h"


@implementation CLHome

-(void)viewDidLoad
{
    [super viewDidLoad];
    viewPages = [[NSMutableArray alloc] init];
    
    UIView* viewDynamic = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"VBottomMenuDynamic" owner:nil options:nil] lastObject];
    [viewPages addObject:viewDynamic];
    [self.view addSubview:viewDynamic];
    
    UIView* viewPhantasm = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"VBottomMenuPhantasm" owner:nil options:nil] lastObject];
    [viewPages addObject:viewPhantasm];
    [self.view addSubview:viewPhantasm];

    UIView* viewHello = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"VBottomMenuHello" owner:nil options:nil] lastObject];
    [viewPages addObject:viewHello];
    [self.view addSubview:viewHello];

    UIView* viewSelf = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"VBottomMenuSelf" owner:nil options:nil] lastObject];
    [viewPages addObject:viewSelf];
    [self.view addSubview:viewSelf];
}


-(void)onClickBottomMenum:(id)sender
{
    UIButton *btn = sender;
    curSelBottomMenu = btn.tag;
    for(int i = 0; i < EUIBT_All; ++i)
    {
        UIButton *btn = (UIButton*)[viewBottomMenu viewWithTag:i+1];
        UIView *view = (UIView*)[viewPages objectAtIndex:i];
        
        if(curSelBottomMenu == i)
        {
            [btn setSelected:YES];
            [view setHidden:NO];
        }
        else
        {
            [btn setSelected:NO];
            [view setHidden:YES];
        }
    }
}
@end
