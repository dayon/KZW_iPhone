//
//  SettingViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (nonatomic, strong) UISwitch * pushNotification;
@property (nonatomic, strong) UISwitch * pictureSize;
@property (nonatomic, strong) UITableView * settingTable;
@end
