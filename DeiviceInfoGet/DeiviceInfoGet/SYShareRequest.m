/**************************************************************************
 *
 *  Created by shushaoyong on 2016/12/29.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "SYShareRequest.h"

@implementation SYShareRequest

/**
 *  发送一个没有参数get请求
 *
 *  @param url              请求地址
 *  @param completionHandle 请求结果回调
 */
+ (void)getWithUrl:(NSString*)url paraems:(NSDictionary*)paraems completionHandle:(void (^)(id responseObject,NSError *error))completionHandle;
{
    
    //有参数就拼接
    if (paraems!=nil) {
        
        //拼接参数
        NSMutableString *urlparames = [NSMutableString stringWithString:@"?"];
        
        for (NSString*key in paraems.allKeys) {
            
            [urlparames appendString:[NSString stringWithFormat:@"%@=%@&",key,paraems[key]]];
        }
        
        url = [url stringByAppendingString:urlparames];
        
    }
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSError *err = nil;
        id responseObject = nil;
        
        //序列化响应数据
        if (data) {
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        }
        
        //回到主线程
        if (completionHandle) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandle(responseObject,error);
            });
        }
        
    }];
    
    [task resume];

}

/**
 *  发送一个post请求
 *
 *  @param url              请求地址
 *  @param completionHandle 请求结果回调
 */
+ (void)postWithUrl:(NSString*)url completionHandle:(void (^)(id responseObject,NSError *error))completionHandle
{

}



@end
