//
//  MNavigationBar.h
//  CloudAlbum_iPhone
//
//  Created by yebw on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSingleton.h"

@interface MNavigationBarDecorator : NSSingleton {

}

- (void)decorateNavigationController:(UINavigationController *)aNC withBackgourndImage:(UIImage *)aImage;

@end
