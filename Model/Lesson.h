//
//  Lesson.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/18.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lesson : NSObject

@property (nonatomic, assign) NSInteger lessonId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, assign) BOOL isFocus;
@property (nonatomic, copy) NSString *focusCounts;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *classHour;;
- (id)initWithParameters:(NSInteger)lID andImg:(NSString *)lImg andTitle:(NSString *)lTitle andScore:(NSString *)lScore andSchool:(NSString *)lSchool andFocusCounts:(NSString *)counts andIsFocus:(BOOL)isFocus;
@end
