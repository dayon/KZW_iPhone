//
//  MainInfoViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomButton;
@interface MainInfoViewController : UIViewController
@property (nonatomic, strong) UITableView * mainTable;

@property (nonatomic, assign) NSInteger lessonId;
@property (nonatomic, assign) NSInteger isFocus;

@property (nonatomic, strong) NSMutableDictionary * mainDic;
@property (nonatomic, strong) NSMutableArray * kouBeiArr;

@property (nonatomic, strong) CustomButton *bottomBtn;

@end
