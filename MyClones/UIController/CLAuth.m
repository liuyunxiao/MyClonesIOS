//
//  CLAuth.m
//  MyClones
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLAuth.h"
#import "HttpMgr.h"
#import "Common.h"
#import "DataModel.h"

@interface CLAuth ()
{
    Task        *taskAuth_;
}

@end

@implementation CLAuth

- (void)viewDidLoad {
    [super viewDidLoad];
    texCardId.text = @"41701198605304857";
    texName.text = @"刘云";
    texSex.text = @"男";
    
}

-(IBAction)onClickSubmit:(id)sender
{
    if(taskAuth_)
        return;
    
    if(texCardId.text.length == 0||
       texName.text.length == 0 ||
       texSex.text.length == 0)
    {
        return;
    }

    ESexType sexType = EST_Null;
    if([texSex.text isEqualToString:@"男"])
    {
        sexType = EST_Male;
    }
    else if([texSex.text isEqualToString:@"女"])
    {
        sexType = EST_Female;
    }
    else
        return;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:texName.text forKey:@"name"];
    [dic setObject:texCardId.text forKey:@"cardId"];
    [dic setObject:[NSNumber numberWithInt:sexType] forKey:@"sex"];
    
    taskAuth_ = [[HttpMgr sharedInstance] send:@"SendAuth" data:dic observer:self selector:@selector(onRevAuth:context:) block:YES];
}

-(void)onRevAuth:(FBTaskResult *)aResult context:(id)aContext
{
    //CANCEL_AND_RELEASE_TASK(taskAuth_)
    taskAuth_ = nil;
    [[MIndicatorView sharedInstance] hide];
    RevBase *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode != EHRC_Success)
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
        return;
    }
    
    [[MIndicatorView sharedInstance] showWithTitle:@"提交成功" animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
