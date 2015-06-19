//
//  LoadMoreTableViewCell.m
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadMoreTableViewCell.h"

@implementation LoadMoreTableViewCell

@synthesize indicator;
@synthesize moreImageView;
@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	
	if (highlighted) {
		[moreImageView setImage:[UIImage imageNamed:@"more_btn_on"]];
	}
	else {
		[moreImageView setImage:[UIImage imageNamed:@"more_btn"]];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)dealloc {
	[indicator release];
	[moreImageView release];
	[label release];
	
    [super dealloc];
}


@end
