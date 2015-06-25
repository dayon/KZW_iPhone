//
//  LessonCategory.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/20.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "LessonCategory.h"

@implementation LessonCategory
- (id)initWithParameters:(NSInteger)lID andTitle:(NSString *)lTitle{
    
    LessonCategory * LessonCate = [[LessonCategory alloc] init];
    LessonCate.cateId = lID;
    LessonCate.title = lTitle;
    
    return LessonCate;
    
}

@end
