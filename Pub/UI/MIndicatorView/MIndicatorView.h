//
//  MIndicator.h
//  MIndicatorDemo
//
//  Created by ios on 11-10-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIndicatorView : UIView {
	UIView *customView_;
	UIView *indicatorView_;
	UIActivityIndicatorView *indicator;
	UILabel *labelTitle;
	CGAffineTransform rotationTransform;		
}

- (void)showWithTitle:(NSString *)aTitle animated:(BOOL)aAnimated;
- (void)hide;

+ (id)sharedInstance;
- (id)initWithView:(UIView *)view;
@property (nonatomic,retain)UIView *customView;

@end

// global instance
extern MIndicatorView *gIndicatorView;

