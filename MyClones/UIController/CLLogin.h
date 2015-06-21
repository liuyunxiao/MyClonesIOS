//
//  CLLogin.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CLLogin : BaseViewController
{
    IBOutlet    UITextField         *texAccountName;
    IBOutlet    UITextField         *texPassword;
}


-(IBAction)onClickLogin:(id)sender;
-(IBAction)onClickRegister:(id)sender;
@end
