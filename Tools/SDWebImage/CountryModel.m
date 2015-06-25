//
//  CountryModel.m
//  UI_XinMarry
//
//  Created by dlios on 14-8-7.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
- (instancetype)initWith:(NSString *)name code:(NSString *)code
{
    self = [super init];
    if (self) {
        _name = name;
        _code = code;
    }
    return self;
}
@end
