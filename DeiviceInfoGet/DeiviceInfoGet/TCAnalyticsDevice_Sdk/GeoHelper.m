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

#import "GeoHelper.h"
#import "UIDevice+info.h"

@interface GeoHelper()<CLLocationManagerDelegate>

/**位置管理者*/
@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation GeoHelper

+ (instancetype)geoWithSuccess:(getAddressSuccess)success
{
    GeoHelper *helper = [[GeoHelper alloc] init];
    helper.getAddressSuccess = success;
    return helper;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        // 初始化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        // 设置定位精确度到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //定位服务是否可用
        BOOL enable=[CLLocationManager locationServicesEnabled];
        
        
        if(enable){
            

            //请求权限
            if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
               
                [_locationManager requestWhenInUseAuthorization];
                [_locationManager startUpdatingLocation];

                
            }else{
                
                [_locationManager startUpdatingLocation];
            }
            
           
            
        }else{
            
            
            if (self.getAddressSuccess) {
                self.getAddressSuccess(0,0,[NSDate date]);
            }
            
            NSLog(@"请开启定位功能！");
            
        }
    
        
    }
    
    return self;
}


#pragma mark - CLLocationManagerDelegate

//地理位置发生改变时触发

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    //停止位置更新
    [manager stopUpdatingLocation];
    
    if (self.getAddressSuccess) {
        self.getAddressSuccess(newLocation.coordinate.latitude,newLocation.coordinate.longitude,newLocation.timestamp);
    }
    
}



//定位失误时触发
-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error

{
    NSLog(@"error:%@",error);
    
}


@end



