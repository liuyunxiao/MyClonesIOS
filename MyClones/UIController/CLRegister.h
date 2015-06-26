//
//  CLRegister.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "BaseViewController.h"

@interface CLRegister : UIViewController
{
    IBOutlet    UITextField         *texAccount;
    IBOutlet    UITextField         *texPassword;
    IBOutlet    UITextField         *texConformPassword;
    IBOutlet    UITextField         *texPhoneCode;
    IBOutlet    UITextField         *texPhone;
}

-(IBAction)onClickSummit:(id)sender;
-(IBAction)onClickRequireCode:(id)sender;

@end
