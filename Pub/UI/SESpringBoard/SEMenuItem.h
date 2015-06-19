//
//  SEMenuItem.h
//  SESpringBoardDemo
//
//  Created by Sarp Erdag on 11/5/11.
//  Copyright (c) 2011 Sarp Erdag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemDelegate;
@interface SEMenuItem : UIView {
    NSInteger type_;
    NSString *image;
    NSString *highImage;
    NSString *titleText;
    id <MenuItemDelegate> delegate;
    UIButton *removeButton;
}

@property (nonatomic, assign) int tag;
@property (nonatomic, assign) NSInteger type;
@property BOOL isRemovable;
@property BOOL isInEditingMode;
@property (nonatomic, assign) id <MenuItemDelegate> delegate;

+ (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName highImageName:(NSString*)highImageName type:(NSInteger)type removable:(BOOL)removable;

- (void) enableEditing;
- (void) disableEditing;
- (void) updateTag:(int) newTag;
- (void)clickItem;

@end

@protocol MenuItemDelegate
@optional
- (void)CellClickEvent:(id)del;
@end