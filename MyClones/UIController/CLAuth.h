//
//  CLAuth.h
//  MyClones
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAuth : UIViewController
{
    IBOutlet UITextField        *texName;
    IBOutlet UITextField        *texCardId;
    IBOutlet UITextField        *texSex;
}

-(IBAction)onClickSubmit:(id)sender;
@end
