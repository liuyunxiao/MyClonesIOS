//
//  MCustomBarButtonItem.h
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBarButtonItem : NSObject {

}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)aTitle
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)aImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction
                                      width:(CGFloat)w
                                     height:(CGFloat)h;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)aTitle
                                normalImage:(UIImage *)aNormalImage
                            highligtedImage:(UIImage *)aHighlightedImage
                                     target:(id)aTarget
                                     action:(SEL)aAction 
                                      width:(CGFloat)w
                                     height:(CGFloat)h;

@end
