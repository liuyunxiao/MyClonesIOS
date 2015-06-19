//
//  HttpDownloadTask.m
//  SoccerAlarm
//
//  Created by bw ye on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HttpDownloadTask.h"
#import "NSString+MD5Addition.h"
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"

@implementation HttpDownloadTask

@synthesize fileUrl = fileUrl_;
@synthesize localFilePath = localFilePath_;

- (void)requestFinished:(ASIHTTPRequest *)request
{
    TaskResult *result = [TaskResult resultWithType:TASK_RESULT_SUCCESS value:localFilePath_];
    [self notifyWithResultOnMainThread:result finished:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    TaskResult *result = [TaskResult resultWithErrorCode:request.error.code description:request.error.localizedDescription];
    [self notifyWithResultOnMainThread:result finished:YES];
}

- (void)start
{
    NSAssert(fileUrl_!=nil, @"Download task must has the url");
    
    [super start];
    
    [downloadRequest_ clearDelegatesAndCancel];
    [downloadRequest_ release];
    
    downloadRequest_ = [[ASIHTTPRequest alloc] initWithURL:fileUrl_];
    
    if (localFilePath_.length == 0)
    {
        NSString *fileName = [[fileUrl_ absoluteString] stringFromMD5];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        [localFilePath_ release];
        localFilePath_ = [[documentDirectory stringByAppendingPathComponent:fileName] retain];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:localFilePath_])
        {
            [[NSFileManager defaultManager] removeItemAtPath:localFilePath_ error:nil];
        }
    }
    
    NSString *tempFilePath = [NSString stringWithFormat:@"%@.download", localFilePath_];
    
    [downloadRequest_ setTemporaryFileDownloadPath:tempFilePath];
    [downloadRequest_ setAllowResumeForFileDownloads:YES];
    [downloadRequest_ setDownloadCache:[ASIDownloadCache sharedCache]];
    [downloadRequest_ setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [downloadRequest_ setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [downloadRequest_ setDelegate:self];
    [downloadRequest_ setTimeOutSeconds:30];
    [downloadRequest_ setDownloadDestinationPath:localFilePath_];
    [downloadRequest_ startAsynchronous];
}

- (void)cancel
{
    [super cancel];
    
    [downloadRequest_ clearDelegatesAndCancel];
}

- (void)dealloc
{
    [downloadRequest_ clearDelegatesAndCancel];
    [downloadRequest_ release];
    
    [fileUrl_ release];
    [localFilePath_ release];
    
    [super dealloc];
}

@end
