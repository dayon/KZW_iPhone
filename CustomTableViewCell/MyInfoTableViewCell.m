//
//  MyInfoTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/30.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@implementation MyInfoTableViewCell

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
    self.userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 7 * 6 - 50, 10, SCREEN_WIDTH / 7, SCREEN_WIDTH / 7)];
    [self.userPhoto setBackgroundColor:[UIColor grayColor]];
    [self.userPhoto setClipsToBounds:YES];
    [self.userPhoto .layer setCornerRadius:10];
    [self.contentView addSubview:self.userPhoto];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
