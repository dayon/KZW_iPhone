//
//  DataSingleton.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/28.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "DataSingleton.h"
#import <QuartzCore/QuartzCore.h>
@implementation DataSingleton
- (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView
                       andIsLoadOver:(BOOL)isLoadOver
                   andLoadOverString:(NSString *)loadOverString
                    andLoadingString:(NSString *)loadingString
                        andIsLoading:(BOOL)isLoading
{
    LoadingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingViewCell"];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LoadingViewCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[LoadingViewCell class]]) {
                cell = (LoadingViewCell *)o;
                break;
            }
        }
    }
    cell.lbl.font = [UIFont boldSystemFontOfSize:21.0];
    cell.lbl.text = isLoadOver ? loadOverString : loadingString;
    if (isLoading) {
        cell.loading.hidden = NO;
        [cell.loading startAnimating];
    }
    else
    {
        cell.loading.hidden = YES;
        [cell.loading stopAnimating];
    }
    
    return cell;
}


#pragma 单例模式定义
static DataSingleton * instance = nil;
+(DataSingleton *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}
@end
