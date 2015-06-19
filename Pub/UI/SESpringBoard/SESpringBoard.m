//
//  SESpringBoard.m
//  SESpringBoardDemo
//
//  Created by Sarp Erdag on 11/5/11.
//  Copyright (c) 2011 Sarp Erdag. All rights reserved.
//

#import "SESpringBoard.h"

@implementation SESpringBoard

@synthesize items, title, launcher, isInEditingMode, itemCounts;

- (id) initWithTitle:(NSString *)boardTitle items:(NSMutableArray *)menuItems image:(UIImage *) image{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self setUserInteractionEnabled:YES];
    if (self) {
        self.launcher = image;
        self.isInEditingMode = NO;
        
        // create the top bar
        self.title = boardTitle;        
        
        // create a container view to put the menu items inside
        itemsContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(11, 5, 300, 400)];
        itemsContainer.delegate = self;
        [itemsContainer setScrollEnabled:YES];
        [itemsContainer setPagingEnabled:YES];
        itemsContainer.showsHorizontalScrollIndicator = NO;
        [self addSubview:itemsContainer];
        
        self.items = menuItems;
        int counter = 0;
        int horgap = 0;
        int vergap = 0;
        int numberOfPages = (ceil((float)[menuItems count] / 12));
        int currentPage = 0;
        for (SEMenuItem *item in self.items) {
            currentPage = counter / 12;
            item.tag = counter;
            //item.delegate = self;
            [item setFrame:CGRectMake(item.frame.origin.x + horgap + (currentPage*300), item.frame.origin.y + vergap, 62, 90)];
            [itemsContainer addSubview:item];
            horgap = horgap + 70+6;
            counter = counter + 1;
            if(counter % 4 == 0){
                vergap = vergap + 90+2;
                horgap = 0;
            }
            if (counter % 12 == 0) {
                vergap = 0;
            }
        }
        
        // record the item counts for each page
        self.itemCounts = [NSMutableArray array];
        int totalNumberOfItems = [self.items count];
        int numberOfFullPages = totalNumberOfItems % 12;
        int lastPageItemCount = totalNumberOfItems - numberOfFullPages%12;
        for (int i=0; i<numberOfFullPages; i++)
            [self.itemCounts addObject:[NSNumber numberWithInteger:12]];
        if (lastPageItemCount != 0)
            [self.itemCounts addObject:[NSNumber numberWithInteger:lastPageItemCount]];
        
        [itemsContainer setContentSize:CGSizeMake(numberOfPages*300, itemsContainer.frame.size.height)];
        [itemsContainer release];

        // add a page control representing the page the scrollview controls
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 433, 320, 20)];
        if (numberOfPages > 1) {
            pageControl.numberOfPages = numberOfPages;
            pageControl.currentPage = 0;
            [self addSubview:pageControl];
        }
        
        // add listener to detect close view events
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(closeViewEventHandler:)
         name:@"closeView"
         object:nil ];
    }
    return self;
}

+ (id) initWithTitle:(NSString *)boardTitle items:(NSMutableArray *)menuItems launcherImage:(UIImage *)image {
    SESpringBoard *tmpInstance = [[[SESpringBoard alloc] initWithTitle:boardTitle items:menuItems image:image] autorelease];
	return tmpInstance;
};

- (void)dealloc {
    [items release];
    [launcher release];
    [pageControl release];
    [itemCounts release];
    [super dealloc];
}

// transition animation function required for the springboard look & feel
- (CGAffineTransform)offscreenQuadrantTransformForView:(UIView *)theView {
    CGPoint parentMidpoint = CGPointMake(CGRectGetMidX(theView.superview.bounds), CGRectGetMidY(theView.superview.bounds));
    CGFloat xSign = (theView.center.x < parentMidpoint.x) ? -1.f : 1.f;
    CGFloat ySign = (theView.center.y < parentMidpoint.y) ? -1.f : 1.f;
    return CGAffineTransformMakeTranslation(xSign * parentMidpoint.x, ySign * parentMidpoint.y);
}


- (void)removeFromSpringboard:(int)index {
    
    // Remove the selected menu item from the springboard, it will have a animation while disappearing
    SEMenuItem *menuItem = [items objectAtIndex:index];
    [menuItem removeFromSuperview];
    
    int numberOfItemsInCurrentPage = [[self.itemCounts objectAtIndex:pageControl.currentPage] intValue];
    
    // First find the index of the current item with respect of the current page
    // so that only the items coming after the current item will be repositioned.
    // The index of the item can be found by looking at its coordinates
    int mult = ((int)menuItem.frame.origin.y) / 95;
    int add = ((int)menuItem.frame.origin.x % 300)/100;
    int pageSpecificIndex = (mult*3) + add;
    int remainingNumberOfItemsInPage = numberOfItemsInCurrentPage-pageSpecificIndex;    
    
    // Select the items listed after the deleted menu item
    // and move each of the ones on the current page, one step back.
    // The first item of each row becomes the last item of the previous row.
    for (int i = index+1; i<[items count]; i++) {
        SEMenuItem *item = [items objectAtIndex:i];   
        [UIView animateWithDuration:0.2 animations:^{
            
            // Only reposition the items in the current page, coming after the current item
            if (i < index + remainingNumberOfItemsInPage) {
                
                int intVal = item.frame.origin.x;
                // Check if it is the first item in the row
                if (intVal % 3 == 0)
                    [item setFrame:CGRectMake(item.frame.origin.x+200, item.frame.origin.y-95, item.frame.size.width, item.frame.size.height)];
                else 
                    [item setFrame:CGRectMake(item.frame.origin.x-100, item.frame.origin.y, item.frame.size.width, item.frame.size.height)];
            }            
            
            // Update the tag to match with the index. Since the an item is being removed from the array, 
            // all the items' tags coming after the current item has to be decreased by 1.
            [item updateTag:item.tag-1];
        }]; 
    }
    // remove the item from the array of items
    [items removeObjectAtIndex:index];
    // also decrease the record of the count of items on the current page and save it in the array holding the data
    numberOfItemsInCurrentPage--;
    [self.itemCounts replaceObjectAtIndex:pageControl.currentPage withObject:[NSNumber numberWithInteger:numberOfItemsInCurrentPage]];
}


#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = itemsContainer.frame.size.width;
    int page = floor((itemsContainer.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}


@end
