//
//  Common.h
//  MyClones
//
//  Created by lyx on 15/6/19.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#ifndef MyClones_Common_h
#define MyClones_Common_h

//#define HTTP_Url    @"http://127.0.0.1"
#define HTTP_Url            @"http://192.168.0.114"
//#define HTTP_Url            @"http://192.168.1.108"

//#define HTTP_Pic_Avatar     @"http://127.0.0.1/Avatar/"
#define HTTP_Pic_Avatar     @"http://192.168.0.114/Avatar/"
//#define HTTP_Pic_Avatar     @"http://192.168.1.108/Avatar/"

#define HTTP_Port           @"3000"

#define Cach_Key_CookieProperties       @"Cach_Key_CookieProperties"

#define Notification_Login              @"Notification_Login"
#define Notification_DeviceToken        @"Notification_DeviceToken"

#define Notification_HeadPicChange      @"Notification_HeadPicChange"

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
    EPT_EShopping,      //网购
    EPT_RentHouse,      //租房
    EPT_Pengpeng,       //碰碰
    EPT_Flea,           //二手
    EPT_All,
} EPhantasmType;

typedef enum {
    EST_Null,
    EST_Male,
    EST_Female,
} ESexType;

#endif
