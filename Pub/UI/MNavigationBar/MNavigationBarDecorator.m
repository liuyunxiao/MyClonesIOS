//
//  MNavigationBar.m
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MNavigationBarDecorator.h"
#import "UINavigationBar+CustomBackgoundImage.h"
#import <objc/runtime.h>

@implementation MNavigationBarDecorator

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)new;
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
    {
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, newMethod);
        
    }
}

- (id)init {
    self = [super init];
    
    if (self != nil) {
        [MNavigationBarDecorator swizzleSelector:@selector(insertSubview:atIndex:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(mInsertSubview:atIndex:)];
        [MNavigationBarDecorator swizzleSelector:@selector(sendSubviewToBack:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(mSendSubviewToBack:)];
    }
    
    return self;
}

- (void)decorateNavigationController:(UINavigationController *)aNC withBackgourndImage:(UIImage *)aImage {
    UINavigationBar *navBar = [aNC navigationBar];
    UIImageView *bgImageView = (UIImageView *)[navBar viewWithTag:kMNavigationBarBackgroundImageViewTag];
	
	[navBar setClipsToBounds:NO];
	[bgImageView setClipsToBounds:NO];
	
    if (bgImageView == nil) {
		bgImageView = [[UIImageView alloc] initWithImage:aImage];
		
		[bgImageView setTag:kMNavigationBarBackgroundImageViewTag];
		
		float version = [[[UIDevice currentDevice] systemVersion] floatValue];
		if (version >= 5.0) {
			//在sdk4.x中，使用该方法屏蔽ios5下的backgroundImage
			//在ios 5.x中，可以直接使用[navBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
            // [[navBar.subviews objectAtIndex:0] removeFromSuperview]; // 这样会卡，按扭会跳
            [[navBar.subviews objectAtIndex:0] setAlpha:0.f];
            //[navBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
        }
        [navBar insertSubview:bgImageView atIndex:0];
		[bgImageView release];
    }
    else {
        [bgImageView setImage:aImage];
    }
}



@end
