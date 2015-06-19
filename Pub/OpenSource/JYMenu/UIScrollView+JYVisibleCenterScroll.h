//
//  UIScrollView+JYVisibleCenterScroll.h
//  JYScrollMenu
//
//  Created by Jeerain
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JYVisibleCenterScroll)

- (void)scrollRectToVisibleCenteredOn:(CGRect)visibleRect
                             animated:(BOOL)animated;

@end
