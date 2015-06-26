//
//  CLPhantasmCreate.m
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLPhantasmCreate.h"

@implementation CLPhantasmCreate

-(void)viewDidLoad
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分身"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(clickRightButton)];
    
}

-(void)clickRightButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)dealloc
{
    [super dealloc];
}
@end
