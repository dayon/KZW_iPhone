//
//  NickNameViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/1.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^nickNameBlock) (NSString * nickName);

@interface NickNameViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, copy) nickNameBlock nickNamel;
@property (nonatomic, strong) UITextField * nickNameText;
@end
