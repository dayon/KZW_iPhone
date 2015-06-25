//
//  MyViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"

@interface MyViewController : UIViewController
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIImageView * userImagel;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userFocus;
@property (nonatomic, strong) UITableView * mainTable;


@property (nonatomic, strong) NSMutableArray *loanList;

@property (nonatomic, strong) UIView *focusView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *lblMsg;
@property (nonatomic, strong) UILabel *lblFocusCount;
@end
