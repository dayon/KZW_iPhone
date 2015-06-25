//
//  MainInfoTableViewCell.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
@interface MainInfoTableViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel * titleLable;
@property (nonatomic ,strong) UILabel * schoolNameLable;
@property (nonatomic ,strong) UILabel * schoolNameLable2;
@property (nonatomic ,strong) UILabel * focusLable;
@property (nonatomic ,strong) UILabel * scoreLable;
@property (nonatomic ,strong) UILabel * bgTimeLable;
@property (nonatomic ,strong) UILabel * timeLable;
@property (nonatomic ,strong) UILabel * hourLable;
@property (nonatomic ,strong) UILabel * priceLable;
@property (nonatomic, strong) UILabel * oldPrice;
@property (nonatomic ,strong) UIWebView * introduceView;

@property (nonatomic, strong) UIImageView * firstImageView;
@property (nonatomic, strong) UILabel * lessonInfo;
@property (nonatomic, strong) UILabel * schoolInfo;
@property (nonatomic, strong) UIImageView * secondImageView;
@property (nonatomic, strong) CWStarRateView * starView;

@property (nonatomic, strong) UILabel * totalScore;
@property (nonatomic, strong) UILabel * chartLabel;

@property (nonatomic, strong)ChartView * chart;
//-(void)setIntroductionText:(NSString*)text useLabel : (UILabel *) label;
- (void)setLessonName:(NSString *)aName
      andSchool:(NSString *)aSchool
       andFocus:(NSString *)aFocus
         andImg:(NSString *)aImg
       andScore:(NSString *)aScore
   andBeginTime:(NSString *)aTime
        andHour:(NSString *)aHour
        andPrice:(NSString *)aPrice
 andActiveTitle:(NSString *)aTitle
  andIntroduce:(NSString *)aIntroduce
     andIsFocus:(BOOL)isFocus
       andChart:(NSArray *)aChart
             oldPrice:(NSString *)oldPrice;

@end
