//
//  NickNameViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/1.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    [self setTitle:@"修改昵称"];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self createView];
}

#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 
#pragma mark 创建视图
- (void) createView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    [self.view addSubview:bgView];
    
    self.nickNameText = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 262)/2, 20, 262, 40)];
    [self.nickNameText setBorderStyle:UITextBorderStyleRoundedRect];
    [self.nickNameText setDelegate:self];
    self.nickNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nickNameText];
    
    //保存昵称
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((SCREEN_WIDTH - 262)/2, self.nickNameText.frame.origin.y +  self.nickNameText.frame.size.height + 20, self.nickNameText.frame.size.width, 40)];
    [button setTitle:@"保存昵称" forState:UIControlStateNormal];
    [button.layer setBorderColor:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1].CGColor];
    [button.layer setBorderWidth:0.5];
    [button.layer setCornerRadius:20];
    button.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


#pragma mark -
#pragma mark 保存按钮点击事件
- (void) saveAction : (UIButton * ) sender
{
    if (self.nickNameText.text.length < 2|| self.nickNameText.text.length > 10) {
        [SVProgressHUD showErrorWithStatus:@"昵称长度要求4-20个字符" duration:1.0];
        return;
    }
    
    [self isVerifyNickName:self.nickNameText.text];


    

}
- (void)isVerifyNickName:(NSString *)name{
    //API_VERIFYTEL_URL
    NSString *path = [[NSString stringWithFormat:@"%@?name=%@&tp=ckna",API_VERIFYTEL_URL,name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Connect connectPOSTWithURL:path parames:nil connectBlock:^(NSMutableDictionary *dic) {
        if (dic != nil) {
            NSLog(@"verify nickname dictionary:%@",dic);
            //返回结果code=0为正常，code=1 数据为空，或者异常 ，正常情况下result=-1可注册，result=1表示重复，result=2表示格式错误

            if ([[[dic objectForKey:@"data"] objectForKey:@"result"] integerValue] < 0) {
                //修改成功
                [self saveNickName:self.nickNameText.text];
                
                
            }else if ([[[dic objectForKey:@"data"] objectForKey:@"result"] integerValue] == 1){
                [SVProgressHUD showSuccessWithStatus:@"您要修改的昵称已存在" duration:1.0f];
                return ;
            }else if ([[[dic objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2){
                [SVProgressHUD showErrorWithStatus:@"昵称要求长度4-20个字符" duration:1.0];
                return;
            }
        }
    } failuer:^(NSError *error) {
        NSLog(@"user nick verify error:%@",error);
    }];
    
}



- (void)saveNickName:(NSString *)nickName{
    
    NSString *url = [NSString stringWithFormat:@"%@?name=%@",API_USERINFO_MODIFY,nickName];
    NSString *path = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [Connect connectPOSTWithURL:path parames:nil connectBlock:^(NSMutableDictionary *dic) {
//        NSLog(@"user infomation modify ====%@",dic);//返回code = 5 是未登录，结果code=0为正常，code=3 参数为空， code=0时，result=1表示更新成功，result=0未更新
        if (dic != nil) {
            if ([[dic objectForKey:@"code"] integerValue] == 0) {
            AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ap.userName = nickName;
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:nickName forKey:@"usrName"];
            [ud synchronize];
            
            self.nickNamel(self.nickNameText.text);
            [self.nickNameText resignFirstResponder];
            
            [SVProgressHUD showSuccessWithStatus:@"昵称修改成功" duration:1.0f];
            
            [self.navigationController popViewControllerAnimated:YES];
//            NSLog(@"user infomation has modified.");
            }
        }
        
    } failuer:^(NSError *error) {
        
        NSLog(@"user infomation has modified.%@",error);
        
    }];
    

    
}
@end
