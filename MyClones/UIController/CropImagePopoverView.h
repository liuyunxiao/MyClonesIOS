//
//  SignaturePopoverView.h
//  ClickBeauty
//
//  Created by 振伟 禹 on 12-12-8.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "MPopoverView.h"
#import "KICropImageView.h"
#import "ImageCropperView.h"

@interface CropImagePopoverView : MPopoverView
{
    @private
    id<NSObject> delegate_;
    UIImage *image_;
    //KICropImageView *_cropImageView;
    IBOutlet UIButton *closeButton_;
    IBOutlet UIButton *saveButton_;
    
    IBOutlet UIView *rectPanel;
    
    IBOutlet UIView *toolpanel;
}
@property(nonatomic, retain) id<NSObject> delegate;
@property (nonatomic,retain) UIImage *image;
@property (retain, nonatomic) IBOutlet ImageCropperView *cropbgView;
@property (retain, nonatomic) IBOutlet UIImageView *result;

-(void)setCropImage;
-(void)setCropViewRect:(CGFloat)w height:(CGFloat)h;
- (IBAction)closeButtonPressed:(id)sender;
- (IBAction)confirmButtonPressed:(id)sender;
@end
