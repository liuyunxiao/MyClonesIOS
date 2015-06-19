//
//  RefreshTableHeaderView.m
//  ipad_reader
//
//  Created by reed zhu on 10-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RefreshTableHeaderView.h"




#define BKDEFAULTCOLOR [UIColor colorWithRed:247/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1]

#define TEXT_COLOR	 [UIColor colorWithRed:130.0/255.0 green:143.0/255.0 blue:166.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@implementation RefreshTableHeaderView

@synthesize state=_state;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = BKDEFAULTCOLOR;//[UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		[label release];
		
		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"RefreshTableView_LastRefresh"]) {
			_lastUpdatedLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"RefreshTableView_LastRefresh"];
		} else {
			[self setCurrentDate];
		}
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = BKDEFAULTCOLOR;//[UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
		
		CALayer *layer = [[CALayer alloc] init];
		layer.frame = CGRectMake(56.0f, frame.size.height - 44.0f, 12.0f, 25.0f);
		layer.contentsGravity = kCAGravityResize;
		layer.contents = (id)[UIImage imageNamed:@"refresh_icon.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		[layer release];
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(56.0f, frame.size.height - 38.0f, 15.0f, 15.0f);
		[self addSubview:view];
		_activityView = view;
		[view release];
		
		[self setState:PullRefreshNormal];
		
    }
    return self;
}

- (void)setCurrentDate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setAMSymbol:@"AM"];
//	[formatter setPMSymbol:@"PM"];
//	[formatter setDateFormat:@"yyyy年M月d日 HH:mm"];
    [formatter setDateFormat:@"yyyy-M-d HH:mm"];
	_lastUpdatedLabel.text = [NSString stringWithFormat:@"%@: %@", @"上次刷新",[formatter stringFromDate:[NSDate date]]];
	[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"RefreshTableView_LastRefresh"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[formatter release];
}

- (void)setState:(PullRefreshState)aState{
	
	switch (aState) {
		case PullRefreshPulling:
			
			_statusLabel.text = @"松开可以刷新...";
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case PullRefreshNormal:
			
			if (_state == PullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = @"下拉可以刷新...";
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			break;
		case PullRefreshLoading:
			
			_statusLabel.text = @"加载中...";
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}

- (void)dealloc {
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}

@end
