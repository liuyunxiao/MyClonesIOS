//
//  BWPagingView.h
//  SimplePagingViewDemo
//
//  Created by bw ye on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWPagingView;
@protocol BWPagingViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPagingView:(BWPagingView *)aPagingView;

- (CGFloat)widthForPageInPagingView:(BWPagingView *)aPagingView;

- (UIView *)pagingView:(BWPagingView *)aPagingView pageAtIndex:(NSInteger)aIndex;

@end


@protocol BWPagingViewDelegate <NSObject>
@optional
- (void)pagingView:(BWPagingView *)aPagingView pageFromIndex:(NSInteger)aPreviousIndex toIndex:(NSInteger)aCurrentIndex;

@end


@interface BWPagingView : UIView<UIScrollViewDelegate>
{
@private
    id<BWPagingViewDataSource> dataSource_;
    id<BWPagingViewDelegate> delegate_;
    
    UIScrollView *scrollView_;
    NSInteger currentIndex_;
    NSMutableArray *pages_;
    NSMutableArray *reusablePages_;
    
    BOOL needReload_;
    BOOL isRotating_;
    
    NSUInteger numberOfPages_;
}

@property(nonatomic, assign) IBOutlet id<BWPagingViewDataSource> dataSource; 
@property(nonatomic, assign) IBOutlet id<BWPagingViewDelegate> delegate; 

// Set isRotating to YES on willRotateToInterfaceOrientation, set it to NO on didRotateFromInterfaceOrientation
@property(nonatomic, assign) BOOL isRotating;

- (UIView *)deqeueReusablePage;
- (void)reloadData;
- (void)scrollToNext;
- (void)scrollToPage:(NSUInteger)pageNumber;
-(NSInteger)getCurrentIndex;
@end
