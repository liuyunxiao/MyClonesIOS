/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "ASIHTTPRequest.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url useCache:(BOOL)userCache
{
    if(!userCache)
    {
        [self removeImageForKey:[url absoluteString]];
    }
    
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    
    self.image = placeholder;

    if (url)
    {
        [self compareModified:url];
        [manager downloadWithURL:url delegate:self options:options];
    }
}

- (void)compareModified:(NSURL *)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelForDelegate:self];
    
    NSDictionary *cachedHeaders=[manager cacheHeaderForKey:[url absoluteString]];
    if(cachedHeaders!=nil)
    {
        NSString *expires =[cachedHeaders objectForKey:@"Expires"];
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *mydate=[df dateFromString:expires];
        
        NSComparisonResult result =[mydate compare:[NSDate date]];
        if(result==NSOrderedAscending)
        {
            NSString *lastModified = [cachedHeaders objectForKey:@"Last-Modified"];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setRequestMethod:@"HEAD"];
            [request startSynchronous];
            NSError *error = [request error];
            if (!error) {
                if(request.responseStatusCode==200&&[request responseHeaders]!=nil&&[[request responseHeaders] objectForKey:@"Last-Modified"]!=nil)
                {
                    NSString *response = [[request responseHeaders] objectForKey:@"Last-Modified"];
                    if(![lastModified isEqualToString:response])
                        [self removeImageForKey:[url absoluteString]];
                }
            }
        
            [manager storeHeaderField:cachedHeaders forKey:[url absoluteString]];
        }
    }
    else
    {
        [self removeImageForKey:[url absoluteString]];
    }

}

- (void)removeImageForKey:(NSString *)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    if (url)
    {
        [manager removeImageForkey:url];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)setContentModeScaleAspectFit
{
    if(self.contentMode==UIViewContentModeScaleAspectFit)
    {
        if(self.image)
        {
            CGFloat width = self.image.size.width;
            CGFloat height = self.image.size.height;
            CGFloat w=width*(self.frame.size.height/height);
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, w, self.frame.size.height)];
            
            if([self.superview.superview viewWithTag:100])
            {
                UIImageView *imageView=(UIImageView*)[self.superview.superview viewWithTag:100];
                //NSLog(@"--------------width:%f",imageView.frame.origin.x);
                w+=30;
                CGFloat x=imageView.frame.origin.x;
                if(x!=50)
                {
                    x=320.f-60.f-w;
                    [imageView setFrame:CGRectMake(x+10, imageView.frame.origin.y, w, imageView.frame.size.height)];
                    UIView *bgview=(UIView*)[self.superview.superview viewWithTag:101];
                    [bgview setFrame:CGRectMake(x+12, bgview.frame.origin.y, w-20, bgview.frame.size.height)];
                    [self setFrame:CGRectMake(12, self.frame.origin.y, w-30, self.frame.size.height)];
                }
                else{
                    [imageView setFrame:CGRectMake(x, imageView.frame.origin.y, w, imageView.frame.size.height)];
                }
            }
        }
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
    //[self setContentModeScaleAspectFit];
}

@end
