//
//  CLDynamic.m
//  MyClones
//
//  Created by lyx on 15/6/26.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLDynamic.h"
#import "UserMgr.h"

@interface CLDynamic ()

@end

@implementation CLDynamic

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.parentViewController.navigationController]
    if(![[UserMgr sharedInstance] login])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                                 bundle: nil];
        UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavLogin"];
        
        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:vc animated:NO completion:^(void){
            
        }];
    }
    
}
@end
