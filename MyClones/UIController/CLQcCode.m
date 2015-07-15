//
//  CLQcCode.m
//  MyClones
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLQcCode.h"
#import "QRCodeGenerator.h"
#import "UserMgr.h"
@interface CLQcCode ()

@end

@implementation CLQcCode

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![[UserMgr sharedInstance] userData].userId)
        return;
    
    NSDictionary *dic = @{
                          @"userId":[[UserMgr sharedInstance] userData].userId,
                          };
    NSString *codeStr=[self DataTOjsonString:dic];
    imgCode.image = [QRCodeGenerator qrImageForString:codeStr imageSize:imgCode.bounds.size.width];
}

-(void)dealloc
{
    [imgCode release];
    [super dealloc];
}

@end
