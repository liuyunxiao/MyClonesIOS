//
//  CLHome.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLHome.h"
#import "ContentViewController.h"


@implementation CLHome

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!bLogin)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                                 bundle: nil];
        UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavLogin"];
        
        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:vc animated:NO completion:^(void){
            
        }];
        bLogin = YES;
    }
    
}



-(void)viewDidLoad
{
    bLogin = NO;
    //[self.view setHidden:YES];
    [super viewDidLoad];
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:Event_Login object:nil queue:nil usingBlock:^(NSNotification *note) {
    }];
    
    return;
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

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self.navigationController.navigationBar setHidden:YES];
    //NSLog(viewController.tabBarItem.title);
    self.navigationItem.title = viewController.tabBarItem.title;
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

-(IBAction)onClickText:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLLogin"];
    
    [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:vc animated:NO completion:^(void){
        
    }];
}
@end
