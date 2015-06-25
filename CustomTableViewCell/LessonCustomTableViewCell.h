//
//  LessonCustomTableViewCell.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonCustomTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * lessonImage;
@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UIImageView *focusImgView;
@property (nonatomic, strong) CWStarRateView * markStar;

@property (nonatomic, strong) NSString *img;
@property float score;
@end
