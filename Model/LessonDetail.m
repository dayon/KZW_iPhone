//
//  LessonDetail.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/22.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "LessonDetail.h"

@implementation LessonDetail
- (id)initWithParameters:(NSInteger)lID
               andSchool:(NSString *)lTitle
               andSchool:(NSString *)lSchool
          andFocusCounts:(NSString *)lfocusCounts
                  andImg:(NSString *)lImg
                andScore:(NSString *)lScore
            andBeginTime:(NSString *)lTime
           andLessonHour:(NSString *)lHour
                andPrice:(NSString *)lPrice
          andActiveTitle:(NSString *)lATitle
            andIntroduce:(NSString *)lIntroduce
              andIsFocus:(BOOL)lStatus{
    LessonDetail *ld = [[LessonDetail alloc] init];
    ld.lessonId = lID;
    ld.title = lTitle;
    ld.school = lSchool;
    ld.focusCounts = lfocusCounts;
    ld.img = lImg;
    ld.score = lScore;
    ld.beginTime = lTime;
    ld.lessonHour = lHour;
    ld.price = lPrice;
    ld.activeTitle = lATitle;
    ld.introduce = lIntroduce;
    ld.isFocus = lStatus;
    
    
    return ld;
}
@end
