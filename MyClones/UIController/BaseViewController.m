//
//  BaseViewController.m
//  loan
//
//  Created by Yu Zhenwei on 14-12-18.
//  Copyright (c) 2014年 Zhenwei. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
@synthesize popType=popType_;

-(void)leftButtonClick:(id)sender{
    if(popType_==PopPRE)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (popType_==PopROOT)
    {
        [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor lightGrayColor], UITextAttributeTextColor,
                                                                     [UIColor lightGrayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                     [UIFont boldSystemFontOfSize:16.f], UITextAttributeFont,
                                                                     nil]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithHexString:@"c6c6c6"]];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f8f4f1"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
  
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    BOOL flag=FALSE;
    NSArray *list=self.navigationController.navigationBar.subviews;
    for (id obj in list) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView=(UIImageView *)obj;
            NSInteger tag=imageView.tag;
            if(tag==1000)
            {
                flag=TRUE;
                imageView.hidden=NO;
            }
            else
            {
                imageView.hidden=YES;
            }
        }
    }
    
    if(!flag)
    {
        UIImageView *imageview=[[UIImageView alloc] init];
        [imageview setFrame:CGRectMake(0, -20, 320, 70)];
        [imageview setImage:[UIImage imageNamed:@"dh"]];
        [imageview setTag:1000];
        [self.navigationController.navigationBar insertSubview:imageview atIndex:0];
        [imageview release];
    }
}

- (void)dealloc {
    [super dealloc];
}

- (void)pushViewControllerWithDuration:(NSString *)identifier animated:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
															 bundle: nil];
	UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier: identifier];
    
	[[SlideNavigationController sharedInstance] pushViewControllerWithDuration:vc animated:animated];
}

-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius
{
    view.layer.cornerRadius = radius;
}

-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius BorderWidth:(CGFloat)borderWidth
{
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

-(void)setRadiusView:(UIView*)view Radius:(CGFloat)radius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor*)color
{
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = [color CGColor];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}

@end
