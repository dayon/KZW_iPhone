//
//  DaiKuanTypeTableViewCell.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/4.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiKuanTypeTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * placeHolder;
- (void) createTitleLabelWithRatetimex : (NSString *) ratetimex ratetimey : (NSString *) ratetimey moneyApply : (NSString *) moneyApply ratex : (NSString *) ratex ratey : (NSString *) ratey;

- (void) createTitleLabelWithRatetimex : (NSString *) ratetimex moneyApply : (NSString *) moneyApply;
@end
