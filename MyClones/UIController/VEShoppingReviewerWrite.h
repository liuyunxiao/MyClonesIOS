//
//  VEShoppingReviewerWrite.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VEShoppingReviewerWrite : UIView
{
    IBOutlet    UITextField     *texURL;
    IBOutlet    UITextField     *texDes;
}

-(void)onClickSubmit:(id)sender;
@end
