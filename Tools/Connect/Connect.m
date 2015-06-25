//
//  Connect.m
//  TextMovie
//
//  Created by 张宁浩 on 14-10-10.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "Connect.h"
#import "AFNetworking.h"

static BOOL mark = YES;
@implementation Connect
+ (void)connectGETWithURL : (NSString *) url parames : (NSDictionary *) parames connectBlock : (void (^)(NSMutableDictionary *)) connectBlock failuer:(void (^)(NSError *))failure
{
    //获得路径 存放缓存
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path  = [NSString stringWithFormat:@"%@/%lu.data", path, (unsigned long)[url hash]];
    //打开网络监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //开始监听网络
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            if (mark == YES) {
                
                 UIAlertView * aleterView1 = [[UIAlertView alloc] initWithTitle:@"网络状态提示"  message:@"数据加载失败，请确保您的手机已联网" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aleterView1 show];
                mark = NO;
                
            }
//            if ([[NSFileManager defaultManager] fileExistsAtPath:path] ) {   //如果路径存在就从本地区出(采用解档的方式)
//                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
//                connectBlock(dic);
//            }
//            else {
//                UIAlertView * aleterView1 = [[UIAlertView alloc] initWithTitle:@"网络状态提示"  message:@"无本地数据" delegate:nil cancelButtonTitle:@"我再试试吧" otherButtonTitles:nil, nil];
////                [aleterView1 show];
//            }
        }
        if (status == 2) {
            if (mark == YES) {
                UIAlertView * aleterView2 = [[UIAlertView alloc] initWithTitle:@"网络状态提示" message:@"现在是WIFI网☺️" delegate:nil cancelButtonTitle:@"好的!" otherButtonTitles:nil, nil];
//                [aleterView2 show];
                mark = NO;
            }
            AFHTTPSessionManager * managerRequest = [AFHTTPSessionManager manager];
            managerRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [managerRequest GET:url parameters:parames success:^(NSURLSessionDataTask *task, id responseObject) {
            [NSKeyedArchiver archiveRootObject:responseObject toFile:path]; //因为键值对有null所以用归档 也称序列化 一种加密方式
                connectBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
        }
        if (status == 1) {
            if (mark == YES) {
                UIAlertView * aleterView3 = [[UIAlertView alloc] initWithTitle:@"网络状态提示" message:@"现在是3G网😊" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [aleterView3 show];
                mark = NO;
            }
            AFHTTPSessionManager * managerRequest = [AFHTTPSessionManager manager];
            managerRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [managerRequest GET:url parameters:parames success:^(NSURLSessionDataTask *task, id responseObject) {
                [NSKeyedArchiver archiveRootObject:responseObject toFile:path]; //因为键值对有null所以用归档 也称序列化 一种加密方式
                connectBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
        }
    }];
}
+ (void)connectPOSTWithURL : (NSString *) url parames : (NSDictionary *) parames connectBlock : (void (^)(NSMutableDictionary *)) connectBlock failuer:(void (^)(NSError *))failure
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path  = [NSString stringWithFormat:@"%@/%lu.data", path, (unsigned long)[url hash]];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            if (mark == YES) {
                UIAlertView * aleterView1 = [[UIAlertView alloc] initWithTitle:@"网络状态提示"  message:@"数据加载失败，请确保您的手机已联网" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aleterView1 show];
                mark = NO;
            }
//            if ([[NSFileManager defaultManager] fileExistsAtPath:path] ) {
//                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];//解档取出数据
//                connectBlock(dic);
//            }
//            else {
//                UIAlertView * aleterView1 = [[UIAlertView alloc] initWithTitle:@"网络状态提示"  message:@"没有本地数据" delegate:nil cancelButtonTitle:@"我再试试" otherButtonTitles:nil, nil];
//                [aleterView1 show];
//            }
        }
        if (status == 2) {
            if (mark == YES) {
                UIAlertView * aleterView2 = [[UIAlertView alloc] initWithTitle:@"网络状态提示" message:@"现在是WIFI网😊" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//                [aleterView2 show];
                mark = NO;
            }
            AFHTTPSessionManager * managerRequest = [AFHTTPSessionManager manager];  
            managerRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            managerRequest.requestSerializer= [AFHTTPRequestSerializer serializer];
//            managerRequest.responseSerializer= [AFHTTPResponseSerializer serializer];       //back NSData
            
            [managerRequest POST:url parameters:parames success:^(NSURLSessionDataTask *task, id responseObject) {
               [NSKeyedArchiver archiveRootObject:responseObject toFile:path]; //因为键值对有null所以用归档 也称序列化 一种加密方式
                connectBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
        }
        if (status == 1) {
            if (mark == YES) {
                UIAlertView * aleterView3 = [[UIAlertView alloc] initWithTitle:@"网络状态提示" message:@"现在是3G网😊" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//                [aleterView3 show];
                mark = NO;
            }
            AFHTTPSessionManager * managerRequest = [AFHTTPSessionManager manager];
            managerRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            managerRequest.requestSerializer= [AFHTTPRequestSerializer serializer];
            //            managerRequest.responseSerializer= [AFHTTPResponseSerializer serializer];       //back NSData
            
            [managerRequest POST:url parameters:parames success:^(NSURLSessionDataTask *task, id responseObject) {
                [NSKeyedArchiver archiveRootObject:responseObject toFile:path]; //因为键值对有null所以用归档 也称序列化 一种加密方式
                connectBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
        }
    }];
}
+ (void) connectDATAWithURL : (NSString *) url parames : (NSDictionary *) parames imageArr : (NSMutableArray * ) imageArr succeed : (void(^)(NSMutableDictionary * dic)) succeed failure : (void(^)(NSError * connectError)) failure
{
    __block NSInteger num = 1;
    AFHTTPRequestOperationManager * managerRequest = [AFHTTPRequestOperationManager manager];
    managerRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    managerRequest.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];                  //back NSData
    [managerRequest POST:url parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData * imageData in imageArr) {
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%ld", num] fileName:[NSString stringWithFormat:@"%ld", num] mimeType:@"image/jpeg"];
            num ++;
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeed(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


#pragma mark -
#pragma mark 提示
+ (void)postCookiesWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSMutableDictionary *dic))success failure:(void(^)(NSError *error))failure{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path  = [NSString stringWithFormat:@"%@/%lu.data", path, (unsigned long)[url hash]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
        if([cookiesdata length]) {
            NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}


+ (void) displayMessage:(NSString *)paramMessage{
    [[[UIAlertView alloc] initWithTitle:nil
                                message:paramMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
@end
