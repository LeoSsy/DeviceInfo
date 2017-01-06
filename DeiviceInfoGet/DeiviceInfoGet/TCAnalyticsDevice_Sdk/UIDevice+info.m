//
//  UIDevice+info.m
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2016/12/20.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import "UIDevice+info.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>  //为判断网络制式的主要文件
#import <CoreTelephony/CTCarrier.h> //添加获取客户端运营商 支持

#import <SystemConfiguration/CaptiveNetwork.h> //获取当前手机ip地址和Wi-Fi名称
#import <ifaddrs.h>
#import <arpa/inet.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#import <mach/mach_host.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>

#import "NSString+SY.h"


@implementation UIDevice (info)

/**
 *  获取当前应用的名字
 *
 *  @return <#return value description#>
 */
+(NSString *)getAppName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

/**
 *  获取当前应用的版本号
 *
 *  @return <#return value description#>
 */
+(NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
   return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  获取当前的Wi-Fi名称
 *
 *  @return <#return value description#>
 */
+(NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

/**
 *  获取当前的Wi-Fi信息
 *
 *  @return <#return value description#>
 
 info -> {
 BSSID = "0:9a:cd:a0:3e:cc";
 SSID = zjtachao2;
 SSIDDATA = <7a6a7461 6368616f 32>;
 }
 */
+(NSString *)getWifiInfo
{
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    NSDictionary *wifiInfo = [NSDictionary dictionary];
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            wifiInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", wifiInfo);
            CFRelease(dictRef);
            break;
        }
    }
    
    CFRelease(wifiInterfaces);
    
    NSMutableArray *wifis = [NSMutableArray array];
    
    //将当前字典 转换为
    if (wifiInfo.count>0) {
        NSString *ssid = [wifiInfo objectForKey:@"SSID"];
        NSString *bssid = [wifiInfo objectForKey:@"BSSID"];
        NSString *level = [NSString stringWithFormat:@"%zd",[self getSignalStrength]];
        NSString *wifi = [NSString stringWithFormat:@"%@_%@_%@",ssid?:@"",bssid?:@"",level?:@"0"];
        [wifis addObject:wifi];
    }
    
    //将字典转换为字符串返回
    return [NSString jsonWithArray:wifis];
}



/**
 *  获取当前手机的IP地址
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

/**
 *  获取wifi信号强度
 *
 *  @return <#return value description#>
 */
+ (int )getSignalStrength
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *dataNetworkItemView = nil;
    
    for (UIView * subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    
    NSLog(@"signal %d", signalStrength);
    
    return signalStrength;
}

/**
 *  获取网络状态 2g 3g 4g wifi
 *
 *  @return <#return value description#>
 */
+ (NSString *)networkingStatesFromStatebar {
    
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}


/**
 *  获取网络状态 2g 3g 4g wifi
 *
 *  @return <#return value description#>
 */
+ (NSInteger)networkingStatusFromStatebar {
    
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    NSInteger wifiStatus = 0;
    
    switch (type) {
        case 0:
            wifiStatus = 0;
            break;
            
        case 1:
            wifiStatus = 2;
            break;
            
        case 2:
            wifiStatus = 3;
            break;
            
        case 3:
            wifiStatus = 4;
            break;
            
        case 4:
            wifiStatus = 4;
            break;
            
        case 5:
            wifiStatus = 1;
            break;
            
        default:
            break;
    }
    
    return wifiStatus;
}



/**
 *  获取当前的运营商名字
 *
 *  @return <#return value description#>
 */
+ (NSString*)getServiceProviderName
{
    CTTelephonyNetworkInfo *networkStatus = [[CTTelephonyNetworkInfo alloc]init];  //创建一个CTTelephonyNetworkInfo对象
    return networkStatus.subscriberCellularProvider.carrierName;
}


/**
 *  获取mac地址
 *
 *  @return <#return value description#>
 */
+ (NSString *) macaddress
{
    NSString *bssid = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            bssid = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return bssid;
}


/**
 *  获取当前设备使用的语言
 *
 *  @return <#return value description#>
 */
- (NSString*)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

/**
 *  获取当前国家
 *
 *  @return <#return value description#>
 */
+ (NSString*)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}


/**
 *  获取imsi
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIMSI
{
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    
    NSString *imsi = [NSString stringWithFormat:@"%@%@", mcc, mnc];
    
    return imsi;
}


/**
 *  获取mcc
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMCC
{
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mcc = [carrier mobileCountryCode];
   
    return mcc;
}

@end
