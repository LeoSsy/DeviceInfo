//
//  NSString+SY.h
//  photo
//
//  Created by shushaoyong on 2016/10/24.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SY)

/**
 *
 *将数组转换为json字符串
 */
+ (NSString*)jsonWithArray:(NSArray*)array;

/**
 *
 *将json字符串转换为数组
 */
+ (NSArray*)arrayWithJson:(NSString*)json;

/**
 *
 * 通过转好的json格式的data获取数组
 */
+ (NSArray*)arrayWithData:(NSData*)data;


/**
 *
 *将字典转换为json字符串
 */
+ (NSString*)jsonWithDictionary:(NSDictionary*)dict;

/**
 *
 *将json字符串转换为字典
 */
+ (NSDictionary*)dictionaryWithJson:(NSString*)json;

/**
 *
 * 通过转好的json格式的data获取字典
 */
+ (NSDictionary*)dictionaryWithData:(NSData*)data;


@end
