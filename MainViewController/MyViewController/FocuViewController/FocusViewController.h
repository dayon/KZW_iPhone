//
//  FocusViewController.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/30.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *lessonList;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSString *orderBy;
@end
