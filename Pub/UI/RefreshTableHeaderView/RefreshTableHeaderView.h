//
//  RefreshTableHeaderView.h
//  ipad_reader
//
//  Created by reed zhu on 10-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>


typedef enum{
	PullRefreshPulling = 0,
	PullRefreshNormal,
	PullRefreshLoading,	
} PullRefreshState;

@interface RefreshTableHeaderView : UIView {
	
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
	PullRefreshState _state;
	
}

@property(nonatomic,assign) PullRefreshState state;

- (void)setCurrentDate;
- (void)setState:(PullRefreshState)aState;

@end