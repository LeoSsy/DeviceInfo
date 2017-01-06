//
//  ViewController.m
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2016/12/20.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "AES.h"
#import "TMSDeviceInfo.h"
#import "NSString+SY.h"
#import "TMSAnalytics.h"
#import "SYShareRequest.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    __weak typeof(self) weakS = self;
    [TMSAnalytics startGetDeviceInfo:^(TMSDeviceInfo *info) {
       
        [weakS componetParaems:info];
        
    }];
    
    
   
    
}



/**
 *  拼接参数
 *
 *  @param info <#info description#>
 */

- (void)componetParaems:(TMSDeviceInfo*)info
{
    
    NSMutableString *url = [NSMutableString stringWithString:@"http://192.168.1.34/mgcommit/"];
    
    NSMutableArray *urls = [NSMutableArray array];
    [urls addObject:info.mac];
    [urls addObject:info.ip];
    [urls addObject:@(info.status)];
    [urls addObject:info.usable_wifis];
    [urls addObject:info.imei];
    [urls addObject:info.operators];
    [urls addObject:info.mcc];
    [urls addObject:@(info.network)];
    [urls addObject:info.imsi];
    [urls addObject:@(info.sim_state)];
    [urls addObject:info.brand];
    [urls addObject:info.model];
    [urls addObject:@(info.os)];
    [urls addObject:info.os_version];
    [urls addObject:info.country];
    [urls addObject:info.language];
    [urls addObject:info.android_id];
    [urls addObject:@(info.lon)];
    [urls addObject:@(info.lat)];
    [urls addObject:@(info.geo_time)];
    [urls addObject:info.lbs];
    [urls addObject:@(info.time)];
    
    
    //将数组转换为字符串
    NSString *json = [NSString jsonWithArray:urls];
    
    NSLog(@"json===%@",json);
    
    NSString *aes =  [AES encrypt:json key:@"vlrbI5SHxolT086O" iv:@"lOhXISSCEhLZw9bh"];
    
    [url appendString:aes];
    
    NSLog(@"url========%@",url);
    
    
    NSLog(@"加密后===%@",aes);
    
    NSString *des =  [AES decrypt:aes key:@"vlrbI5SHxolT086O" iv:@"lOhXISSCEhLZw9bh"];
    
    NSLog(@"解密后===%@",des);
    
//    [SYShareRequest getWithUrl:url paraems:nil completionHandle:^(id responseObject, NSError *error) {
//        
//        NSLog(@"responseObject===%@  ==== error===%@",responseObject,error);
//        
//    }];
//    
}



@end
