//
//  CLHome.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLHome.h"
#import "ContentViewController.h"
#import "HttpMgr.h"
#import "DataModel.h"
#import "UserMgr.h"

@interface CLHome ()
{
    Task        *taskQueryDynamicByType;
    Task        *taskRegisterDevToken;
    BOOL        bSendDevToken;
}

@end

@implementation CLHome

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(![[UserMgr sharedInstance] login])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                                 bundle: nil];
        UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavLogin"];
        
        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:vc animated:NO completion:^(void){
            
        }];
    }
}



-(void)viewDidLoad
{
    bSendDevToken = NO;
    //[self.view setHidden:YES];
    [super viewDidLoad];
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:Notification_Login object:nil queue:nil usingBlock:^(NSNotification *note) {
        if(!taskQueryDynamicByType)
        {
            taskQueryDynamicByType = [[HttpMgr sharedInstance] send:@"SendQueryDynamicByType" data:nil observer:self selector:@selector(onRevQueryDynamicByType:context:) block:YES];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceTokenNotification:) name:Notification_DeviceToken object:nil];
}

-(void)regDeviceToken
{
    NSString* tokenStr=[NSString stringWithFormat:@"%@",[[UserMgr sharedInstance] devToken]];
    
    if([[RunInfo sharedInstance] isLogined]&&tokenStr!=nil&&![tokenStr isEqualToString:@"(null)"])
    {
        taskRegisterDevToken=[[[DataEngine sharedInstance] registerDev:[[[RunInfo sharedInstance] uId] longLongValue] token:tokenStr observer:self selector:@selector(onRegisterDevResult:context:) context:nil] retain];
    }
}

-(void)onDeviceTokenNotification:(NSNotification*)aNotification
{
    [self regDeviceToken];
}

-(void)onRevQueryDynamicByType:(FBTaskResult *)aResult context:(id)aContext
{
    taskQueryDynamicByType = nil;
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode == EHRC_Success)
    {
        
    }
    else
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
    }
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
