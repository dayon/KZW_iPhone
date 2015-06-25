//
//  Connect.h
//  TextMovie
//
//  Created by 张宁浩 on 14-10-10.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface Connect : NSObject
/**
 GET请求方法URL处添加需请求的网址，dic为所请求到的字典
 */
+ (void)connectGETWithURL : (NSString *) url parames : (NSDictionary *) parames connectBlock : (void (^)(NSMutableDictionary * dic)) connectBlock failuer : (void (^)(NSError * error)) failure;
/**
 POST请求方法URL处添加需请求的网址，dic为所请求到的字典
 */
+ (void)connectPOSTWithURL : (NSString *) url parames : (NSDictionary *) parames connectBlock : (void (^)(NSMutableDictionary * dic)) connectBlock failuer : (void (^)(NSError * error)) failure;
/**
 上传文件及多个文件 将多个/单个文件放到数组中 传入imageArr参数中 即可完成
 */
+ (void) connectDATAWithURL : (NSString *) url parames : (NSDictionary *) parames imageArr : (NSMutableArray * ) imageArr succeed : (void(^)(NSMutableDictionary * dic)) succeed failure : (void(^)(NSError * connectError)) failure;

//上传Cookies
+ (void)postCookiesWithPath:(NSString *)path params:(NSDictionary *)params success:(void(^)(NSMutableDictionary *dic))success failure:(void(^)(NSError *error))failure;
+ (void) displayMessage:(NSString *)paramMessage;
@end
