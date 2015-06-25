//
//  DataSingleton.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/28.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadingViewCell.h"

@interface DataSingleton : NSObject
#pragma 单例模式
+ (DataSingleton *) Instance;
+ (id)allocWithZone:(NSZone *)zone;

//返回标示正在加载的选项
- (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView
                       andIsLoadOver:(BOOL)isLoadOver
                   andLoadOverString:(NSString *)loadOverString
                    andLoadingString:(NSString *)loadingString
                        andIsLoading:(BOOL)isLoading;

@end
