//
//  Common.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#ifndef MyClones_Common_h
#define MyClones_Common_h

#define HTTP_Url    @"http://127.0.0.1/"
#define HTTP_Port    @"3000"

#define Cach_Key_CookieProperties  @"Cach_Key_CookieProperties"

#define Event_Login     @"Event_Login"

typedef enum {
    EAT_Phone,
    EAT_Email,
} EAccountType;

typedef enum{
    EHRC_Success,
} EHttpRevCode;

typedef enum {
    EUIBT_Dynamic,      //动态
    EUIBT_Phantasm,     //分身
    EUIBT_Hello,        //你好
    EUIBT_Self,         //我
    EUIBT_All,
} EUIBottomType;

typedef enum {
    EPT_EShoppingReviewer,     //网购
} EPhantasmType;

#endif
