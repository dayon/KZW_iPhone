//
//  BaoMingViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/1.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
@interface BaoMingViewController : UIViewController
@property (nonatomic, strong) UITextField * infoText;
@property (nonatomic, strong) UIButton *verifyBtn;
@property (nonatomic, assign) NSInteger lessonId;

@property (nonatomic, strong) UITableView *myTableView;
@end
