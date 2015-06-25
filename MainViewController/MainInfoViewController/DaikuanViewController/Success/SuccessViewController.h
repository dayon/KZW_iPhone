//
//  SuccessViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/10.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * mainTable;
@property (nonatomic, strong) NSString * lessonName;
@property (nonatomic, strong) NSString * schoolName;
@property (nonatomic, strong) NSString * schoolAddress;
@property (nonatomic, strong) NSString * hour;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * daiKuanFenQi;

@property (nonatomic, strong) UIViewController * lessonInfo;
@end
