//
//  LogInViewController.h
//  KZW_iPhone
//
//  Created by 张宁浩 on 15/5/13.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate;

@interface LogInViewController : UIViewController
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *passWord;
@property (nonatomic, assign) id<LoginDelegate> delegate;

@end


@protocol LoginDelegate <NSObject>

- (void)LoginUserName:(NSString *)usrName andUserId:(NSString *)usrId andUserImg:(NSString *)usrImg andUserFocus:(NSString *)usrFocus;

@end