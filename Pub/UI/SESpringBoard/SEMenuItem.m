//
//  SEMenuItem.m
//  SESpringBoardDemo
//
//  Created by Sarp Erdag on 11/5/11.
//  Copyright (c) 2011 Sarp Erdag. All rights reserved.
//

#import "SEMenuItem.h"
#import "SESpringBoard.h"
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>

@implementation SEMenuItem

@synthesize tag, delegate, isRemovable, isInEditingMode;
@synthesize type=type_;

#pragma mark - UI actions

- (void) clickItem{
    [delegate CellClickEvent:self];
}

- (void) pressedLong:(id) sender {
    //[self enableEditing];
}

#pragma mark - Custom Methods

- (void) enableEditing {

    if (self.isInEditingMode == YES)
        return;
    
    // put item in editing mode
    self.isInEditingMode = YES;
    
    // make the remove button visible
    [removeButton setHidden:NO];
    
    // start the wiggling animation
    CATransform3D transform;
    
    if (arc4random() % 2 == 1)
        transform = CATransform3DMakeRotation(-0.08, 0, 0, 1.0);  
    else
        transform = CATransform3DMakeRotation(0.08, 0, 0, 1.0);  
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];  
    animation.toValue = [NSValue valueWithCATransform3D:transform];  
    animation.autoreverses = YES;   
    animation.duration = 0.1;   
    animation.repeatCount = 10000;   
    animation.delegate = self;  
    [[self layer] addAnimation:animation forKey:@"wiggleAnimation"];
    
}

- (void) disableEditing {
    [[self layer] removeAllAnimations];
    [removeButton setHidden:YES];
    self.isInEditingMode = NO;
}

- (void) updateTag:(int) newTag {
    //self.tag = newTag;
    //removeButton.tag = newTag;
}

#pragma mark - Initialization

- (id) initWithTitle:(NSString *)title :(NSString *)imageName :(NSString*)highImageName :(NSInteger)type :(BOOL)removable {
    self = [super initWithFrame:CGRectMake(0, 0, 70, 90)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        type_ = type;
        image = imageName;
        highImage=highImageName;
        titleText = title;
        self.isInEditingMode = NO;
        self.isRemovable = removable;
    }
    return self;
}

+ (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName highImageName:(NSString*)highImageName type:(NSInteger)type removable:(BOOL)removable  {
	SEMenuItem *tmpInstance = [[[SEMenuItem alloc] initWithTitle:title :imageName :highImageName :type :removable] autorelease];
	return tmpInstance;
}

# pragma mark - Overriding UiView Methods

- (void) removeFromSuperview {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
        [self setFrame:CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0)];
        [removeButton setFrame:CGRectMake(0, 0, 0, 0)];
    }completion:^(BOOL finished) {
        //[super removeFromSuperview];
    }]; 
}

# pragma mark - Drawing

- (void) drawRect:(CGRect)rect {
       
    UIButton *imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgButton setFrame:CGRectMake(5.0, 5.0, 58, 58)];
    imgButton.backgroundColor = [UIColor clearColor];
    [imgButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [imgButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [imgButton addTarget:self action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    imgButton.tag = tag;
    [self addSubview:imgButton];
    
    
//    // draw the menu item title shadow
//    NSString* shadowText = titleText;
//    [[UIColor blackColor] set];
//    //UIFont *bold14 = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//	[shadowText drawInRect:CGRectMake(0.0, 72.0, 100, 20.0) withFont:[UIFont systemFontOfSize:14.0f] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
    
    // draw the menu item title
    NSString* text = titleText;
    [[UIColor blackColor] set];
	[text drawInRect:CGRectMake(0.0, 62.0, 70, 18.0) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
}


@end
