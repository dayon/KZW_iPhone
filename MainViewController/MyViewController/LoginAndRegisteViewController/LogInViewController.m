//
//  LogInViewController.m
//  KZW_iPhone
//
//  Created by 张宁浩 on 15/5/13.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import "LogInViewController.h"
#import "RegistViewController.h"
#import "AppDelegate.h"

#import "AppDelegate.h"

#define kWIDTH (262 * SCREEN_WIDTH / 320)
@interface LogInViewController ()<UITextFieldDelegate>

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"取消";
    self.navigationItem.backBarButtonItem = backItem;

    self.title = @"登录";
    
    [self createView];
}


#pragma mark -
#pragma mark创建视图
- (void) createView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    
    [self.view addSubview:bgView];
    
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(SCREEN_WIDTH -10-26, 25, 26, 26)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    
    
    NSLog(@"%f",kWIDTH);
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-262)/2, 76, 262, 40)];
    [self.userName setTextAlignment:NSTextAlignmentLeft];
    [self.userName setDelegate:self];
    [self.userName setBorderStyle:UITextBorderStyleRoundedRect];
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    imgv.frame = CGRectMake(0, 0, 23, 14);
    self.userName.leftView = imgv;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    [self.userName setPlaceholder:@"请输入手机号"];
    [self.userName setKeyboardType:UIKeyboardTypeNumberPad];
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.userName];
    
    
    self.passWord = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-262)/2, self.userName.frame.origin.y+50, 262, 40)];
    [self.passWord setTextAlignment:NSTextAlignmentLeft];
    [self.passWord setDelegate:self];
    [self.passWord setBorderStyle:UITextBorderStyleRoundedRect];
    UIImageView *imgv2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    imgv2.frame = CGRectMake(0, 0, 23, 14);
    self.passWord.leftView = imgv2;
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.passWord setPlaceholder:@"请输入用密码"];
    [self.passWord setSecureTextEntry:YES];
    [self.view addSubview:self.passWord];
    
    UIButton *tipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tipsButton.frame = CGRectMake(SCREEN_WIDTH-190, self.passWord.frame.origin.y + 50, 130, 30);
    tipsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tipsButton setTitle:@"没有帐号,点击注册" forState:UIControlStateNormal];
    [tipsButton setTitleColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1]  forState:UIControlStateNormal];
    [tipsButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tipsButton];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((SCREEN_WIDTH - 262)/2, 204+10, 262, 40)];
    [button setTitle:@"登 录" forState:UIControlStateNormal];
    [button.layer setBorderColor:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1].CGColor];
    [button.layer setBorderWidth:0.5];
    [button.layer setCornerRadius:20];
    button.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}






#pragma mark -
#pragma mark UItextFile协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 
#pragma mark 登陆/注册点击事件
- (void) buttonAction : (UIButton * )sender
{
        NSString *uName = self.userName.text;
        NSString *uPwd = self.passWord.text;
        
        if (uName.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"登录用户名不能为空." duration:1.0];
            return;
        }
        
        if (uPwd.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"登录密码不能为空." duration:1.0];
            return;
        }
        
        [self postUserInfo:uName andPwd:uPwd];
}
#pragma mark -
#pragma mark - RegisgerButton Action
- (void)registerAction:(UIButton *)sender{
    
    RegistViewController *regVc = [[RegistViewController alloc] init];
    [self presentViewController:regVc animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark 发送用户信息
- (void)postUserInfo:(NSString *)phone andPwd:(NSString *)pwd{
    //登录
    //http://123.56.156.37:8888/app/appuser/uinfo?em=15210096723&tp=get&pw=123456
    
    
    
    NSString *path = [API_VERIFYTEL_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"em",@"get",@"tp",[self md5:pwd],@"pw", nil];
    [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
        
        NSLog(@"登录 connect.......................%@",dic);
        if (dic != nil) {
            NSString *result = [dic objectForKey:@"code"];
//            NSLog(@"Login requestInfo =======%@",result);
            if ([result integerValue] == 0) {  //code = 0 成立
                NSString *loginCookie = [[dic objectForKey:@"data"] objectForKey:kCookieName];
                
                if (loginCookie.length>0) {
                    ((AppDelegate*)([UIApplication sharedApplication].delegate)).isLoginStatus = YES;
                    
                    [self saveNSUserDefaultsString:loginCookie forKey:@"kzuser"];
                    
                    NSLog(@"login success");
                    
//                    [self readNSUserDefaults];
                    
                    AppDelegate *app = [[UIApplication sharedApplication] delegate];
                    app.isLoginStatus = YES;
                    
                    
                    NSString *userId = [[dic objectForKey:@"data"] objectForKey:@"uid"];
                    NSString *userName = [[dic objectForKey:@"data"] objectForKey:@"username"];
                    NSString *userImg = [[dic objectForKey:@"data"] objectForKey:@"head_pic"];
                    NSString *userFocus = [[dic objectForKey:@"data"] objectForKey:@"course_focus"];
                    NSLog(@"我的关注<><><><><><><><><><><>：%@",userFocus);
                    

                    
                    [self saveNSUserDefaultsString:userName forKey:@"usrName"];
                    [self saveNSUserDefaultsString:userId forKey:@"usrId"];
                    [self saveNSUserDefaultsString:userImg forKey:@"usrImg"];
                    [self saveNSUserDefaultsString:userFocus forKey:@"usrFocus"];
                    
                    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    ap.userName = userName;
                    ap.userId = userId;
                    ap.userImg = userImg;
                    ap.userFocus = userFocus;
                    ap.kzuser = loginCookie;
                    
                    
                    NSDictionary *dictCookie = [NSDictionary dictionaryWithObjectsAndKeys:kCookieName,NSHTTPCookieName,
                                                loginCookie,NSHTTPCookieValue,
                                                @"/",NSHTTPCookiePath,
                                                @".kezhanwang.cn",NSHTTPCookieDomain,
                                                @"2016-12-12",NSHTTPCookieExpires,
                                                nil];
                    NSHTTPCookie *kzCookie = [NSHTTPCookie cookieWithProperties:dictCookie];
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:kzCookie];
                    
                    

                    [self.delegate LoginUserName:userName andUserId:userId andUserImg:userImg andUserFocus:userFocus];
                    

                    [self dismissViewControllerAnimated:YES completion:nil];

                    
//                    NSLog(@"readCookies success");
                }
                else {
                    
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"登录失败了" duration:1.0];
            }
        }
        
    } failuer:^(NSError *error) {
        
       
        
    }];

    
    
}



#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//#pragma mark -
//#pragma mark - NSUserDefaults
//- (void)readNSUserDefaults{
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *kzuser = [userDefaultes stringForKey:@"kzuser"];
//
//    
//    NSLog(@"######################################################");
//    
//    NSLog(@"NSUserDefaults Reading Data....kzuser=%@",kzuser);
//    
//    NSLog(@"######################################################");
//    
//}

- (void)saveNSUserDefaultsString:(NSString *)paraID forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:paraID forKey:key];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}

#pragma mark -
#pragma mark - md5 加密字符串
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}



@end
