//
//  UINavigationBar+CustomBackgoundImage.m
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+CustomBackgoundImage.h"

@implementation UINavigationBar (CustomBackgroundImage)

- (void)mInsertSubview:(UIView *)aView atIndex:(NSInteger)aIndex {
    [self mInsertSubview:aView atIndex:aIndex];
    
    UIImageView *bgImageView = (UIImageView *)[self viewWithTag:kMNavigationBarBackgroundImageViewTag];
    if (bgImageView != nil) {
        [self mSendSubviewToBack:bgImageView];
    }
}

- (void)mSendSubviewToBack:(UIView *)aView {
    [self mSendSubviewToBack:aView];
        
    UIImageView *bgImageView = (UIImageView *)[self viewWithTag:kMNavigationBarBackgroundImageViewTag];
    if (bgImageView != nil) {
        [self mSendSubviewToBack:bgImageView];
    }
}

@end
