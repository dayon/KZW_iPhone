//
//  Tool.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/18.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "Tool.h"
#import "Loan.h"


@implementation Tool
+ (NSMutableArray *)readStrLessonDic:(NSMutableDictionary *)dic andOld:(NSMutableArray *)olds{
    NSLog(@"=======%@",dic);
    NSMutableArray *lessonArray = [[NSMutableArray alloc] initWithCapacity:10];
    

    NSArray *keys = [dic allKeys];
    
    NSInteger length = [keys count];
    
    for (int i = 0; i < length; i++){
        
        NSMutableDictionary *tmpDic = [dic objectForKey:keys[i]];
        
        Lesson *les = [[Lesson alloc] initWithParameters:[[tmpDic objectForKey:@"id"] intValue] andImg:[tmpDic objectForKey:@"logo"] andTitle:[tmpDic objectForKey:@"name"] andScore:[tmpDic objectForKey:@"score"] andSchool:[tmpDic objectForKey:@"school"] andFocusCounts:[tmpDic objectForKey:@"num_focus"] andIsFocus:[[tmpDic objectForKey:@"isFocus"] intValue]> 0?YES:NO];
        
        [lessonArray addObject:les];

        
    }
    
    
    return lessonArray;
    
}

+ (NSMutableArray *)readStrCategoryList:(NSMutableDictionary *)dic{
    
    
//    NSLog(@"readStrLessonCategoryDic========%@",dic);
    
    NSMutableArray *categoryArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSArray *keys = [dic allKeys];
    NSInteger length = [keys count];
    
    for (int i = 0; i < length; i++){
        
        NSMutableDictionary *tmpDic = [dic objectForKey:keys[i]];
        
        LessonCategory *lc = [[LessonCategory alloc] initWithParameters:[[tmpDic objectForKey:@"id"] intValue] andTitle:[tmpDic objectForKey:@"name"]];
        [categoryArray addObject:lc];
        
    }
    
    return categoryArray;
}

+ (NSMutableArray *)readStrAreaList:(NSMutableDictionary *)dic{

    NSMutableArray *areaArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSArray *keys = [dic allKeys];
    NSInteger length = [keys count];
    
    for (int i = 0; i < length; i++){
        
        NSMutableDictionary *tmpDic = [dic objectForKey:keys[i]];
        
        LessonCategory *lc = [[LessonCategory alloc] initWithParameters:[[tmpDic objectForKey:@"areaid"] intValue] andTitle:[tmpDic objectForKey:@"name"]];
        [areaArray addObject:lc];
        
    }
    
    return areaArray;
}

+ (NSMutableArray *)readStrLessonDetail:(NSMutableDictionary *)dic{//课程详细页面
    
    
    NSMutableArray *detailArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSArray *keys = [dic allKeys];
    NSInteger length = [keys count];
    
    for (int i = 0; i < length; i++){
        
        NSMutableDictionary *tmpDic = [dic objectForKey:keys[i]];
        
        LessonCategory *lc = [[LessonCategory alloc] initWithParameters:[[tmpDic objectForKey:@"id"] intValue] andTitle:[tmpDic objectForKey:@"name"]];
        [detailArray addObject:lc];
        
    }
    
    return detailArray;
}


static Tool * instance = nil;
+(Tool *) Instance
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

#pragma mark -
#pragma mark 我的贷款
+ (NSMutableArray *)readStrLoanList:(NSMutableArray *)array{
    
    NSMutableArray *arrList = [[NSMutableArray alloc] init];
    for (int i=0 ; i < array.count; i ++) {
        
        NSDictionary *dict = [array objectAtIndex:i];
        //        NSLog(@"readStrLoanList dic ########%@",dict);
        NSString *title = [dict objectForKey:@"course_name"];
        NSString *status = [dict objectForKey:@"status_desc"];
        NSString *amount = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"money_apply"]];
        NSString *rDate = [dict objectForKey:@"next_repay_day"];//@"2015年8月8日";//
        
        
        NSString *rAmount = [NSString stringWithFormat:@"￥%.2f",[[dict objectForKey:@"next_money_principal"] floatValue]+[[dict objectForKey:@"next_money_interest"] floatValue]];
        NSString *principal = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"next_money_principal"]];
        NSString *interest = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"next_money_interest"]];
        
        
        Loan *lo = [[Loan alloc] initWithParameters: title andStatus:status andAmount:amount andDate:rDate andReAmount:rAmount andPrincipal:principal andInterest:interest];
        [arrList addObject:lo];
    }
    return arrList;
}


@end
