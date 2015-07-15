//
//  SignaturePopoverView.m
//  ClickBeauty
//
//  Created by 振伟 禹 on 12-12-8.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "CropImagePopoverView.h"
#import "UIImage+fixOrientation.h"
#import "UIDevice+Resolutions.h"

@implementation CropImagePopoverView

@synthesize delegate=delegate_;
@synthesize image=image_;
@synthesize cropbgView;
@synthesize result;

-(void)setCropImage
{
    [cropbgView setImage:image_];
}

-(void)setCropViewRect:(CGFloat)w height:(CGFloat)h
{
    [rectPanel setFrame:CGRectMake((320-w)/2, (320-h)/2, w, h)];
    [cropbgView setWIDTH:w];
    [cropbgView setHEIGHT:h];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setClearsContextBeforeDrawing:FALSE];
    
//    _cropImageView = [[KICropImageView alloc] initWithFrame:self.cropbgView.bounds];
//    [_cropImageView setCropSize:CGSizeMake(200, 200)];
//    
//    [self.cropbgView addSubview:_cropImageView];
    
    rectPanel.layer.borderWidth = 1.0;
    rectPanel.layer.borderColor = [UIColor greenColor].CGColor;
    
    [cropbgView setup];
    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    if([UIDevice isRunningOniPhone5])
//        [toolpanel setFrame:CGRectMake(0.f, 504.f, toolpanel.frame.size.width, 44)];
//    else
//    {
//        [toolpanel setFrame:CGRectMake(0.f, 416.f, toolpanel.frame.size.width, 460)];
//    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    //[cropbgView release];
    [closeButton_ release];
    [saveButton_ release];
    [result release];
    [rectPanel release];
    [toolpanel release];
    [super dealloc];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissWithAnimated:YES];
}

- (IBAction)confirmButtonPressed:(id)sender {    
    if ([delegate_ respondsToSelector:@selector(cropImageFinished:)])
    {
        [cropbgView finishCropping];
        result.image = cropbgView.croppedImage;
        
        [delegate_ performSelector:@selector(cropImageFinished:) withObject:UIImageJPEGRepresentation(cropbgView.croppedImage,0.9f)];
    }
}
@end
