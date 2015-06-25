//
//  DaiKuanTypeTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/4.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "DaiKuanTypeTableViewCell.h"

@implementation DaiKuanTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createPlaceholderView];
    }
    return self;
}


#pragma mark -
#pragma mark 创建占位图
- (void) createPlaceholderView
{
    self.placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 20, 130)];
    [self.placeHolder setBackgroundColor:[UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1]];
    [self.placeHolder setTextAlignment:NSTextAlignmentCenter];
    [self.placeHolder setText:@"未选择还款方式"];
    [self.placeHolder setFont:[UIFont boldSystemFontOfSize:25]];
    [self.placeHolder setClipsToBounds:YES];
    [self.placeHolder.layer setCornerRadius:10];
    [self.placeHolder setTextColor:[UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1]];
    [self.placeHolder.layer setBorderWidth:1];
    [self.placeHolder.layer setBorderColor:[UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1].CGColor];
    [self.contentView addSubview:self.placeHolder];
}


#pragma mark -
#pragma mark 创建视图1
- (void) createView
{
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 20, 130)];
    [backGround setImage:[UIImage imageNamed:@"LoanCellbg_double"]];
    [backGround setClipsToBounds:YES];
    [backGround.layer setCornerRadius:5];
    [self.contentView addSubview:backGround];
    
    for (int i = 0; i < 3; i++) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * backGround.frame.size.height / 3, backGround.frame.size.width / 2, backGround.frame.size.height / 3)];
        [self.titleLabel setText:@"总还款金额"];
        if (i == 0) {
            [self.titleLabel setText:@"前期还款额"];
        }
        if (i  == 1) {
            [self.titleLabel setText:@"后期还款额"];
        }
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setTag:i + 1];                 //tag值为 1~3
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [backGround addSubview:self.titleLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(backGround.frame.size.width / 2, i * backGround.frame.size.height / 3, backGround.frame.size.width / 2, backGround.frame.size.height / 3)];
        [self.priceLabel setTextColor:[UIColor redColor]];
        [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceLabel setTag:i + 10];                  //tag值为 10~12
        [backGround addSubview:self.priceLabel];
    }
}


#pragma mark -
#pragma mark 创建视图2
- (void) createViewSecond
{
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 20, 130)];
    [backGround setImage:[UIImage imageNamed:@"LoanCellbg"]];
    [backGround setClipsToBounds:YES];
    [backGround.layer setCornerRadius:5];
    [self.contentView addSubview:backGround];
    
    for (int i = 0; i < 2; i++) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * backGround.frame.size.height / 2, backGround.frame.size.width / 2, backGround.frame.size.height / 2)];
        [self.titleLabel setText:@"每月还款金额为"];
        if (i == 1) {
            [self.titleLabel setText:@"总还款金额为"];
        }
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [backGround addSubview:self.titleLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(backGround.frame.size.width / 2, i * backGround.frame.size.height / 2, backGround.frame.size.width / 2, backGround.frame.size.height / 2)];
        [self.priceLabel setTag:100 + i];                  //self.priceLabel的tag值为100 ~101
        [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceLabel setTextColor:[UIColor redColor]];
        [backGround addSubview:self.priceLabel];
    }
}


#pragma mark -
#pragma mark 贷款算法1
- (void) createTitleLabelWithRatetimex : (NSString *) ratetimex ratetimey : (NSString *) ratetimey moneyApply : (NSString *) moneyApply ratex : (NSString *) ratex ratey : (NSString *) ratey
{
    [self.placeHolder removeFromSuperview];
    [self createView];
    for (int i = 0 ; i < 3; i ++) {
        UILabel * title = (UILabel *)[self.contentView viewWithTag:i + 1];
        UILabel * price = (UILabel *)[self.contentView viewWithTag:i + 10];
        if (i == 0) {
            [title setText:[NSString stringWithFormat:@"前%@个月每个月还款", ratetimex]];
            [price setText:[NSString stringWithFormat:@"￥%.2f", [moneyApply floatValue] * [ratex floatValue]]];
        } if (i == 1) {
            [title setText:[NSString stringWithFormat:@"后%@个月每个月还款", ratetimey]];
            [price setText:[NSString stringWithFormat:@"￥%.2f", [moneyApply floatValue] * [ratey floatValue] + [[self notRounding:[moneyApply floatValue] / [ratetimey floatValue] afterPoint:2] floatValue] ]];
        } if (i == 2) {
            [price setText:[NSString stringWithFormat:@"￥%.2f", [moneyApply floatValue] * [ratex floatValue] * [ratetimex floatValue] + ([moneyApply floatValue] * [ratey floatValue] + [[self notRounding:[moneyApply floatValue] / [ratetimey floatValue] afterPoint:2] floatValue])  * [ratetimey floatValue]]];
        }
    }
}


#pragma mark -
#pragma mark 贷款算法2
- (void) createTitleLabelWithRatetimex : (NSString *) ratetimex moneyApply : (NSString *) moneyApply
{
    [self.placeHolder removeFromSuperview];
    [self createViewSecond];
    for ( int i = 0; i < 2; i++) {
        UILabel * price = (UILabel *)[self.contentView viewWithTag:100 + i];
        if (i == 0) {
            [price setText:[NSString stringWithFormat:@"￥%.2f", [[self notRounding:[moneyApply floatValue] / [ratetimex floatValue] afterPoint:2] floatValue]]];
        } else {
            [price setText:[NSString stringWithFormat:@"￥%.2f", [moneyApply floatValue]]] ;
        }
    }
}

#pragma mark -
#pragma mark 向上取整保留两位小数
-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

/*************************************************************************************************************************************************************************************************************/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
