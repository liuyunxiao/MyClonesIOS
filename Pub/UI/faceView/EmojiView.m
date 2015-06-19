//
//  EmojiView.m
//  FreeBao
//
//  Created by ye bingwei on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmojiView.h"

@implementation EmojiView

@synthesize delegate = delegate_;

-(void)buttonClick:(UIButton *)button
{
    Emoji *emoji = [emojis_ objectAtIndex:(button.tag-1)];
    if ([delegate_ respondsToSelector:@selector(emojiDidSelect:)])
    {
        [delegate_ emojiDidSelect:emoji];
    }
}

- (void)deleteButtonClick:(UIButton *)button
{
    if([delegate_ respondsToSelector:@selector(emojiDidDelete)])
    {
        [delegate_ emojiDidDelete];
    }
}


//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    NSLog(@"%d",index);
    pageControl_.currentPage = index;
}

- (void)setup
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *keys = [dic allKeys];
    int keyCount=[keys count];
    emojis_ = [[NSMutableArray alloc] init];
    for (int i=0;i<keyCount;i++)
    {
        if(i>0&&i%20==0)
        {
            Emoji *emoji = [[Emoji alloc] init];
            [emoji setKey:@""];
            [emoji setText:@""];
            [emojis_ addObject:emoji];
        }
        
        NSString *name=[keys objectAtIndex:i];
        Emoji *emoji = [[Emoji alloc] init];
        [emoji setKey:[NSString stringWithFormat:@"[%d]",i]];
        [emoji setText:name];
        [emoji setFileName:[dic objectForKey:name]];
        
        [emojis_ addObject:emoji];
        [emoji release];
    }
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView_.delegate=self;
    
    scrollView_.pagingEnabled = YES;
    [scrollView_ setShowsHorizontalScrollIndicator:NO];
    [scrollView_ setShowsVerticalScrollIndicator:NO];
    
    
    int row=[emojis_ count]/7;
    if([emojis_ count]%7!=0)
        row++;
    int col=row/3;
    if(row%3!=0)
        col++;
    
    pageControl_ = [[UIPageControl alloc] initWithFrame:CGRectMake(0,140, 320, 40)];
    pageControl_.backgroundColor = [UIColor clearColor];
    pageControl_.hidesForSinglePage = YES;
    pageControl_.userInteractionEnabled = NO;
    pageControl_.numberOfPages = col;     //几个小点
    [self addSubview:pageControl_];
    [self insertSubview:scrollView_ atIndex:0];
    
    
    CGFloat width = col*320;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, width, 180)];
    float x=0;
    for (int i = 0; i < col*3; i++)
    {
        if(i>0&&i%3==0)
        {
            x+=320;
        }
        
        for (int j = 0; j < 7; j++)
        {
            if(i%3==2&&j==6)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:[UIImage imageNamed:@"emoji_del_btn"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"emoji_del_btn_on"] forState:UIControlStateHighlighted];
                
                [button addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(x+j*42+15, (i%3)*42+20, 27, 23);
               
                [v addSubview:button];
                continue;
            }
            
            NSInteger index = i*7+j;
            if (index >= [emojis_ count])
            {
                continue;
            }
            
            Emoji *emoji = [emojis_ objectAtIndex:index];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = index+1;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(x+j*42+20, (i%3)*42+20, 22, 22);
            [button setImage:[UIImage imageNamed:emoji.fileName] forState:UIControlStateNormal];
            if (button.imageView.image == nil) 
            {
                [button setEnabled:NO];
            }
            [v addSubview:button];
        }
    }
    [scrollView_ setContentSize:v.bounds.size];
    [scrollView_ addSubview:v];
    [v release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {   
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {   
        [self setup];
    }
    return self;   
}

- (void)dealloc
{
    [scrollView_ setDelegate:nil];
    [scrollView_ removeFromSuperview];
    [scrollView_ release];
    
    [emojis_ release];
    
    [super dealloc];
}

@end
