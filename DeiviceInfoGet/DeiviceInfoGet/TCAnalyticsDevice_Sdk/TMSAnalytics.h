//
//  TMSAnalytics.h
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2017/1/6.
//  Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMSDeviceInfo;

@interface TMSAnalytics : NSObject

/**获取硬件数据*/
+ (void)startGetDeviceInfo:(void (^)(TMSDeviceInfo *info))completion;

@end
