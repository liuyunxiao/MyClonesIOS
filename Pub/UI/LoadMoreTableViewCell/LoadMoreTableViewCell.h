//
//  LoadMoreTableViewCell.h
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadMoreTableViewCell : UITableViewCell {
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic, retain) IBOutlet UIImageView *moreImageView;
@property(nonatomic, retain) IBOutlet UILabel *label;

@end
