//
//  ChartView.m
//  柱状图DEMO
//
//  Created by 张宁浩 on 15/6/9.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "ChartView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@implementation ChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, frame.size.height, SCREEN_WIDTH)];
        self.backView.center = self.center;
        [self addSubview:self.backView];
        
        for (int i = 0; i < 5; i ++) {
            UILabel * chartLabel = [[UILabel alloc] init];
            if (i == 0) {
                [chartLabel setBackgroundColor:[UIColor colorWithRed:24 / 255.0 green:144 / 255.0 blue:196 / 255.0 alpha:1]];
            } else if (i == 1) {
                [chartLabel setBackgroundColor:[UIColor colorWithRed:147 / 255.0 green:184 / 255.0 blue:56 / 255.0 alpha:1]];
            } else if (i == 2) {
                [chartLabel setBackgroundColor:[UIColor colorWithRed:105 / 255.0 green:177 / 255.0 blue:220 / 255.0 alpha:1]];
            } else if (i == 3) {
                [chartLabel setBackgroundColor:[UIColor colorWithRed:87 / 255.0 green:149 / 255.0 blue:56 / 255.0 alpha:1]];
            } else if (i == 4) {
                [chartLabel setBackgroundColor:[UIColor colorWithRed:21 / 255.0 green:126 / 255.0 blue:197 / 255.0 alpha:1]];
            }
            
            [chartLabel setTag:i + 100];     ///tag值为100~104
            [chartLabel setClipsToBounds:YES];
            [chartLabel.layer setCornerRadius:12 * SCREEN_HEIGHT / 568];
            [self.backView addSubview:chartLabel];
            
        }
    }
    return self;
}
- (void) setWithArr:(NSArray *) arr
{
    for (int i =0 ; i < [arr count]; i++) {
        UILabel * chart = (UILabel*)[self viewWithTag:i + 100];
        if (SCREEN_HEIGHT == 480) {
            [chart setFrame:CGRectMake(0, 40 * SCREEN_HEIGHT / 568 + i * (70  * SCREEN_HEIGHT / 568), self.backView.frame.size.width * ([[arr objectAtIndex:i] floatValue] / 5)  , 20 * SCREEN_HEIGHT / 568)];
            
        } else {
            [chart setFrame:CGRectMake(0, 30 * SCREEN_HEIGHT / 568 + i * (60  * SCREEN_HEIGHT / 568), self.backView.frame.size.width * ([[arr objectAtIndex:i] floatValue] / 5) , 20 * SCREEN_HEIGHT / 568)];
        }
    }
    [self.backView setTransform:CGAffineTransformRotate(self.backView.transform, -M_PI_2)];
}
@end
