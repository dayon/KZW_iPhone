//
//  LessonDetail.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/22.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonDetail : NSObject

@property (nonatomic, assign) NSInteger lessonId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *focusCounts;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *lessonHour;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *activeTitle;  //活动标题
//@property (nonatomic, copy) NSString *actives;  //
@property (nonatomic, copy) NSString *introduce;    //text
//@property (nonatomic, copy) NSString *chart;      //综合得分图表
@property (nonatomic, assign) BOOL isFocus;

- (id)initWithParameters:(NSInteger)lId
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
              andIsFocus:(BOOL)lStatus;


/*
name 名称
学校 school 节点里
num_focus 关注
score 评分
time_begin开课时间
hour 课程时间
tuition课程价格
logo 图片

活动 school_act 节点 title
base 节点里的desp : 课程介绍文字 文本内容
eval 节点 下 综合得分 总分5分


isFocus 右下关注Bool 状态。
 */
@end
