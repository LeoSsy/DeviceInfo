/**************************************************************************
 *
 *  Created by shushaoyong on 2017/1/3.
 *    Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
 * 
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <Foundation/Foundation.h>

@interface TMSDeviceInfo : NSObject

+ (instancetype)device;

/**mac地址*/
@property(nonatomic,copy)NSString *mac;

/**ip地址*/
@property(nonatomic,copy)NSString *ip;

/**wifi状态*/
@property(nonatomic,assign)NSInteger status;

/**字符串数组，["SSID_BSSID_LEVEL"]*/
@property(nonatomic,copy)NSString *usable_wifis;

/**字符串，IMEI国际移动设备识别码，meid，前置位为标志位I：imei， M：meid*/
@property(nonatomic,copy)NSString *imei;

/**字符串，运营商名称*/
@property(nonatomic,copy)NSString *operators;

/**字符串，Mobile Country Code移动国家代码*/
@property(nonatomic,copy)NSString *mcc;

/**整数，0: 其它，1: WIFI，2:2G，3: 3G，4: 4G*/
@property(nonatomic,assign)NSInteger network;

/**字符串，国际移动用户识别码*/
@property(nonatomic,copy)NSString *imsi;

/**整数，SIM卡状态*/
@property(nonatomic,assign)NSInteger sim_state;

/**字符串，系统定制商*/
@property(nonatomic,copy)NSString *brand;

/**字符串，机型信息*/
@property(nonatomic,copy)NSString *model;

/**整数，1: android系统，2: ios系统*/
@property(nonatomic,assign)NSInteger os;

/**字符串，系统版本号 "5.0.1"*/
@property(nonatomic,copy)NSString *os_version;

/**字符串,语言国家*/
@property(nonatomic,copy)NSString *country;

/**字符串,语言*/
@property(nonatomic,copy)NSString *language;

/**android_id*/
@property(nonatomic,copy)NSString *android_id;

/**整数，经度*10000取整，无则传0*/
@property(nonatomic,assign)NSInteger lon;

/**整数，纬度*10000取整，无则传0*/
@property(nonatomic,assign)NSInteger lat;

/**整数，当前位置的时间*/
@property(nonatomic,assign)NSInteger geo_time;

/**字符串数组，["G_MCC_MNC_LAC/TAC_CI","C_SID_NID_BID"]*/
@property(nonatomic,copy)NSString *lbs;

/**time*/
@property(nonatomic,assign)NSInteger time;

@end
