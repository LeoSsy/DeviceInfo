//
//  UIDevice+info.h
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2016/12/20.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (info)

/**
 *  获取当前应用的名字
 *
 *  @return <#return value description#>
 */
+(NSString *)getAppName;

/**
 *  获取当前应用的版本号
 *
 *  @return <#return value description#>
 */
+(NSString *)getAppVersion;

/**
 *  获取当前的Wi-Fi名称
 *
 *  @return <#return value description#>
 */
+(NSString *)getWifiName;

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
+(NSString *)getWifiInfo;

/**
 *  获取当前手机的IP地址
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIPAddress;

/**
 *  获取wifi信号强度
 *
 *  @return <#return value description#>
 */
+ (int )getSignalStrength;

/**
 *  获取网络状态 2g 3g 4g wifi
 *
 *  @return <#return value description#>
 */
+ (NSString *)networkingStatesFromStatebar;

/**
 *  获取网络状态 2g 3g 4g wifi
 *
 *  @return <#return value description#>
 */
+ (NSInteger)networkingStatusFromStatebar;

/**
 *  获取当前的运营商名字
 *
 *  @return <#return value description#>
 */
+ (NSString*)getServiceProviderName;

/**
 *  获取mac地址
 *
 *  @return <#return value description#>
 */
+ (NSString *) macaddress;

/**
 *  获取当前设备使用的语言
 *
 *  @return <#return value description#>
 */
+ (NSString*)getCurrentLanguage;


/**
 *  获取imsi
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIMSI;

/**
 *  获取mcc
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMCC;

@end
