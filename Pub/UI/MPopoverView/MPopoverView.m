//
//  MPopoverView.m
//  OpenCourse
//
//  Created by bw ye on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MPopoverView.h"

@implementation MPopoverView

@synthesize tapToDismiss = tapToDismiss_;

- (void)buttonPressed
{
    if (!tapToDismiss_)
    {
        return;
    }
    
    [self dismissWithAnimated:YES];
}

- (void)dismissWithAnimated:(BOOL)aAnimated
{
    if (!aAnimated)
    {
        [self removeFromSuperview];
    }
    else
    {
        if (isFading_)
        {
            return;
        }
        
        isFading_ = YES;
        
        [UIView animateWithDuration:0.3f animations:^{
            [self setAlpha:0.f];
        } completion:^(BOOL finished) {
            isFading_ = NO;
            [self removeFromSuperview];
        }];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

        maskButton_ = [[UIButton alloc] initWithFrame:CGRectZero];
        [maskButton_ addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [maskButton_ setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f]];
        [maskButton_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self insertSubview:maskButton_ atIndex:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        maskButton_ = [[UIButton alloc] initWithFrame:CGRectZero];
        
        [maskButton_ addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [maskButton_ setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f]];
        [maskButton_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self insertSubview:maskButton_ atIndex:0];
    }
    return self; 
}

- (void)setAlpha:(CGFloat)alpha
{
  if(maskButton_!=nil)
  {
//      [maskButton_ setBackgroundColor:[UIColor blackColor]];
      [maskButton_ setAlpha:alpha];
  }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [maskButton_ setFrame:self.bounds];
}

- (void)dealloc
{
    [maskButton_ removeFromSuperview];
    [maskButton_ release];
    
    [super dealloc];
}

@end
