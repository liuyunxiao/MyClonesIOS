//
//  JYScrollMenu.m
//  JYScrollMenu
//
//  Created by Jeerain
//

#import "JYScrollMenu.h"

#import "UIScrollView+JYVisibleCenterScroll.h"

#define kJYMenuButtonBaseTag 100

@interface JYScrollMenu () <UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) NSMutableArray *menuViews;

@end

@implementation JYScrollMenu
@synthesize point_normal=point_normal_;
@synthesize point_sel=point_sel_;

#pragma mark - Propertys

- (NSMutableArray *)menuViews {
    if (!_menuViews) {
        _menuViews = [[NSMutableArray alloc] initWithCapacity:self.menus.count];
    }
    return _menuViews;
}

#pragma mark - Action
-(void)setMenuSelected:(UIButton *)sender
{
    [self.menuViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JYMenu *menu=[self.menus objectAtIndex:idx];
        UIButton *button=[[obj subviews] objectAtIndex:0];
        if (button == sender) {
            sender.selected = YES;
            sender.titleLabel.font=menu.titleSelectedFont;
        } else {
            UIButton *menuButton = button;
            menuButton.selected = NO;
            menuButton.titleLabel.font=menu.titleFont;
        }
    }];
}
- (void)menuButtonSelected:(UIButton *)sender {
    [self setMenuSelected:sender];
    [self setSelectedIndex:sender.tag - kJYMenuButtonBaseTag animated:YES calledDelegate:YES];
}

#pragma mark - Life cycle

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _selectedIndex = 0;
    

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    [self addSubview:self.scrollView];
}

- (void)setupIndicatorFrame:(CGRect)menuButtonFrame animated:(BOOL)animated callDelegate:(BOOL)called {
    [UIView animateWithDuration:(animated ? 0.15 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [_scrollView bringSubviewToFront:self.indicatorView];
        _indicatorView.frame = CGRectMake(CGRectGetMinX(menuButtonFrame)+30, 33, 7, 7);
    } completion:^(BOOL finished) {
        if (called) {
            if ([self.delegate respondsToSelector:@selector(scrollMenuDidSelected:menuIndex:)]) {
                [self.delegate scrollMenuDidSelected:self menuIndex:self.selectedIndex];
            }
        }
    }];
}

- (UIButton *)getButtonWithMenu:(JYMenu *)menu {
//    CGSize buttonSize = [menu.title sizeWithFont:menu.titleFont constrainedToSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.bounds) - 10) lineBreakMode:NSLineBreakByCharWrapping];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64.f, 60)];
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    button.titleLabel.font = menu.titleFont;
    [button setTitle:menu.title forState:UIControlStateNormal];
    [button setTitle:menu.title forState:UIControlStateHighlighted];
    [button setTitle:menu.title forState:UIControlStateSelected];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-18, -40, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,16, 25, 0)];
    
    
    [button setImage:[UIImage imageNamed:menu.normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:menu.selectedImage] forState:UIControlStateSelected];
    
    //normal color
    [button setTitleColor:menu.titleNormalColor forState:UIControlStateNormal];
    
    //high color
    if (!menu.titleHighlightedColor) {
        menu.titleHighlightedColor = menu.titleNormalColor;
    }
    [button setTitleColor:menu.titleHighlightedColor forState:UIControlStateHighlighted];
    
    //selected color
    if (!menu.titleSelectedColor) {
        menu.titleSelectedColor = menu.titleNormalColor;
    }
    [button setTitleColor:menu.titleSelectedColor forState:UIControlStateSelected];
    
    
    [button addTarget:self action:@selector(menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#pragma mark - Public

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index {
    CGRect rect = ((UIView *)self.menuViews[index]).frame;
    return rect;
}

- (UIView *)menuButtonAtIndex:(NSUInteger)index {
    return self.menuViews[index];
}

- (void)setSelectedItem:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate
{
    if(_selectedIndex==selectedIndex)
        return;
    _selectedIndex = selectedIndex;
    [self setSelectedIndex:selectedIndex animated:aniamted calledDelegate:calledDelgate];
    UIView *selectedMenuView=[self menuButtonAtIndex:selectedIndex];
    UIButton *selectedMenuButton = [[selectedMenuView subviews] objectAtIndex:0];
    [self setMenuSelected:selectedMenuButton];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate {
    _selectedIndex = selectedIndex;
    UIView *selectedMenuView=[self menuButtonAtIndex:selectedIndex];
    //UIButton *selectedMenuButton = [[selectedMenuView subviews] objectAtIndex:0];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        NSInteger centerIndex= 0;
        CGFloat width= selectedMenuView.frame.size.width;
        CGFloat offset=width*(int)ABS(centerIndex-_selectedIndex);
        
        [self.scrollView setContentOffset:CGPointMake(-offset, self.scrollView.frame.origin.y) animated:YES];
        
//        [self.scrollView scrollRectToVisibleCenteredOn:selectedMenuButton.frame animated:NO];
    } completion:^(BOOL finished) {
        [self setupIndicatorFrame:selectedMenuView.frame animated:aniamted callDelegate:calledDelgate];
    }];
}

- (void)reloadData {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [((UIView *)obj) removeFromSuperview];
        }
    }];
    if (self.menuViews.count)
        [self.menuViews removeAllObjects];
    
    // layout subViews
    CGFloat contentWidth = 64*2;
    for (JYMenu *menu in self.menus) {
        NSUInteger index = [self.menus indexOfObject:menu];
        UIButton *menuButton = [self getButtonWithMenu:menu];
        menuButton.tag = kJYMenuButtonBaseTag + index;
        CGRect menuButtonFrame = menuButton.frame;
        CGFloat buttonX = 0;
        
        if (index) {
            buttonX = CGRectGetMaxX(((UIView *)(self.menuViews[index - 1])).frame);
        } else {
            buttonX = 64*2;
        }
        
        UIView *menuView=[[UIView alloc] init];
        
        menuButtonFrame.origin = CGPointMake(buttonX, menuButtonFrame.origin.y);
        menuView.frame = menuButtonFrame;
        [menuView addSubview:menuButton];
        
        UIImageView *pointImgView=[[UIImageView alloc] init];
        pointImgView.frame=CGRectMake(30, 33, 7, 7);
        [pointImgView setImage:[UIImage imageNamed:point_normal_]];
        [menuView addSubview:pointImgView];
        
        [self.scrollView addSubview:menuView];
        [self.menuViews addObject:menuView];
        
        // scrollView content size width
        if (index == self.menus.count - 1) {
            contentWidth += CGRectGetMaxX(menuButtonFrame);
        }
        
        if (self.selectedIndex == index) {
            menuButton.selected = YES;
            menuButton.titleLabel.font=menu.titleSelectedFont;
            // indicator
            _indicatorView = [[UIImageView alloc] init];
            _indicatorView.frame=CGRectMake(0, 33, 7, 7);
            [_indicatorView setImage:[UIImage imageNamed:point_sel_]];
            [_scrollView addSubview:self.indicatorView];
            [_scrollView bringSubviewToFront:self.indicatorView];
            [self setupIndicatorFrame:menuButtonFrame animated:NO callDelegate:NO];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(contentWidth, CGRectGetHeight(self.scrollView.frame))];
    self.scrollView.decelerationRate=0.1f;
    [self setSelectedIndex:self.selectedIndex animated:NO calledDelegate:YES];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat contentSizeWidth = (NSInteger)scrollView.contentSize.width;
    CGFloat scrollViewWidth = CGRectGetWidth(scrollView.bounds);
     NSLog(@"***********:%0.2f",contentOffsetX);
}


-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate)
    {
        NSInteger pageIndex = floor(scrollView.contentOffset.x / 64);
        [self setSelectedItem:pageIndex animated:NO calledDelegate:YES];
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageIndex = floor(scrollView.contentOffset.x / 64);
    [self setSelectedItem:pageIndex animated:NO calledDelegate:YES];
}

@end
