//
//  TMSAnalytics.m
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2017/1/6.
//  Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import "TMSAnalytics.h"
#import "TMSDeviceInfo.h"
#import "UIDevice+info.h"
#import "GeoHelper.h"

@implementation TMSAnalytics

static bool isMonitor = false;

static GeoHelper *geo = nil;


/**开始监控*/
+ (void)startGetDeviceInfo:(void (^)(TMSDeviceInfo *))completion
{
    
    if (isMonitor) {
        return;
    }
    
    isMonitor = true;
    TMSDeviceInfo *deviceinfo = [TMSDeviceInfo device];
    deviceinfo.mac = [UIDevice macaddress]?:@"";
    deviceinfo.ip = [UIDevice getIPAddress]?:@"";
    deviceinfo.status = [UIDevice getSignalStrength]?:0;
    deviceinfo.usable_wifis = [UIDevice getWifiInfo]?:@"";
    deviceinfo.imei = @"";
    deviceinfo.operators = [UIDevice getServiceProviderName]?:@"";
    deviceinfo.mcc = [UIDevice getMCC]?:@"";
    deviceinfo.network = [UIDevice networkingStatusFromStatebar];
    deviceinfo.imsi = [UIDevice getIMSI]?:@"";
    deviceinfo.brand = @"Mac os";
    deviceinfo.model = [[UIDevice currentDevice] model];
    deviceinfo.os = 2;
    deviceinfo.os_version = [[UIDevice currentDevice] systemVersion];
    deviceinfo.country =[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]?:@"";
    deviceinfo.language = [UIDevice getCurrentLanguage]?:@"";
    deviceinfo.android_id = @"";
    deviceinfo.lbs = @"";
    deviceinfo.time = [NSDate timeIntervalSinceReferenceDate];
    deviceinfo.geo_time = [NSDate timeIntervalSinceReferenceDate];
    
    geo = [GeoHelper geoWithSuccess:^(double latitude, double longitude, NSDate *time) {
        
        if (deviceinfo.lat) {
            return;
        }
        deviceinfo.lat = latitude*10000;
        deviceinfo.lon = longitude*10000;
        deviceinfo.geo_time = (int)[time timeIntervalSince1970];
        
        //告诉外界 数据获取完成
        
        if (completion) {
            completion(deviceinfo);
        }
        
    }];
    
}



@end
