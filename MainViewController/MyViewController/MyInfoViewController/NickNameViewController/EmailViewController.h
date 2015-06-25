//
//  EmailViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/16.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^emailBlock) (NSString * email);
@interface EmailViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * emailText;
@property (nonatomic, copy) emailBlock email;

@end
