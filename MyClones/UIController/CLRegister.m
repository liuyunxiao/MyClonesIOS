//
//  CLRegister.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLRegister.h"
#import "Common.h"
#import "HttpMgr.h"
#import "DataModel.h"
#import "SlideNavigationController+Utils.h"

@interface CLRegister ()
{
    EAccountType        accountType;
    Task                *taskRegister_;
    Task                *taskPhoneCode_;
}

@end

@implementation CLRegister

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
}


-(void)onRevRegister:(FBTaskResult *)aResult context:(id)aContext
{
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
    {
        taskRegister_ = nil;
        return;
    }
    
    if(rev.resultCode == EHRC_Success)
    {
        if(![SlideNavigationController pushViewController:@"CLHome" animated:YES])
        {
            
        }
    }
    else
    {
        [[MIndicatorView sharedInstance] showWithTitle:aResult.errDesc animated:NO];
    }
    
    taskRegister_ = nil;
    //NSLog([taskLogin_ retainCount]);
    //CANCEL_AND_RELEASE_TASK(taskLogin_);
}

-(IBAction)onClickSummit:(id)sender
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:texAccount.text forKey:@"account"];
    [dic setObject:texPassword.text forKey:@"password"];
    [dic setObject:[NSNumber numberWithInt:accountType] forKey:@"type"];
    [dic setObject:texPhoneCode.text forKey:@"code"];
    [dic setObject:texPhone.text forKey:@"phone"];
    
    if(taskRegister_ == nil)
    {
        taskRegister_ = [[HttpMgr sharedInstance] send:@"SendRegister" data:dic observer:self selector:@selector(onRevRegister:context:) block:YES];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)onRevPhoneCode:(FBTaskResult *)aResult context:(id)aContext
{
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
        return;
    if(rev.resultCode == EHRC_Success)
    {
        //        if(![SlideNavigationController pushViewController:@"CLHome" animated:YES])
        //        {
        //
        //        }
    }
    else
    {
        
    }
    
    //NSLog([taskLogin_ retainCount]);
    //CANCEL_AND_RELEASE_TASK(taskLogin_);
}

-(IBAction)onClickRequireCode:(id)sender
{
    if(taskPhoneCode_ == nil)
    {
        taskPhoneCode_ = [[HttpMgr sharedInstance] send:@"SendPhoneCode" data:nil observer:self selector:@selector(onRevPhoneCode:context:) block:YES];
    }
}
@end
