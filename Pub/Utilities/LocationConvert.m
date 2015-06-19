//
//  LocationConvert.m
//  StockTrader
//
//  Created by hnbc8848 on 12-11-10.
//  Copyright (c) 2012年 左岸科技. All rights reserved.
//

#import "LocationConvert.h"

@implementation LocationConvert

+(double)radLatitude:(double)latitude
{
    double m_refLaRadian = latitude*M_PI/180;
    return m_refLaRadian;
}

+(double)radLongitude:(double)longitude
{
    double m_refLoRadian = longitude*M_PI/180;
    return m_refLoRadian;
}

@end
