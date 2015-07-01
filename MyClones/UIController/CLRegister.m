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
    Task                *taskCheckAccount_;
}

@end

@implementation CLRegister

-(void)viewDidLoad
{
    [super viewDidLoad];
    texPassword.secureTextEntry = YES;
    texConformPassword.secureTextEntry = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(texAccount == textField)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:texAccount.text forKey:@"account"];
        
        if(taskCheckAccount_ == nil)
        {
            taskCheckAccount_ = [[HttpMgr sharedInstance] send:@"SendCheckAccount" data:dic observer:self selector:@selector(onRevCheckAccount:context:) block:YES];
        }
    }
}

-(void)onRevCheckAccount:(FBTaskResult *)aResult context:(id)aContext
{
    taskCheckAccount_ = nil;
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode == EHRC_Success)
    {
        //[[MIndicatorView sharedInstance] showWithTitle:@"账号可用" animated:NO];
    }
    else
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
    }
}


-(void)onRevRegister:(FBTaskResult *)aResult context:(id)aContext
{
    taskRegister_ = nil;
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode == EHRC_Success)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[MIndicatorView sharedInstance] showWithTitle:@"注册成功，请登录" animated:NO];
    }
    else
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
    }
}

-(IBAction)onClickSummit:(id)sender
{
    if(texAccount.text.length == 0)
    {
        [[MIndicatorView sharedInstance] showWithTitle:@"账号不能为空" animated:NO];
        return;
    }
    
    if(texPassword.text.length == 0)
    {
        [[MIndicatorView sharedInstance] showWithTitle:@"密码不能为空" animated:NO];
        return;
    }
    
    if(![texPassword.text isEqualToString:texConformPassword.text])
    {
        [[MIndicatorView sharedInstance] showWithTitle:@"两次密码输入不一致" animated:NO];
        return;
    }
    
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
