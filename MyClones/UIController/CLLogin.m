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

@interface CLLogin ()
{
    Task *taskLogin_;
}

@end

@implementation CLLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)onRevLogin:(FBTaskResult *)aResult context:(id)aContext
{
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
    {
        taskLogin_ = nil;
        return;
    }
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
    taskLogin_ = nil;
    //CANCEL_AND_RELEASE_TASK(taskLogin_);
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
}

-(void)dealloc
{
    CANCEL_AND_RELEASE_TASK(taskLogin_);
    [texPassword release];
    [texAccountName release];
    
    [super dealloc];
}
@end
