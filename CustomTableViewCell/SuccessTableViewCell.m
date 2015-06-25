//
//  SuccessTableViewCell.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/10.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "SuccessTableViewCell.h"

@implementation SuccessTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apply_success_pic"]];
        [image setBackgroundColor:[UIColor grayColor]];
        [image setFrame:CGRectMake(SCREEN_WIDTH / 6, 0, SCREEN_WIDTH / 3 * 2, 125)];
        [self.contentView addSubview:image];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, image.frame.size.height + 20, SCREEN_WIDTH, 30)];
        [titleLabel setText:@"恭喜您成功申请贷款！请等待工作人员联系你"];
        [titleLabel setTextColor:[UIColor redColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:titleLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
