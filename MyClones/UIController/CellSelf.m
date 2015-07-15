//
//  CellSelf.m
//  MyClones
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CellSelf.h"

@implementation CellSelf

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
    [_labTitle release];
    [_imgIcon release];
    [super dealloc];
}

@end
