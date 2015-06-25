//
//  MainInfoTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MainInfoTableViewCell.h"

@implementation MainInfoTableViewCell

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
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREEN_WIDTH - 10, 40 * SCREEN_HEIGHT / 568)];
    [self.titleLable setFont:[UIFont boldSystemFontOfSize:29.8]];
    [self.titleLable setTextAlignment:NSTextAlignmentCenter];
    [self.titleLable setText:@"课程名称"];
    [self.contentView addSubview:self.titleLable];
    
    self.schoolNameLable = [[UILabel alloc] initWithFrame:CGRectMake(5, self.titleLable.frame.size.height + 35, SCREEN_WIDTH, 20 * SCREEN_HEIGHT / 568)];
    [self.schoolNameLable setFont:[UIFont systemFontOfSize:17]];
    [self.schoolNameLable setTextColor:[UIColor grayColor]];
    [self.schoolNameLable setText:@"学校名称"];
    [self.contentView addSubview:self.schoolNameLable];
    
    
    UILabel * beginTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.schoolNameLable.frame.origin.x, self.schoolNameLable.frame.origin.y + 2 * self.schoolNameLable.frame.size.height, (SCREEN_WIDTH - 10) / 4, self.schoolNameLable.frame.size.height * 1.5)];
    [beginTitle setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [beginTitle setTextColor:[UIColor colorWithRed:164 / 255.0 green:164 / 255.0 blue:164 / 255.0 alpha:1]];
    [beginTitle setFont:[UIFont systemFontOfSize:18]];
    [beginTitle setText:@"开课时间"];
    [self.contentView addSubview:beginTitle];
    
    self.bgTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(beginTitle.frame.origin.x + beginTitle.frame.size.width - 1, beginTitle.frame.origin.y, (SCREEN_WIDTH - 10) / 4 * 3, beginTitle.frame.size.height)];
    [self.bgTimeLable setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [self.bgTimeLable setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:self.bgTimeLable];
    
    UILabel * cTime = [[UILabel alloc] initWithFrame:CGRectMake(beginTitle.frame.origin.x, beginTitle.frame.origin.y + beginTitle.frame.size.height - 1, (SCREEN_WIDTH - 10) / 4, beginTitle.frame.size.height)];
    [cTime setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [cTime setTextColor:[UIColor colorWithRed:164 / 255.0 green:164 / 255.0 blue:164 / 255.0 alpha:1]];
    [cTime setFont:[UIFont systemFontOfSize:18]];
    [cTime setText:@"课程时间"];
    [self.contentView addSubview:cTime];
    
    self.hourLable = [[UILabel alloc] initWithFrame:CGRectMake(cTime.frame.origin.x + cTime.frame.size.width - 1, cTime.frame.origin.y, (SCREEN_WIDTH - 10) / 4 * 3, cTime.frame.size.height)];
    [self.hourLable setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [self.hourLable setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:self.hourLable];
    
    UILabel * cPrice = [[UILabel alloc] initWithFrame:CGRectMake(cTime.frame.origin.x, cTime.frame.origin.y + cTime.frame.size.height - 1, (SCREEN_WIDTH - 10) / 4, cTime.frame.size.height)];
    [cPrice setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [cPrice setTextColor:[UIColor colorWithRed:164 / 255.0 green:164 / 255.0 blue:164 / 255.0 alpha:1]];
    [cPrice setFont:[UIFont systemFontOfSize:18]];
    [cPrice setText:@"课程价格"];
    [self.contentView addSubview:cPrice];
    
    self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(cPrice.frame.origin.x + cPrice.frame.size.width - 1, cPrice.frame.origin.y, (SCREEN_WIDTH - 10) / 3, cPrice.frame.size.height)];
    [self.priceLable setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [self.priceLable setFont:[UIFont systemFontOfSize:20]];
    [self.priceLable setTextColor:[UIColor colorWithRed:254 / 255.0 green:59 / 255.0 blue:0 alpha:1]];
    [self.contentView addSubview:self.priceLable];
    
    UILabel * oPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLable.frame.origin.x + self.priceLable.frame.size.width - 1, self.priceLable.frame.origin.y, ((SCREEN_WIDTH - 10) - self.priceLable.frame.size.width - cPrice.frame.size.width) / 3, cPrice.frame.size.height)];
    [oPrice setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [oPrice setTextColor:[UIColor colorWithRed:164 / 255.0 green:164 / 255.0 blue:164 / 255.0 alpha:1]];
    [oPrice setFont:[UIFont systemFontOfSize:18]];
    [oPrice setText:@"原价"];
    [self.contentView addSubview:oPrice];
    
    self.oldPrice = [[UILabel alloc] initWithFrame:CGRectMake(oPrice.frame.origin.x + oPrice.frame.size.width - 1, oPrice.frame.origin.y, oPrice.frame.size.width * 2 + 2, oPrice.frame.size.height)];
    [self.oldPrice setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [self.oldPrice setAdjustsFontSizeToFitWidth:YES];
    [self.oldPrice setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:self.oldPrice];
    
    UILabel * breakView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.oldPrice.frame.size.width, 1)];
    [breakView setCenter:self.oldPrice.center];
    [breakView setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:breakView];
    
    self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cPrice.frame.origin.x, 20 + cPrice.frame.origin.y +  cPrice.frame.size.height, SCREEN_WIDTH - 10, 200)];
    [self.firstImageView setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.firstImageView];
    
    self.introduceView = [[UIWebView alloc] initWithFrame:CGRectMake(self.firstImageView.frame.origin.x, 20 + self.firstImageView.frame.size.height + self.firstImageView.frame.origin.y, self.firstImageView.frame.size.width, 300)];
    [self.introduceView setBackgroundColor:[UIColor colorWithRed:arc4random() % 10 green:arc4random() % 10 blue:arc4random() % 10 alpha:1]];
    [self.introduceView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.introduceView];
  
    
    UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.introduceView.frame.origin.x, self.introduceView.frame.origin.y + self.introduceView.frame.size.height + 20, self.introduceView.frame.size.width, 20)];
    [scoreLabel setText:@"评测评分"];
    [scoreLabel setTextColor:[UIColor grayColor]];
    [scoreLabel setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:scoreLabel];
    
    self.starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(scoreLabel.frame.size.width / 2, 0, scoreLabel.frame.size.width / 3, scoreLabel.frame.size.height) numberOfStars:5];
    [scoreLabel addSubview:self.starView];

    self.totalScore = [[UILabel alloc] initWithFrame:CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width, self.starView.frame.origin.y, scoreLabel.frame.size.width - self.starView.frame.size.width - self.starView.frame.origin.x, 20)];
    [self.totalScore setFont:[UIFont boldSystemFontOfSize:20]];
    [self.totalScore setTextColor:[UIColor colorWithRed:253 / 255.0 green:186 / 255.0 blue:45 / 255.0 alpha:1]];
    [scoreLabel addSubview:self.totalScore];
    
    
    
    for (int i = 0; i < 5; i ++) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.frame.origin.x + (SCREEN_WIDTH - self.titleLable.frame.origin.x * 2) / 5 * i, scoreLabel.frame.origin.y + scoreLabel.frame.size.height + 200, (SCREEN_WIDTH - self.titleLable.frame.origin.x * 2) / 5, 20)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTag:i + 10];     //tag值为10~14
        [titleLabel setText:@"暂无"];
        [self.contentView addSubview:titleLabel];
        
    }
    if (SCREEN_HEIGHT == 480) {
        self.chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 380, SCREEN_WIDTH, 190)];
    } else if (SCREEN_HEIGHT == 736) {
        self.chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 425, SCREEN_WIDTH, 170)];
    } else if (SCREEN_HEIGHT == 568) {
        self.chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 170)];
    } else {
        self.chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 355 * SCREEN_HEIGHT / 568, SCREEN_WIDTH, 170)];
    }
    [self.contentView addSubview:self.chart];
}


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
             oldPrice:(NSString *)oldPrice{
    
    NSMutableArray * scoreArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [aChart count]; i ++) {
        UILabel * title = (UILabel *)[self.contentView viewWithTag:i + 10];
        [title setText:[[aChart objectAtIndex:i] objectForKey:@"name"]];
        
        
        [scoreArr addObject:[[aChart objectAtIndex:i] objectForKey:@"score"]];
    }
    [self.chart setWithArr:scoreArr];
    
    
    
    
    self.titleLable.text = aName;
    self.schoolNameLable.text = [NSString stringWithFormat:@"%@      %@人关注", aSchool, aFocus];
    [self.starView setScorePercent:[aScore floatValue] / 5];
    [self.firstImageView setImageWithURL:[NSURL URLWithString:aImg]];
    self.bgTimeLable.text = aTime;
    self.hourLable.text = [NSString stringWithFormat:@"%@ 课时", aHour];
    [self.priceLable setText:[NSString stringWithFormat:@"￥%@", aPrice]];
    NSLog(@"网址是   ===========  %@", aIntroduce);
    

    [self.introduceView loadHTMLString:[NSString stringWithFormat:@"%@", aIntroduce] baseURL:nil];
    [self.oldPrice setText:[NSString stringWithFormat:@"￥%@", oldPrice]];
    [self.totalScore setText:[NSString stringWithFormat:@"%@分", aScore]];

}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
