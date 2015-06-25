//
//  CustomButton.m
//  重定义button
//
//  Created by 张宁浩 on 15/6/8.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:20]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-15.0,
                                              -10,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleLabel setTextColor:[UIColor orangeColor]];
//    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(20.0,
                                              -image.size.width / 2,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
