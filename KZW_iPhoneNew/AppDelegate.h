//
//  AppDelegate.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) BOOL isLoginStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userImg;
@property (strong, nonatomic) NSString *userFocus;
@property (strong, nonatomic) NSString *kzuser;
@property (assign, nonatomic) BOOL isAPNs;

@property (assign, nonatomic) BOOL is3GBrowse;
@property (nonatomic, strong) NSMutableArray *addressBookList;





@property (nonatomic, strong) UINavigationController * rootNAV;



@end

