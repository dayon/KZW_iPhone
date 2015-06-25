//
//  RegistViewController.h
//  KZW_iPhone
//
//  Created by 张宁浩 on 15/5/13.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface RegistViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * userInfo;
@property (nonatomic, strong) UIButton *verifyBtn;
@end
