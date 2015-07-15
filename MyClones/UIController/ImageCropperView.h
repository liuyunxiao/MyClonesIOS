//
//  ImageCopperView.h
//  PerfectImageCropper
//
//  Created by Jin Huang on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@protocol ImageCropperDelegate;

@interface ImageCropperView : UIView {
	UIImageView *imageView;
	
	id <ImageCropperDelegate> delegate;
    
    CGFloat WIDTH_;
    CGFloat HEIGHT_;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *croppedImage;
@property (nonatomic, assign) CGFloat WIDTH;
@property (nonatomic, assign) CGFloat HEIGHT;

@property (nonatomic, assign) id <ImageCropperDelegate> delegate;

- (void)setup;
- (void)finishCropping;
- (void)reset;

@end

@protocol ImageCropperDelegate <NSObject>
- (void)imageCropper:(ImageCropperView *)cropper didFinishCroppingWithImage:(UIImage *)image;
@end