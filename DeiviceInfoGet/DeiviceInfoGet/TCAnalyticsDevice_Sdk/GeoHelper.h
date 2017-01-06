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
#import <CoreLocation/CoreLocation.h>

typedef void (^getAddressSuccess) (double latitude,double longitude,NSDate *time); //位置获取成功的回调


@interface GeoHelper : NSObject

+ (instancetype)geoWithSuccess:(getAddressSuccess)success;

/**位置获取成功的回调*/
@property(nonatomic,copy)getAddressSuccess getAddressSuccess;

@end
