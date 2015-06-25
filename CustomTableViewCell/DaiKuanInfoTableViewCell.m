//
//  DaiKuanInfoTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/4.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "DaiKuanInfoTableViewCell.h"

@implementation DaiKuanInfoTableViewCell

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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH / 7 * 2, 60)];
    [self.titleLabel setText:@"我是空白"];
    [self.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.titleLabel];
    
    self.infoText = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.frame.size.width + SCREEN_WIDTH / 50, self.titleLabel.frame.origin.y, SCREEN_WIDTH / 3 * 2, self.titleLabel.frame.size.height)];
    [self.infoText setTextAlignment:NSTextAlignmentCenter];
    [self.infoText setAdjustsFontSizeToFitWidth:YES];
    [self.infoText setPlaceholder:@"请输入贷款额度￥"];
    [self.contentView addSubview:self.infoText];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
