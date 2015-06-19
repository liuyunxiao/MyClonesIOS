//
//  EmojiView.h
//  FreeBao
//
//  Created by ye bingwei on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoji.h"

#define kEmojiWidth     45.f    // 一行显示7个
#define kEmojiHeigth    45.f

@class EmojiView;
@protocol EmojiViewDelegate <NSObject>

-(void)emojiDidSelect:(Emoji *)aEmoji;
-(void)emojiDidDelete;

@end

@interface EmojiView : UIView<UIScrollViewDelegate>
{
@private
    id<EmojiViewDelegate>   delegate_;
    
    UIScrollView            *scrollView_;
    UIPageControl           *pageControl_;
    NSMutableArray          *emojis_;
}

@property(nonatomic, assign) IBOutlet id<EmojiViewDelegate> delegate;

@end
