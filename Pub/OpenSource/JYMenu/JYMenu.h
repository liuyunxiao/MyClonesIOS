//
//  JYMenu.h
//  JYScrollMenu
//
//  Created by Jeerain
//

#import <Foundation/Foundation.h>

@interface JYMenu : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *titleSelectedFont;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *titleHighlightedColor;
@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *selectedImage;

@end
