//
//  NSString+SY.m
//  photo
//
//  Created by shushaoyong on 2016/10/24.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import "NSString+SY.h"

@implementation NSString (SY)

/**
 *
 *将数组转换为json字符串
 */
+ (NSString*)jsonWithArray:(NSArray*)array
{
    
    if (!array)  return nil;
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}

/**
 *
 *将json字符串转换为数组
 */
+ (NSArray*)arrayWithJson:(NSString*)json
{
    if (!json) return nil;
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithData:data];
}

/**
 *
 * 通过转好的json格式的data获取数组
 */
+ (NSArray*)arrayWithData:(NSData*)data
{
    if (data==nil) return nil;
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return array;
    
}


/**
 *
 *将字典转换为json字符串
 */
+ (NSString*)jsonWithDictionary:(NSDictionary*)dict
{
    if (!dict)  return nil;
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *
 *将json字符串转换为字典
 */
+ (NSDictionary*)dictionaryWithJson:(NSString*)json
{
    if (!json) return nil;
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self dictionaryWithData:data];
}


/**
 *
 * 通过转好的json格式的data获取字典
 */
+ (NSDictionary*)dictionaryWithData:(NSData*)data
{
    if (data==nil) return nil;
    
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return dict;
    
}

@end
