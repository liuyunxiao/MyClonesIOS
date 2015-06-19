//
//  MCustomBarButtonItem.m
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MBarButtonItem.h"


@implementation MBarButtonItem

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)aTitle
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundColor:[UIColor clearColor]];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonImage = [aNormalImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    UIImage *buttonPressedImage = [aHighlightedImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //[button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.7] forState:UIControlStateNormal];
    //[button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    //[[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [aTitle sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 24.0;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    [button.titleLabel setShadowColor:[UIColor colorWithRed:0x00 green:0x00 blue:0x00 alpha:0.75]];
    [button.titleLabel setShadowOffset:CGSizeMake(0.f, -1.f)];
    
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [buttonItem autorelease];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonImage = [aNormalImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    UIImage *buttonPressedImage = [aHighlightedImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [button setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
	[button setImage:aImage forState:UIControlStateNormal];
	
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [buttonItem autorelease];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    [button setFrame:CGRectMake(0, 0, aImage.size.width, aImage.size.height)];
    
    [button setImage:aImage forState:UIControlStateNormal];
    [button setImage:aHighlightedImage forState:UIControlStateHighlighted];
	
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [buttonItem autorelease];
}


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction
                                      width:(CGFloat)w
                                     height:(CGFloat)h
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    [button setFrame:CGRectMake(0, 0, w, h)];
    
    [button setImage:aImage forState:UIControlStateNormal];
    [button setImage:aHighlightedImage forState:UIControlStateHighlighted];
	
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [buttonItem autorelease];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)aTitle
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction 
                                      width:(CGFloat)w
                                     height:(CGFloat)h{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundColor:[UIColor clearColor]];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonImage = [aNormalImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    UIImage *buttonPressedImage = [aHighlightedImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //[button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.7] forState:UIControlStateNormal];
    //[button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    //[[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = w;
    buttonFrame.size.height = h;
    [button setFrame:buttonFrame];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    //[button.titleLabel setShadowColor:[UIColor colorWithRed:0x00 green:0x00 blue:0x00 alpha:0.75]];
    //[button.titleLabel setShadowOffset:CGSizeMake(0.f, -1.f)];
    
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [buttonItem autorelease];
}

@end
