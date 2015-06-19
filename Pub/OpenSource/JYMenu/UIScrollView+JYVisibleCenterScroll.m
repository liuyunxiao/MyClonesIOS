//
//  UIScrollView+JYVisibleCenterScroll.m
//  JYScrollMenu
//
//  Created by Jeerain
//

#import "UIScrollView+JYVisibleCenterScroll.h"

@implementation UIScrollView (JYVisibleCenterScroll)

- (void)scrollRectToVisibleCenteredOn:(CGRect)visibleRect
                             animated:(BOOL)animated {
    CGRect centeredRect = CGRectMake(visibleRect.origin.x + visibleRect.size.width/2.0 - self.frame.size.width/2.0,
                                     visibleRect.origin.y + visibleRect.size.height/2.0 - self.frame.size.height/2.0,
                                     self.frame.size.width,
                                     self.frame.size.height);
    [self scrollRectToVisible:centeredRect
                     animated:animated];
}

@end
