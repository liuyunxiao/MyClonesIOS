//
//  CLHome.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "BaseViewController.h"
#import "Common.h"

@interface CLHome : UITabBarController<UITabBarControllerDelegate>
{
    IBOutlet    UIView      *viewBottomMenu;
    
    EUIBottomType           curSelBottomMenu;
    
    NSMutableArray          *viewPages;
    
    BOOL                    bLogin;
}

-(void)onClickBottomMenum:(id)sender;
-(IBAction)onClickText:(id)sender;
@end
