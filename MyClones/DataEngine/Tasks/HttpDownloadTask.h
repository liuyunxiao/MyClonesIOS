//
//  HttpDownloadTask.h
//  SoccerAlarm
//
//  Created by bw ye on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "ASIHTTPRequest.h"

@interface HttpDownloadTask : Task<ASIHTTPRequestDelegate>
{
@private
    NSURL *fileUrl_;
    NSString *localFilePath_;
    
    ASIHTTPRequest *downloadRequest_;
}

@property(nonatomic, retain) NSURL *fileUrl;
@property(nonatomic, copy) NSString *localFilePath;

@end
