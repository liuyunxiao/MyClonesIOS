//
//  CLLogin.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLLogin.h"
#import "HttpMgr.h"
#import "DataModel.h"
#import "SlideNavigationController+Utils.h"
#import "CLHome.h"
#import "ContentViewController.h"

@interface CLLogin ()
{
    Task *taskLogin_;
}

@end

@implementation CLLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [inputHelper dismissInputHelper];
}

-(void)onRevLogin:(FBTaskResult *)aResult context:(id)aContext
{
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev || rev.resultCode != EHRC_Success)
    {
        [[MIndicatorView sharedInstance] showWithTitle:aResult.errDesc animated:NO];
        taskLogin_ = nil;
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:Event_Login object:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    taskLogin_ = nil;
}

-(void)sendLogin:(NSMutableDictionary*)dic
{
    if(taskLogin_ == nil)
    {
        taskLogin_ = [[HttpMgr sharedInstance] send:@"SendLogin" data:dic observer:self selector:@selector(onRevLogin:context:) block:YES];
    }
}

-(IBAction)onClickLogin:(id)sender
{
//    if(!texAccountName.text || [texAccountName.text isEqualToString:@""] ||
//       !texPassword.text || [texPassword.text isEqualToString:@""])
//        return;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:texAccountName.text forKey:@"account"];
    [dic setObject:texPassword.text forKey:@"password"];
    
    [self sendLogin:dic];
}

-(IBAction)onClickRegister:(id)sender
{
//    if(![SlideNavigationController pushViewController:@"CLRegister" animated:YES])
//    {
//        
//    }
    
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    
//    // 获取故事板中某个View
//    UIViewController *next = [board instantiateViewControllerWithIdentifier:@"CLRegister"];
//    
//    // 跳转
//    [self presentModalViewController:next animated:NO];
}

-(void)dealloc
{
    //CANCEL_AND_RELEASE_TASK(taskLogin_);
    [texPassword release];
    [texAccountName release];
    
    [super dealloc];
}
@end
