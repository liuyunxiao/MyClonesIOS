//
//  UIColor+RGB.h
//  ColorDemo
//
//  Created by yebw on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor(RGB)

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB alpha:(CGFloat)aAlpha;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
