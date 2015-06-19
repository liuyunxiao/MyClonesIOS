//
//  UIColor+RGB.m
//  ColorDemo
//
//  Created by yebw on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor+RGB.h"


@implementation UIColor(RGB)

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB alpha:(CGFloat)aAlpha {
	NSParameterAssert(aRGB<=0xffffff);
	
	NSUInteger r = aRGB>>16;
	NSUInteger g = aRGB<<16>>24;
	NSUInteger b = aRGB<<24>>24;
	
	return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:aAlpha];
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
