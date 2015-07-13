//
//  CLSelf.m
//  MyClones
//
//  Created by lyx on 15/6/26.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLSelf.h"
#import "HttpMgr.h"
#import "DataModel.h"
#import "UserMgr.h"
#import "Common.h"

@interface CLSelf ()

@end

@implementation CLSelf

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshUI];
}

-(void)refreshUI
{
    [labName setText:[[UserMgr sharedInstance] nickName]];
    if([[UserMgr sharedInstance] headPic])
    {
        NSString *str = [NSString stringWithFormat:@"%@%@", HTTP_Pic_Avatar, [[UserMgr sharedInstance] headPic]];
        [imgHead setImageWithURL:[NSURL URLWithString:str]];
    }
    
}

-(IBAction)onClickInfo:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CLSelfInfo"];
    //self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    //[self.parentViewController.navigationController.navigationBar setHidden:NO];
}

@end
