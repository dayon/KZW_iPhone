//
//  LessonCustomTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "LessonCustomTableViewCell.h"

@implementation LessonCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    self.lessonImage = [[UIImageView alloc] initWithFrame:CGRectMake(5 * SCREEN_WIDTH / 320, 5 * SCREEN_WIDTH / 320, 130 * SCREEN_WIDTH / 320, 80 * SCREEN_WIDTH / 320)];
    [self.lessonImage setBackgroundColor:[UIColor grayColor]];
    [self.lessonImage setClipsToBounds:YES];
    [self.lessonImage.layer setCornerRadius:4];
    [self.contentView addSubview:self.lessonImage];
    
    for (int i = 0; i < 6; i++) {
        CGRect rect;
        switch (i) {
            case 0:
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 10, i * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y, SCREEN_WIDTH - _lessonImage.frame.origin.x - self.lessonImage.frame.size.width - 10, self.lessonImage.frame.size.height / 3);
                
                break;
            case 1://评分
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 10, i * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y, 100, self.lessonImage.frame.size.height / 3);
                
                break;
            case 2://评分值
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 10 + 110 , (i-1) * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y, 60, self.lessonImage.frame.size.height / 3);
                
                break;
            case 3://关注图片
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 10  , 2 * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y +14 - 8, 16, 16);
                self.focusImgView = [[UIImageView alloc] initWithFrame:rect];
//                self.focusImgView.image = [UIImage imageNamed:@"fav_small_after"];
                [self.focusImgView setTag:i + 1];
                [self.contentView addSubview:self.focusImgView];
                break;
            case 4://关注值
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 10 + 20 , (i-2) * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y, 40, self.lessonImage.frame.size.height / 3);
                
                break;
            case 5://学校
                rect = CGRectMake(_lessonImage.frame.origin.x + _lessonImage.frame.size.width + 30  + 40 , (i-3) * (_lessonImage.frame.size.height / 3) + _lessonImage.frame.origin.y, SCREEN_WIDTH - _lessonImage.frame.origin.x - self.lessonImage.frame.size.width - 16 - 40, self.lessonImage.frame.size.height / 3);
                
                break;

        }
        if (i!=3) {
            self.infoLabel = [[UILabel alloc] initWithFrame:rect];

            [self.infoLabel setTag:i + 1];                 //infoLabel的tag值为1~4
            [self.infoLabel setAdjustsFontSizeToFitWidth:YES];
            [self.infoLabel setFont:[UIFont systemFontOfSize:15]];
            [self.contentView addSubview:self.infoLabel];
            
        }

    }
    
    
    UILabel * label = (UILabel *)[self.contentView viewWithTag:2];
    self.markStar = [[CWStarRateView alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, 100, label.frame.size.height) numberOfStars:5];
    [self.markStar setAllowIncompleteStar:YES];
    self.markStar.scorePercent = 0.8;
    [self.markStar setUserInteractionEnabled:NO];
    [self.contentView addSubview:self.markStar];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
