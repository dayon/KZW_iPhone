//
//  Tool.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/18.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lesson.h"
#import "LessonCategory.h"

@interface Tool : NSObject
//是否具备网络链接
@property BOOL isNetworkRunning;
//解析JSON
+ (NSMutableArray *)readStrLessonDic:(NSMutableDictionary *)dic andOld:(NSMutableArray *)olds;
+ (NSMutableArray *)readStrCategoryList:(NSMutableDictionary *)dic;
+ (NSMutableArray *)readStrLessonDetail:(NSMutableDictionary *)dic;
+ (NSMutableArray *)readStrAreaList:(NSMutableDictionary *)dic;

+ (NSMutableArray *)readStrLoanList:(NSMutableArray *)array;

+(Tool *) Instance;
@end
