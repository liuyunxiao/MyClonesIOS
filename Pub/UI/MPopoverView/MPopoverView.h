//
//  MPopoverView.h
//  OpenCourse
//
//  Created by bw ye on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPopoverView : UIView
{
    UIButton *maskButton_;
    BOOL isFading_;
    
    BOOL tapToDismiss_;
}

@property(nonatomic, assign) BOOL tapToDismiss;

- (void)dismissWithAnimated:(BOOL)aAnimated;
- (void)setAlpha:(CGFloat)alpha;

@end
