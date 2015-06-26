    //
//  MIndicatorView.m
//  MIndicatorDemo
//
//  Created by ios on 11-10-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MIndicatorView.h"
#import <QuartzCore/QuartzCore.h>
#import "DataEngine.h"
#define RADIANS(degrees) ((degrees * (float)M_PI) / 180.0f)
 
MIndicatorView *gIndicatorView=nil;

@implementation MIndicatorView
@synthesize customView=customView_;

///
///旋转过程中重绘View中的浮层位置
///
-(void)layoutSubviews{
    if (indicator.frame.size.height>0) {
        // Add a indicator view 
		if ([labelTitle.text length] == 0) {
			CGFloat indicatorViewWidth = 60.0;
			CGFloat indicatorViewHeight = 60.0;
			CGFloat indicatorViewX = (gIndicatorView.bounds.size.width-indicatorViewWidth)/2;
			CGFloat indicatorViewY = (gIndicatorView.bounds.size.height-indicatorViewHeight)/2;
			[indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
			
			CGFloat activityIndicatorWidth = 20.0f;
			CGFloat activityIndicatorHeight = 20.0f;
			CGFloat activityIndicatorX = (gIndicatorView.bounds.size.width-activityIndicatorWidth)/2;
			CGFloat activityIndicatorY = (gIndicatorView.bounds.size.height-activityIndicatorHeight)/2;
			
			[indicator setFrame:CGRectMake(activityIndicatorX, activityIndicatorY, activityIndicatorWidth, activityIndicatorHeight)];
			[indicator startAnimating];
		}
		else {
			CGFloat indicatorViewWidth = 80.0;
			CGFloat indicatorViewHeight = 80.0;
			CGFloat indicatorViewX = (gIndicatorView.bounds.size.width-indicatorViewWidth)/2;
			CGFloat indicatorViewY = (gIndicatorView.bounds.size.height-indicatorViewHeight)/2;
			[indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
			
			CGFloat labelWidth = 80.0f;
			CGFloat labelHeight = 30.0f;
			CGFloat activityIndicatorWidth = 20.0f;
			CGFloat activityIndicatorHeight = 20.0f;
			
			CGFloat labelX = (gIndicatorView.bounds.size.width-labelWidth)/2;
			CGFloat labelY = (gIndicatorView.bounds.size.height+activityIndicatorHeight-labelHeight)/2;
			CGFloat activityIndicatorX = (gIndicatorView.bounds.size.width-activityIndicatorWidth)/2;
			CGFloat activityIndicatorY = (gIndicatorView.bounds.size.height-activityIndicatorHeight-labelHeight)/2;
			
			[labelTitle setFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
			
			[indicator setFrame:CGRectMake(activityIndicatorX, activityIndicatorY, activityIndicatorWidth, activityIndicatorHeight)];
		}		
		
    }
    else {
        CGSize constraintSize = CGSizeMake(200.0f, MAXFLOAT);
        CGSize size = [[labelTitle text] sizeWithFont:[labelTitle font]
									constrainedToSize:constraintSize
										lineBreakMode:UILineBreakModeWordWrap];
        CGFloat labelWidth = size.width;
        CGFloat labelHeight = size.height;
        CGFloat labelX = (self.bounds.size.width-labelWidth)/2;
        CGFloat labelY = (self.bounds.size.height-labelHeight)/2;
        [labelTitle setFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        
        CGFloat indicatorViewWidth = labelWidth + 20.0f;
        CGFloat indicatorViewHeight = labelHeight + 20.0f;
        CGFloat indicatorViewX = (self.bounds.size.width-indicatorViewWidth)/2;
        CGFloat indicatorViewY = (self.bounds.size.height-indicatorViewHeight)/2;
        [indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
        
    }
    
    [customView_ setAlpha:1];
    
}
///
///根据当前的方向调整View的方向，旋转View
///
- (void)setTransformForCurrentOrientation:(BOOL)animated {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	NSInteger degrees = 0;
	// Stay in sync with the superview
	if (self.superview) {
		self.bounds = self.superview.bounds;
		[self setNeedsDisplay];
	}
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		if (orientation == UIInterfaceOrientationLandscapeLeft) {
		   degrees = -90; 
			} 
		else { 
			degrees = 90; 
		}
		// Window coordinates differ!
		self.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
			} else {
		if (orientation == UIInterfaceOrientationPortraitUpsideDown) { 
			degrees = 180; 
		} 
		else { 
			degrees = 0;
		}
		
	}
	rotationTransform = CGAffineTransformMakeRotation(RADIANS(degrees));
	
	if (animated) {
		[UIView beginAnimations:nil context:nil];
	}
	[self setTransform:rotationTransform];
	if (animated) {
		[UIView commitAnimations];
	}
}
///
///监听设备的位置
///
- (void)deviceOrientationDidChange:(NSNotification *)notification { 
	if (!self.superview) {
		return;
	}
	if ([self.superview isKindOfClass:[UIWindow class]]) {
		[self setTransformForCurrentOrientation:YES];
	}
}
#pragma mark -
#pragma mark init 

- (id)initWithView:(UIView *)view
{
	if (!view) {
		[NSException raise:@"MBProgressHUDViewIsNillException" 
					format:@"The view used in the MBProgressHUD initializer is nil."];
	}
	
	id me = [self initWithFrame:view.bounds];
	
	// We need to take care of rotation ourselfs if we're adding the HUD to a window
	if ([view isKindOfClass:[UIWindow class]]) {
		[self setTransformForCurrentOrientation:NO];
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) 
												 name:UIDeviceOrientationDidChangeNotification object:nil];
	
	return me;

}
-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self != nil) {
        customView_ = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [customView_ setAlpha:0.f];
		[self addSubview:customView_];
		
        // Add a indicator view
        indicatorView_ = [[UIView alloc] initWithFrame:CGRectZero];
        [indicatorView_ setBackgroundColor:[UIColor blackColor]];
        [indicatorView_ setAlpha:0.55f];
        [indicatorView_.layer setCornerRadius:5];
        [indicatorView_.layer setMasksToBounds:YES];
	
		
        // Add title view
        labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [labelTitle setTextAlignment:UITextAlignmentCenter];
        [labelTitle setTextColor:[UIColor whiteColor]];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setFont:[UIFont systemFontOfSize:13]];
        [labelTitle setNumberOfLines:0];
        [labelTitle setLineBreakMode:UILineBreakModeWordWrap];
        
        // Add activity indicator
        indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [indicator setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];
        
        [customView_ addSubview:indicatorView_];
        [customView_ addSubview:labelTitle];
        [customView_ addSubview:indicator];
		rotationTransform = CGAffineTransformIdentity;
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | 
		                   UIViewAutoresizingFlexibleBottomMargin | 
							 UIViewAutoresizingFlexibleLeftMargin | 
		                     UIViewAutoresizingFlexibleRightMargin;

    }
    
    return self;

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/*- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}*/

/*- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
*/

- (void)dealloc {
	self.customView=nil;
	[indicatorView_ release];
	[indicator release];
	[labelTitle release];
    [super dealloc];
}

#pragma mark -
#pragma mark the outside interface
+ (id)sharedInstance{
	if (gIndicatorView == nil) {
//        UIView *view = nil;
//        if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)])
//        {
//            view = [[[UIApplication sharedApplication] delegate] performSelector:@selector(window)];
//        }
        UIView *view = [[UIApplication sharedApplication] keyWindow];
        if (view == nil)
        {
            return nil;
        }
        
		gIndicatorView = [[MIndicatorView alloc] initWithView:view];
	}
	
    return gIndicatorView; 
}

- (void)setTitle:(NSString *)aTitle {
    [labelTitle setText:aTitle];
}

- (void)showWithTitle:(NSString *)aTitle animated:(BOOL)aAnimated {    
	UIView *view = nil;
    if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)])
    {
        view = [[[UIApplication sharedApplication] delegate] performSelector:@selector(window)];
    }
    if (view == nil)
    {
        return;
    }
    
	[self setTransformForCurrentOrientation:NO];
    [self setFrame:view.bounds];     //第二次调用时，frame被销毁了，所以每次进来都重新设定
	[labelTitle setText:aTitle];
	if (aAnimated) {
        // Add a indicator view 
		if ([aTitle length] == 0) {
			CGFloat indicatorViewWidth = 60.0;
			CGFloat indicatorViewHeight = 60.0;
			CGFloat indicatorViewX = (gIndicatorView.bounds.size.width-indicatorViewWidth)/2;
			CGFloat indicatorViewY = (gIndicatorView.bounds.size.height-indicatorViewHeight)/2;
			[indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
			
			CGFloat activityIndicatorWidth = 20.0f;
			CGFloat activityIndicatorHeight = 20.0f;
			CGFloat activityIndicatorX = (gIndicatorView.bounds.size.width-activityIndicatorWidth)/2;
			CGFloat activityIndicatorY = (gIndicatorView.bounds.size.height-activityIndicatorHeight)/2;
			
			[indicator setFrame:CGRectMake(activityIndicatorX, activityIndicatorY, activityIndicatorWidth, activityIndicatorHeight)];
			[indicator startAnimating];
		}
		else {
			CGFloat indicatorViewWidth = 80.f;
			CGFloat indicatorViewHeight = 80.f;
			CGFloat indicatorViewX = (gIndicatorView.bounds.size.width-indicatorViewWidth)/2;
			CGFloat indicatorViewY = (gIndicatorView.bounds.size.height-indicatorViewHeight)/2;
			[indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
			
			CGFloat labelWidth = 80.f;
			CGFloat labelHeight = 30.0f;
			CGFloat activityIndicatorWidth = 20.0f;
			CGFloat activityIndicatorHeight = 20.0f;
			
			CGFloat labelX = (gIndicatorView.bounds.size.width-labelWidth)/2;
			CGFloat labelY = (gIndicatorView.bounds.size.height+activityIndicatorHeight-labelHeight)/2;
			CGFloat activityIndicatorX = (gIndicatorView.bounds.size.width-activityIndicatorWidth)/2;
			CGFloat activityIndicatorY = (gIndicatorView.bounds.size.height-activityIndicatorHeight-labelHeight)/2;
			
			[labelTitle setFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
			
			[indicator setFrame:CGRectMake(activityIndicatorX, activityIndicatorY, activityIndicatorWidth, activityIndicatorHeight)];
			[indicator startAnimating];
		}

    }
    else {
        CGSize constraintSize = CGSizeMake(240.0f, MAXFLOAT);
        CGSize size = [[labelTitle text] sizeWithFont:[labelTitle font]
                                     constrainedToSize:constraintSize
                                         lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat labelWidth = size.width;
        CGFloat labelHeight = size.height;
        CGFloat labelX = (self.bounds.size.width-labelWidth)/2;
        CGFloat labelY = (self.bounds.size.height-labelHeight)/2;
        [labelTitle setFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        
        CGFloat indicatorViewWidth = labelWidth + 20.0f;
        CGFloat indicatorViewHeight = labelHeight + 20.0f;
        CGFloat indicatorViewX = (self.bounds.size.width-indicatorViewWidth)/2;
        CGFloat indicatorViewY = (self.bounds.size.height-indicatorViewHeight)/2;
        [indicatorView_ setFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight)];
        
        [indicator stopAnimating];
        [indicator setFrame:CGRectZero];
    }
    
    [customView_ setAlpha:1];
    if (!aAnimated) {
        [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }
	[view addSubview:gIndicatorView];

}

- (void)hide {    
	if (customView_.alpha == 0.0) {
		return;
	}
    
    NSLog(@"jfldsjfl");
    [UIView animateWithDuration:0.5f animations:^{
        [customView_ setAlpha:0.f];
    } completion:^(BOOL finished) {
        [indicator stopAnimating];
        if (self.superview) {
            [gIndicatorView removeFromSuperview];
        }
    }];
}



@end
