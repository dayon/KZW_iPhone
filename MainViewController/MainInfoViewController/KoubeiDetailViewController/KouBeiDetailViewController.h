//
//  KouBeiDetailViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/29.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
@interface KouBeiDetailViewController : UIViewController
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) UIImageView * userPhoto;
@property (nonatomic, strong) UILabel * userName;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIScrollView * littleScroll;
@property (nonatomic, strong) UIImageView * scrollPhoto;
@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UILabel * chartLabel;
@property (nonatomic, strong) UILabel * totalMark;

@property (nonatomic, strong) NSMutableDictionary * mainDic;

@property (nonatomic, strong) NSString * LessonName;

@property (nonatomic, strong) UIView * backGroundView;
@property (nonatomic, strong) CWStarRateView * starView;
@property (nonatomic, strong)UILabel * scoreLabel;

@property (nonatomic, strong)ChartView * chart;
- (void) sendMarkWithArr : (NSMutableArray *) arr;
@end
