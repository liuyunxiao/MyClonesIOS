//
//  JYIndicatorView.m
//  JYScrollMenu
//
//  Created by Jeerain
//

#import "JYIndicatorView.h"

@implementation JYIndicatorView

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    CGRect indicatorRect = self.frame;
    indicatorRect.size.width = _indicatorWidth;
    self.frame = indicatorRect;
}

+ (instancetype)initIndicatorView {
    JYIndicatorView *indicatorView = [[JYIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, kJYIndicatorViewHeight)];
    return indicatorView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.752 green:0.026 blue:0.034 alpha:1.000];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
