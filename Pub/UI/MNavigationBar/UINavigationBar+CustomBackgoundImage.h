//
//  UINavigationBar+CustomBackgoundImage.h
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMNavigationBarBackgroundImageViewTag 20110705

@interface UINavigationBar (CustomBackgroundImage)

- (void)mInsertSubview:(UIView *)aView atIndex:(NSInteger)aIndex;
- (void)mSendSubviewToBack:(UIView *)aView;

@end
