//
//  TBTabBar.m
//  TweetBotTabBar
//
//  Created by Jerish Brown on 6/27/11.
//  Copyright 2011 i3Software. All rights reserved.
//

#import "TBTabBar.h"
#import "TBTabButton.h"
#import "TBTabNotification.h"

@interface TBTabBar()

@property (retain) NSMutableArray *buttons;
@property (retain) NSMutableArray *labels;
@property (retain) NSMutableArray *buttonData;
@property (retain) NSMutableArray *statusLights;

-(void)setupButtons;
-(void)setupLights;

@end

@implementation TBTabBar
@synthesize buttons = _buttons, labels = _labels,buttonData = _buttonData, statusLights = _statusLights, delegate;
@synthesize isShowNotify=_isShowNotify;
@synthesize isShowTitle=_isShowTitle;
@synthesize isShowIcon = _isShowIcon;

-(id)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 50);
        self.backgroundColor = [UIColor clearColor];
        
        if ([items count] > 5) {
            [NSException raise:@"Too Many Tabs" format:@"A maximum of 5 tabs are allowed in the TBTabBar. %d were asked to be rendered", [items count]];
        }
        
        UIImageView *backImage=[[UIImageView alloc] initWithFrame:self.frame];
        [backImage setImage:[UIImage imageNamed:@"bottombar_bg"]];
        [backImage setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backImage];
        [backImage release];
        
        _buttonData = [[NSMutableArray alloc] initWithArray:items];
        
        [self setupButtons];
        //[self setupLights];
    }
    return self;
}

- (void)setBadge0Hidden:(BOOL)hide
{
    [badgeButton0 setHidden:hide];
}
- (void)setBadge2Hidden:(BOOL)hide
{
    [badgeButton2 setHidden:hide];
}

-(BOOL)isBadgeButton2Hidden
{
    return [badgeButton2 isHidden];
}

- (void)setBadgeValue:(NSInteger)num
{
  
}

-(void)setupButtons {
    NSInteger count = 0;
    //NSInteger xExtra = 0;
    CGFloat height=_isShowNotify?38.f:50.f;
    NSInteger buttonSize = floor(320 / [self.buttonData count]);
    _buttons = [[NSMutableArray alloc] init];
    _labels = [[NSMutableArray alloc] init];
    for (TBTabButton *info in self.buttonData) {
        NSInteger buttonX = (count * buttonSize);
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(buttonX, 0, buttonSize, height);
        
        //[b setTitle:[info title] forState:UIControlStateNormal];
        [b setImage:[info icon] forState:UIControlStateNormal];
        [b setImage:[info highlightedIcon] forState:UIControlStateHighlighted];
        [b setImage:[info highlightedIcon] forState:UIControlStateSelected];
        [b setImageEdgeInsets:UIEdgeInsetsMake(0.f,0.f,15.f,0.f)];
        
//        [b setBackgroundImage:[UIImage imageNamed:@"bottom_item"] forState:UIControlStateNormal];
//        [b setBackgroundImage:[UIImage imageNamed:@"bottom_item_on"] forState:UIControlStateHighlighted];
//        [b setBackgroundImage:[UIImage imageNamed:@"bottom_item_on"] forState:UIControlStateSelected];
        
        
        [b addTarget:self action:@selector(touchDownForButton:) forControlEvents:UIControlEventTouchDown];
        [b addTarget:self action:@selector(touchUpForButton:) forControlEvents:UIControlEventTouchUpInside];
        [b setTag:(int)info];
        [self addSubview:b];
        
        if(count==0)
        {
            badgeButton0 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX+buttonSize-20, 2, 8.f, 8.f)];
            [badgeButton0.titleLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
            [badgeButton0 setBackgroundImage:[UIImage imageNamed:@"icon_circle"] forState:UIControlStateNormal];
            [badgeButton0 setHidden:YES];
            [self addSubview:badgeButton0];
        }
        
        if(count==3)
        {
            badgeButton2 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX+buttonSize-20, 2, 8.f, 8.f)];
            [badgeButton2.titleLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
            [badgeButton2 setBackgroundImage:[UIImage imageNamed:@"icon_circle"] forState:UIControlStateNormal];
            [badgeButton2 setHidden:YES];
            [self addSubview:badgeButton2];
        }
        
        UILabel *label = [[UILabel alloc] init];
        [label setText:[info title]];
        label.textColor=[info titleColor];
        label.textAlignment=UITextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12.f];
        label.frame = CGRectMake(buttonX, height-20, buttonSize, 18);
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        //[label release];
        
        [_labels addObject:label];
        [label release];
        
        [self.buttons addObject:b];
        count++;
    }
}

-(void)setupLights {
    NSInteger count = 0;
    NSInteger xExtra = 0;
    NSInteger buttonSize = floor(320 / [self.buttonData count]) - 1;
    for (TBTabButton *info in self.buttonData) {
        NSInteger extra = 0;
        if ([self.buttonData count] % 2 == 1) {
            if ([self.buttonData count] == 5) {
                NSInteger i = (count + 1) + (floor([self.buttonData count] / 2));
                if (i == [self.buttonData count]) {
                    extra = 1;
                } else if (i == [self.buttonData count]+1) {
                    xExtra = 1;
                }
            } else if ([self.buttonData count] == 3) {
                buttonSize = floor(320 / [self.buttonData count]);
            }
        } else {
            if (count + 1 == 2) {
                extra = 1;
            } else if (count + 1 == 3) {
                xExtra = 1;
            }
        }
        NSInteger buttonX = (count * buttonSize) + count + xExtra;
        
        [[info notificationView] updateImageView];
        [[info notificationView] setAllFrames:CGRectMake(buttonX, self.frame.size.height - 4, buttonSize + extra, 4)];
        [self addSubview:[info notificationView]];
        count++;
    }
}

-(void)showDefaults {
    [self touchDownForButton:[self.buttons objectAtIndex:0]];
    [self touchUpForButton:[self.buttons objectAtIndex:0]];
}

-(void)touchDownForButton:(UIButton*)button {
    [button setSelected:YES];
    TBTabButton *tag=(TBTabButton*)[button tag];
    [button setBackgroundColor:tag.backgroudHighColor];
}

-(void)touchUpForButton:(UIButton*)button {
    for (UIButton *b in self.buttons) {
        [b setBackgroundColor:((TBTabButton*)[b tag]).backgroudColor];
        [b setSelected:NO];
    }
    [button setSelected:YES];
    [button setBackgroundColor:((TBTabButton*)[button tag]).backgroudHighColor];
}

-(void)setSelectedByIndex:(NSInteger)index
{
    NSInteger count=[self.buttons count];
    for(int i=0;i<count;i++)
    {
        UIButton *button=[self.buttons objectAtIndex:i];
        [button setSelected:(index==i)];
        
//        UILabel *label=[_labels objectAtIndex:i];
//        TBTabButton *info=[button tag];
//        if(index==i)
//        {
//            [label setTextColor:info.titleHighColor];
//        }
//        else
//        {
//            [label setTextColor:info.titleColor];
//        }
    }
}

- (void)dealloc
{
    [_buttons release];
    [_buttonData release];
    [_statusLights release];
    [super dealloc];
}

@end
