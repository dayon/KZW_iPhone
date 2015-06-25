//
//  SiftViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LessonCategory;
@protocol FilterLessonDelegate;

@interface SiftViewController : UIViewController
@property (nonatomic, strong) UITableView * leftTable;
@property (nonatomic, strong) UITableView * rightTable;
@property (nonatomic, strong) UIBarButtonItem * rightButton;
@property (nonatomic, strong) UIView * pickerViewBackGround;
@property (nonatomic, strong) UIPickerView * locatePicker;
@property (nonatomic, strong) NSMutableArray * areaList;


@property (nonatomic, strong) NSMutableDictionary *JSON;
@property (nonatomic, strong) NSMutableArray *categoryList; //一级大类
@property (nonatomic, strong) NSMutableArray *childList;    //二级分类


@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger childId;
@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, strong) NSString *areaName;


@property (nonatomic, strong) UIView * tableViewSelectView;

@property (nonatomic, assign) id <FilterLessonDelegate> delegate;

//@property (nonatomic, strong) LessonCategory *myCate;
//@property (nonatomic, strong) LessonCategory *myChild;
//@property (nonatomic, strong) LessonCategory *myArea;

@property (nonatomic, strong) NSMutableArray *childArray;

@property (nonatomic, strong) UIButton * right;
@property (nonatomic, strong) NSMutableArray * temp;
@property (nonatomic, strong) NSMutableArray * idArr;
@property (nonatomic, strong) NSMutableArray * childArr;

@end

@protocol FilterLessonDelegate <NSObject>

- (void) filterLessonWithCategory:(BOOL)isNotFilter andCategory:(NSInteger)cateId andChild:(NSInteger)childId andArea:(NSInteger)cityId;

@end
