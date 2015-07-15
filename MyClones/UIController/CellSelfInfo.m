//
//  CellSelfInfo.m
//  MyClones
//
//  Created by lyx on 15/7/8.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CellSelfInfo.h"

@implementation CellSelfInfo

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [_labDes release];
    [_labNext release];
    [_labTitle release];
    [super dealloc];
}

@end
