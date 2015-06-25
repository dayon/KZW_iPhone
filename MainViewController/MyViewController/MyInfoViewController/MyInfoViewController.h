//
//  MyInfoViewController.h
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/30.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView * mainTable;
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) UITextField * nickNameOrSex;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UIPickerView * sexPicker;
@property (nonatomic, strong) UIView * pickerViewBackGround;

@property (nonatomic, strong) NSData * imageData;
@property (nonatomic, strong) NSString *userPic;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSArray *userInfo;

@end
