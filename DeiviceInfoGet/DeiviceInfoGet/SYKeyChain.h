//
//  SYKeyChain.h
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2016/12/21.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KUSERNAME  @"com.tianmushan.username"
#define KPASSWORD  @"com.tianmushan.password"

@interface SYKeyChain : NSObject

+ (void)save:(NSString*)saveStr data:(id)data;
+ (id)load:(NSString*)loadName;
+ (void)deleteName:(NSString*)deleteName;

@end
