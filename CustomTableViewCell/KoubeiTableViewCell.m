//
//  KoubeiTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/29.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "KoubeiTableViewCell.h"

@implementation KoubeiTableViewCell

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
    self.userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(5 * SCREEN_HEIGHT / 568, 5 * SCREEN_HEIGHT / 568, 70 * SCREEN_WIDTH / 320, 70 * SCREEN_WIDTH / 320)];
    [self.userPhoto setBackgroundColor:[UIColor grayColor]];
    [self.userPhoto setClipsToBounds:YES];
    [self.userPhoto.layer setCornerRadius:self.userPhoto.frame.size.width / 2];
    [self.contentView addSubview:self.userPhoto];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userPhoto.frame.size.width + 5, self.userPhoto.frame.origin.y, SCREEN_WIDTH / 4, self.userPhoto.frame.size.height / 7 * 2)];
    [self.userName setTextAlignment:NSTextAlignmentCenter];
    [self.userName setTextColor:[UIColor colorWithRed:0 green:103 / 255.0 blue:191 / 255.0 alpha:1]];
    [self.userName setFont:[UIFont systemFontOfSize:21]];
    [self.userName setAdjustsFontSizeToFitWidth:YES];
    [self.contentView addSubview:self.userName];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userPhoto.frame.size.width + 5 + SCREEN_WIDTH / 2, self.userPhoto.frame.origin.y, SCREEN_WIDTH / 4, self.userPhoto.frame.size.height / 7 * 2)];
    [self.timeLabel setAdjustsFontSizeToFitWidth:YES];
    [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.timeLabel setTextColor:[UIColor lightGrayColor]];
    [self.infoLabel setFont:[UIFont systemFontOfSize:10]];
    [self.contentView addSubview:self.timeLabel];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userName.frame.origin.x + 5, self.userName.frame.origin.y + self.userName.frame.size.height, (SCREEN_WIDTH - self.userName.frame.origin.x) * 0.9 - 10, self.userPhoto.frame.size.height * 1.1)];
    [self.infoLabel setText:[NSString stringWithFormat:@"如果你还不能清晰的表达你想要的东西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够西那么真么你还不够了解他  ------阿尔伯特·爱因斯坦"]];
    [self.infoLabel setNumberOfLines:3];
    [self.infoLabel setFont:[UIFont systemFontOfSize:18]];
    [self.infoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.infoLabel];
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
