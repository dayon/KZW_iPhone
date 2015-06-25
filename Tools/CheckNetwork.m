//
//  CheckNetwork.m
//  实战手册
//
//  Created by Dayon on 14-6-21.
//  Copyright (c) 2014年 fclaw. All rights reserved.
//

#import "CheckNetwork.h"
#import "AFNetworkReachabilityManager.h"

@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
    
//    AFNetworkReachabilityStatusUnknown          = -1,
//    AFNetworkReachabilityStatusNotReachable     = 0,
//    AFNetworkReachabilityStatusReachableViaWWAN = 1,
//    AFNetworkReachabilityStatusReachableViaWiFi = 2,
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；

    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通：");
                 break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接：" );
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接：");
                break;
            }
            default:
                break;
        }
        
        NSLog(@"网络状态数字返回：%i", status);
        NSLog(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
//        isExistenceNetwork = status;
    }];
//    return [AFNetworkReachabilityManager sharedManager].isReachable;
    return YES;
}
@end
