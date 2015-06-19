//
//  BWPagingView.m
//  SimplePagingViewDemo
//
//  Created by bw ye on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BWPagingView.h"

@implementation BWPagingView

@synthesize dataSource = dataSource_;
@synthesize delegate = delegate_;
@synthesize isRotating = isRotating_;

#pragma mark - Private Methods

- (void)initialize
{
    pages_ = [[NSMutableArray alloc] init];
    reusablePages_ = [[NSMutableArray alloc] init];
    
    currentIndex_ = 0;
    needReload_ = YES;
    
    // Initilize the scroll view
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.bounds];
    [scrollView_ setDelegate:self];
    [scrollView_ setAlwaysBounceHorizontal:YES];
    [scrollView_ setShowsVerticalScrollIndicator:NO];
    [scrollView_ setShowsHorizontalScrollIndicator:NO];
    [scrollView_ setPagingEnabled:YES];
    [scrollView_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [scrollView_ setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:scrollView_];
}

- (void)queueReusablePage:(UIView *)aPage
{
    [reusablePages_ addObject:aPage];
}

- (void)layoutPageAtIndex:(NSInteger)aIndex
{
	NSParameterAssert(aIndex<[pages_ count]);
    
	UIView *page = [pages_ objectAtIndex:aIndex];
	if ((NSObject *)page == [NSNull null])
    {
		page = [dataSource_ pagingView:self pageAtIndex:aIndex];
		if (page == nil)
        {
			NSAssert(page!=nil, @"datasource must not return nil page");
			return;
		}
        
		[pages_ replaceObjectAtIndex:aIndex withObject:page];
	}
    
    // Caculate the offset of page
    CGFloat pageWidth = [dataSource_ widthForPageInPagingView:self];
	CGFloat x = aIndex * pageWidth;    
	[page setFrame:CGRectMake(x, 0.f, pageWidth, self.bounds.size.height)];
	if (page.superview == nil)
    {
        [scrollView_ addSubview:page];
	}
}

- (void)removePageAtIndex:(NSInteger)aIndex
{
	NSParameterAssert(aIndex<[pages_ count]);
    
    UIView *page = [pages_ objectAtIndex:aIndex];
    if ((NSObject *)page == [NSNull null])
    {
        return;
    }
    
    [self queueReusablePage:page];	
    
	if (page.superview != nil)
    {
		[page removeFromSuperview];
	}
    
    [pages_ replaceObjectAtIndex:aIndex withObject:[NSNull null]];
}

- (void)layoutAllPages
{
	NSInteger left = MAX(currentIndex_-1, 0);
	NSInteger right = MIN(currentIndex_+1, [pages_ count]-1);
    
    NSInteger previousLeft = MAX(left-1, 0);
    NSInteger previousRight = MIN(right+1, [pages_ count]-1);
    
    for (NSInteger index=previousLeft; index<=previousRight; index++)
    {
        if (index>=left && index<=right)
        {
            [self layoutPageAtIndex:index];   
        }
        else
        {
            [self removePageAtIndex:index];
        }
    }
}

-(NSInteger)getCurrentIndex
{
    return currentIndex_;
}

#pragma mark - Public Interface

- (UIView *)deqeueReusablePage
{
	UIView *reusablepage = [[reusablePages_ lastObject] retain];
    if (reusablepage != nil)
    {
        [reusablePages_ removeLastObject];
    }
    
    return [reusablepage autorelease];
}

- (void)reloadData
{
    needReload_ = YES;
    
    [self setNeedsLayout];
}


- (void)scrollToNext
{
    CGFloat offset=scrollView_.contentOffset.x;
    CGFloat width=scrollView_.frame.size.width;
    if(offset<([pages_ count]-1)*width)
    {
        offset+=width;
    }
    else
    {
        offset=0.f;
    }
    [scrollView_ setContentOffset:CGPointMake(offset, scrollView_.contentOffset.y) animated:YES];
}

- (void)scrollToPage:(NSUInteger)pageNumber {
    CGFloat offset=scrollView_.contentOffset.x;
    CGFloat width=scrollView_.frame.size.width;
    NSUInteger numberOfPages_ = [dataSource_ numberOfPagesInPagingView:self];
    if (pageNumber < numberOfPages_)
    {
        offset=width * pageNumber;
    }
    else
    {
        offset=0.f;
    }
    [scrollView_ setContentOffset:CGPointMake(offset, scrollView_.contentOffset.y) animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isRotating_)
    {
        return;
    }
    
    NSInteger index = lround(scrollView.contentOffset.x / scrollView.bounds.size.width);
    if (currentIndex_==index || index>=[pages_ count])
    {
        return;
    }

    if ([delegate_ respondsToSelector:@selector(pagingView:pageFromIndex:toIndex:)])
    {
        [delegate_ pagingView:self pageFromIndex:currentIndex_ toIndex:index];
    }
    
    currentIndex_ = index;
    
    [self layoutAllPages];
}

#pragma mark - system framework

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self initialize];
    }
    
    return self;
}

- (void)layoutSubviews
{
    if (needReload_)
    {
        numberOfPages_ = [dataSource_ numberOfPagesInPagingView:self];
        if (numberOfPages_ == 0)
        {
            return;
        }
        
        if (currentIndex_ >= numberOfPages_) {
            currentIndex_ = numberOfPages_-1;
        }
        
        for (UIView *page in pages_)
        {
            if ((NSObject *)page!=[NSNull null] && page.superview!=nil)
            {
                [page removeFromSuperview];
            }   
        }
        [pages_ removeAllObjects];
        [reusablePages_ removeAllObjects];
        for (NSInteger index=0; index<numberOfPages_; index++)
        {
            [pages_ addObject:[NSNull null]];
        }
        
        needReload_ = NO;
    }
    
    // Caculate the content size and content offset of the scroll view;
	CGFloat contentWidth = [dataSource_ numberOfPagesInPagingView:self] * [dataSource_ widthForPageInPagingView:self];
	CGFloat contentOffsetX = currentIndex_ * [dataSource_ widthForPageInPagingView:self];
    [scrollView_ setContentSize:CGSizeMake(contentWidth, self.bounds.size.height)];
	[scrollView_ setContentOffset:CGPointMake(contentOffsetX, 0.f)];
    
    // Layout all the pages
    [self layoutAllPages];
}

- (void)dealloc
{
    [scrollView_ release];
    [pages_ release];
    [reusablePages_ release];
    
    [super dealloc];
}

@end
