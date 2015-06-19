//
//  BottomMenuPhantasm.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "BottomMenuPhantasm.h"
#import "SlideNavigationController+Utils.h"

@implementation BottomMenuPhantasm


-(void)onClickEShoppingReviewer:(id)sender
{
    if(![SlideNavigationController pushViewController:@"CLEShoppingReviewerHome" animated:YES])
    {
        
    }
}

-(void)onClickEShoppingSearcher:(id)sender
{
    if(![SlideNavigationController pushViewController:@"CLEShoppingSearcherHome" animated:YES])
    {
        
    }
}

-(void)onClickAdd:(id)sender
{
    if(![SlideNavigationController pushViewController:@"CLCreatePhantasm" animated:YES])
    {
        
    }
}
@end
