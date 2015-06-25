//
//  DaikuanViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/4.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Submitinfo.h"
@interface DaikuanViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableDictionary * receiveDic;

@property (nonatomic, strong) UITableView * mainTable;

@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * pictureCellTitlel;
@property (nonatomic, strong) NSArray * placeHolderArr;

@property (nonatomic, strong) NSArray * backStyle;
@property (nonatomic, strong) NSArray * bankArr;
@property (nonatomic, strong) NSArray * workStyle;
@property (nonatomic, strong) NSArray * relation;

@property (nonatomic, strong) NSMutableArray * choiceArr;

@property (nonatomic, strong) UITextField * tempTextField;

@property (nonatomic, strong) UIView * pickerViewBackGround;

@property (nonatomic, strong) UIPickerView * infoPicker;
@property (nonatomic, strong) UIActionSheet * actionSheet;
@property (nonatomic, strong) UIImagePickerController * imagePicker;

@property (nonatomic, strong) Submitinfo * submit;
@property (nonatomic, strong) UIImageView * tempImage;

@property (nonatomic, strong) NSMutableDictionary * typeDic;

@property (nonatomic, assign) NSInteger lessonID;

@property (nonatomic, strong) UITextField * huanKuanDate;


@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * school;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * hour;
@property (nonatomic, strong) NSString * price;

@property (nonatomic, strong) UIViewController * sendVC;

@end
