//
//  MyCustomTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MyCustomTableViewCell.h"
#define kCellHeight 40
@implementation MyCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return  self;
}



#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    NSArray * titleArr = @[@"课程名称", @"贷款状态", @"贷款金额", @"还款日期", @"本期本金", @"本期利息", @"本期金额"];
    for (int i = 0; i < 7; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20 * SCREEN_WIDTH / 320,10+ (i * kCellHeight) * SCREEN_HEIGHT / 568, 70 * SCREEN_WIDTH / 320, kCellHeight)];
        [label setText:[titleArr objectAtIndex:i]];
//        [label setBackgroundColor:[UIColor purpleColor]];
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:label];
        
        //seperator line
        if (i != 6){
        UILabel *line =[[UILabel alloc] initWithFrame:CGRectMake(20, label.frame.origin.y + label.frame.size.height, SCREEN_WIDTH - 40, 0.5)];
        [line setBackgroundColor:R_G_B_A_COLOR(221, 221, 221, 1)];
        [self.contentView addSubview:line];
        }
        
        self.daiKuanInfo = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width, 10+(i * kCellHeight) * SCREEN_HEIGHT / 568, SCREEN_WIDTH - label.frame.origin.x + label.frame.size.width+20, label.frame.size.height)];
        [self.daiKuanInfo setTag:i + 1];                 //daiKuanInfo的tag值为1~5
        [self.daiKuanInfo setText:@"北京新东方"];
        [self.daiKuanInfo setAdjustsFontSizeToFitWidth:YES];
        [self.daiKuanInfo setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:self.daiKuanInfo];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
