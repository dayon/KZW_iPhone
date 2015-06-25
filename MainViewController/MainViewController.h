//
//  MainViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#import "SiftViewController.h"
//#import "EGORefreshTableHeaderView.h"
#import "Tool.h"

@interface MainViewController : UIViewController
@property (nonatomic, strong) UISearchBar * mainSearchBar;
@property (nonatomic, strong) UITableView * mainTable;
@property (nonatomic, strong)  NSMutableArray *lessonList;
@property (nonatomic, strong) NSString *orderBy;
@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) NSMutableDictionary *cookies;

@property (nonatomic, assign) NSInteger areaID;
@property (nonatomic, assign) NSInteger cate1ID;
@property (nonatomic, assign) NSInteger cate2ID;
@property (nonatomic, assign) BOOL isNotFilter;

@property (nonatomic, strong) UIButton *focusBtn;
@property (nonatomic, strong) UIButton *scoreBtn;
@property (nonatomic, strong) UIButton * leftButton;


@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *times;

@property (nonatomic, strong) Lesson *myLesson;



@property (nonatomic, strong) SiftViewController * siftVC;
@property (nonatomic, strong) UIViewController * tempVC;

//搜索条件
@property (nonatomic, strong) NSString *searchKeyWord;
@end
