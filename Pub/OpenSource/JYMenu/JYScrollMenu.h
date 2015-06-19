//
//  JYScrollMenu.h
//  JYScrollMenu
//
//  Created by Jeerain
//

#import <UIKit/UIKit.h>
#import "JYIndicatorView.h"
#import "JYMenu.h"
#import "JYMenuButton.h"

#define kJYMenuButtonPaddingX 30
#define kJYMenuButtonStarX 0

@class JYScrollMenu;

@protocol JYScrollMenuDelegate <NSObject>

- (void)scrollMenuDidSelected:(JYScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex;
- (void)scrollMenuDidManagerSelected:(JYScrollMenu *)scrollMenu;

@end

@interface JYScrollMenu : UIView
{
    @private
    NSString *point_normal_;
    NSString *point_sel_;
}

@property (nonatomic, assign) id <JYScrollMenuDelegate> delegate;

// UI
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *indicatorView;

@property(nonatomic,copy) NSString *point_normal;
@property(nonatomic,copy) NSString *point_sel;

// DataSource
@property (nonatomic, strong) NSArray *menus;

// select
@property (nonatomic, assign) NSUInteger selectedIndex; // default is 0

- (void)setSelectedItem:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index;

- (UIView *)menuButtonAtIndex:(NSUInteger)index;

// reload dataSource
- (void)reloadData;

@end
