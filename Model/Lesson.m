//
//  Lesson.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/18.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "Lesson.h"

@implementation Lesson

- (id)initWithParameters:(NSInteger)lID andImg:(NSString *)lImg andTitle:(NSString *)lTitle andScore:(NSString *)lScore andSchool:(NSString *)lSchool andFocusCounts:(NSString *)counts andIsFocus:(BOOL)isFocus{
    
    Lesson *lesson = [[Lesson alloc] init];
    lesson.lessonId = lID;
    lesson.img = lImg;
    lesson.title = lTitle;
    lesson.score = lScore;
    lesson.school = lSchool;
    lesson.focusCounts = counts;
    lesson.isFocus = isFocus;
    
    return lesson;
}

@end
