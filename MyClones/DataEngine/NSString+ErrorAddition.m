//
//  NSString+ErrorAddition.m
//  FreeBao
//
//  Created by 禹 振伟 on 11-12-15.
//  Copyright (c) 2011年 左岸科技. All rights reserved.
//

#import "NSString+ErrorAddition.h"

@implementation NSString(ErrorAddition)

+ (NSString *)stringWithErrorCode:(NSInteger)aErrorCode
{
    NSString *str = nil;
    
    switch (aErrorCode)
    {
        case 0:
            str =  NSLocalizedString(@"errmsg_text0", nil);;
            break;

        case -1:
            //str = @"未知错误";
            str = NSLocalizedString(@"errmsg_text1", nil);
            break;
            
        case 9999:
            //str = @"系统异常";
            str = NSLocalizedString(@"errmsg_text1", nil);
            break;
            
        case 1001:
            //str = @"用户不存在";
            str = NSLocalizedString(@"errmsg_text2", nil);
            break;
            
        case 1002:
            //str = @"密码错误";
            str = NSLocalizedString(@"errmsg_text3", nil);
            break;
            
        case 1003:
            //str = @"用户未登录";
            str = NSLocalizedString(@"errmsg_text4", nil);
            break;
            
        case 1004:
            //str = @"邮箱被注册";
            str = NSLocalizedString(@"errmsg_text5", nil);
            break;
            
        case 1005:
            //str = @"用户名被使用";
            str = NSLocalizedString(@"errmsg_text6", nil);
            break;
            
        case 1006:
            //str = @"昵称被使用";
            str = NSLocalizedString(@"errmsg_text7", nil);
            break;
            
        case 1007:
            //str = @"url被使用";
            str = NSLocalizedString(@"errmsg_text8", nil);
            break;

        case 1008: 
            //str = @"注册用户失败";
            str = NSLocalizedString(@"errmsg_text9", nil);
            break;
            
        case 1009:
            //str = @"图片格式不正确";
            str = NSLocalizedString(@"errmsg_text10", nil);
            break;
            
        case 1010:
            //str = @"图片尺寸不正确";
            str = NSLocalizedString(@"errmsg_text11", nil);
            break;
            
        case 1011:
            //str = @"圈子名称重复";
            str = NSLocalizedString(@"errmsg_text12", nil);
            break;
            
        case 1012:
            //str = @"删除圈子失败";
            str = NSLocalizedString(@"errmsg_text13", nil);
            break;
            
        case 1013:
            //str = @"用户被锁定";
            str = NSLocalizedString(@"errmsg_text14", nil);
            break;
            
        case 1014:
            //str = @"不能重复发送微博";
            str = NSLocalizedString(@"errmsg_text15", nil);
            
            break;
        case 1015:
            //str = @"此条微博不存在";
            str = NSLocalizedString(@"errmsg_text16", nil);
            break;
            
        case 2012:
            //str = @"网络连接错误";
            str = NSLocalizedString(@"errmsg_text17", nil);
            break;
            
        default:
            //str = @"未知错误";
            str = NSLocalizedString(@"errmsg_text0", nil);
            break;
    }
    
    return str;
}

@end
