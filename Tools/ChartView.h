//
//  ChartView.h
//  柱状图DEMO
//
//  Created by 张宁浩 on 15/6/9.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView
@property (nonatomic, strong)UIView * backView;
- (void) setWithArr:(NSArray *) arr;
@end
