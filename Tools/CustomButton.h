//
//  CustomButton.h
//  重定义button
//
//  Created by 张宁浩 on 15/6/8.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
