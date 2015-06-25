//
//  RegistViewController.m
//  KZW_iPhone
//
//  Created by 张宁浩 on 15/5/13.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import "RegistViewController.h"
#import "AppDelegate.h"


@interface RegistViewController ()
{
    int seconds;
    BOOL _isExist;
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    self.title = @"注册";
    [self createView];
    
    seconds = 60;
    _isExist = NO;
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) createView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    [self.view addSubview:bgView];
    

    NSArray * userInfoPlaceholder = @[@"请输入手机号", @"请输入验证码", @"请输入您的密码", @"请再次输入您的密码"];
    NSArray *arrImg = @[@"login_user",@"login_password",@"login_password",@"login_password"];
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(SCREEN_WIDTH -10-26, 25, 26, 26)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    
    for (int i = 0; i < 4; i ++) {

        if (i == 0) {
            
            self.userInfo = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-262)/2, 24 + (40+i*60), 160, 40)];
        }else{
            self.userInfo = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-262)/2, 24 + (40+i*60), 262, 40)];
        }
        UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:arrImg[i]]];
        imgv.frame = CGRectMake(0, 64, 23, 14);
        self.userInfo.leftView = imgv;
        self.userInfo.leftViewMode = UITextFieldViewModeAlways;
        [self.userInfo  setPlaceholder:[userInfoPlaceholder objectAtIndex:i]];
        [self.userInfo setDelegate:self];
        [self.userInfo setTag:i + 1];                           //UITextField的tag值为1~4
        [self.userInfo setBorderStyle:UITextBorderStyleRoundedRect];
        if (i==0) {
//            self.userInfo.text = @"13161607266";
            [self.userInfo setKeyboardType:UIKeyboardTypePhonePad];
        }else if (i == 2 || i==3){
            [self.userInfo setSecureTextEntry:YES];
        }
        self.userInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:self.userInfo];
    }
    
    UIButton * verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyButton setFrame:CGRectMake(self.userInfo.frame.origin.x + 160 + 10, 109-40, 90, 30 )];
    verifyButton.tag = 131;

    [verifyButton setBackgroundImage:[UIImage imageNamed:@"getword_nor"] forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.verifyBtn = verifyButton;
    [self.view addSubview:self.verifyBtn];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((SCREEN_WIDTH - 262)/2, SCREEN_HEIGHT - 64 - 40 - 20, 262, 40)];
    [button setTitle:@"注 册" forState:UIControlStateNormal];
    [button.layer setBorderColor:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1].CGColor];
    [button.layer setBorderWidth:0.5];
    [button.layer setCornerRadius:20];
    button.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
    [button addTarget:self action:@selector(registerUserAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
#pragma mark -
#pragma mark 注册按钮点击事件
- (void)registerUserAction:(UIButton * )sender
{
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtChkCode = (UITextField *)[self.view viewWithTag:2];
    UITextField *txtPwd = (UITextField *)[self.view viewWithTag:3];
    UITextField *txtPwd2 = (UITextField *)[self.view viewWithTag:4];
    
    NSString *phone = txtPhone.text;
    NSString *chkCode = txtChkCode.text;
    NSString *pwd = txtPwd.text;
    NSString *pwd2 = txtPwd2.text;
    
    if (![self isValidateMobile:phone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:1.0];
        return;
    }
    if (chkCode.length<4) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入不正确." duration:1.0];
        return;
    }
    if (pwd.length< 6) {
        [SVProgressHUD showErrorWithStatus:@"密码长度不能少于6个字符." duration:1.0];
        return;
    }
    
    if (![pwd2 isEqualToString:txtPwd.text]) {
        [SVProgressHUD showErrorWithStatus:@"确认密码与密码不一致." duration:1.0];
        return;
    }
    //校验验证码并保存用户注册信息
    [self isValidateChkCode:chkCode andPhone:phone];
    
    
    
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


#pragma mark -
#pragma mark - 校验验证码
/*
 * http://123.56.156.37:8888/app/appuser/code?tp=ckco&tel=15210096742&co=3076
 * 返回结果code=0为正常，code=1 数据为空，或者异常，正常情况下result=0验证码可用
 */

- (void)isValidateChkCode:(NSString *)code andPhone:(NSString *)phone{
    
    NSString *path = [API_SENDSMS_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"ckco",@"tp",phone,@"tel",code,@"co", nil];
    [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"isValidateChkCode======%@",dic);
        NSString *result = [[dic objectForKey:@"data"] objectForKey:@"result"]; //result=0验证码可用
        NSLog(@"isOK........%@",result);
        if ([result integerValue] == 0 ) {
            //写入数据库
            [self postUserInfo];
            return;
        }
        else if ([result integerValue] == 1 ) {
            [SVProgressHUD showErrorWithStatus:@"验证码不正确." duration:1.0];
            UITextField *txtChkCode = (UITextField *)[self.view viewWithTag:2];
            [txtChkCode setText:@""];
            return ;
        }else{
            return;
        }
    } failuer:^(NSError *error) {
        NSLog(@"%@",error);
        return ;
    }];
    
}

#pragma mark -
#pragma mark - 提交用户注册信息
- (void)postUserInfo{
    
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtChkCode = (UITextField *)[self.view viewWithTag:2];
    UITextField *txtPwd = (UITextField *)[self.view viewWithTag:3];
    
    NSString *uPhone = txtPhone.text;
    NSString *chkCode = txtChkCode.text;
    NSString *uPwd = txtPwd.text;

    
    if (![self isValidateMobile:uPhone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:2.0];
        return;
    }
    //密码加密处理
    uPwd = [self md5:uPwd];
    
    //3.注册  参数是pw:密码  tel：手机号
    //http://123.56.156.37:8888/app/appuser/Register?pw=123456&tel=15210096731&co=8888
    
    NSString *path = [API_REGISTER_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:uPhone,@"tel",uPwd,@"pw",chkCode,@"co",@"1",@"source", nil];
    NSLog(@"post para:%@",dict);
    [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
        
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result"] intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您已经注册成功." duration:1.0];
            [self dismissViewControllerAnimated:YES completion:nil];
         }
        
    } failuer:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}



#pragma mark -
#pragma mark - 正则手机号码验证
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark -
#pragma mark - 手机号码是否已经被注册
- (void)isVerifyMobile:(NSString *)mobile{
    NSString *path = [[NSString stringWithFormat:@"%@?tel=%@&tp=ckte",API_VERIFYTEL_URL,mobile] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //?tel=15212312321&tp=ckte
    [Connect connectPOSTWithURL:path parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSString *result = [[dic objectForKey:@"data"] objectForKey:@"result"];  //result=1表示重复
        NSInteger ret = [result integerValue];
        
            if (ret == 1) {
                _isExist = YES;
                [_verifyBtn setEnabled:YES];
//                [_verifyBtn setBackgroundImage:[UIImage imageNamed:@"getword_forbid"] forState:UIControlStateNormal];
                [SVProgressHUD showErrorWithStatus:@"该手机号码已经被注册过." duration:1.0];
                return;
            }else{
                _isExist = NO;
                [_verifyBtn setEnabled:YES];
                return;
            }
        
        } failuer:^(NSError *error) {
            _isExist = NO;
            return;
        }];
    
}


#pragma mark -
#pragma mark - 发送验证码
- (void) sendCodeAction : (UIButton * ) sender
{
    
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:1];
    NSString *phone = txtPhone.text;
    if (![self isValidateMobile:phone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:1.0];
        return;
    }
    
    if (_isExist == NO) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:131];
        
        [btn setEnabled:YES];
        
        NSString *path = [API_SENDSMS_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"sent",@"tp",phone,@"tel", nil];
        [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
            
            ((AppDelegate*)([UIApplication sharedApplication].delegate)).timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功." duration:1.0f];
            NSLog(@"API_SENDSMS_URL===%@",dic);
            return;
            
        } failuer:^(NSError *error) {
            return;
            
        }];
    }
    [txtPhone resignFirstResponder];
    
    
    
}




- (void)countDown:(NSTimer *)theTimer{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:131];
    if (seconds == 0) {
        [theTimer invalidate];
        [btn setTitle:@"" forState:UIControlStateNormal];
        seconds = 60;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setEnabled:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"getword_nor"] forState:UIControlStateNormal];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",seconds];
        [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [btn setTitleColor:R_G_B_A_COLOR(145, 185, 35, 1) forState:UIControlStateNormal];
        [btn setEnabled:NO];
        [btn setBackgroundImage:[UIImage imageNamed:@"aaa"] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}




#pragma mark - 
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:1];
    //UITextField *txtChkCode = (UITextField *)[self.view viewWithTag:2];
    //UITextField *txtPwd = (UITextField *)[self.view viewWithTag:3];
    //UITextField *txtPwd2 = (UITextField *)[self.view viewWithTag:4];
    
    NSString *phone = txtPhone.text;
   // NSString *chkCode = txtChkCode.text;
    
    if (![self isValidateMobile:phone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:1.0];
        return;
    }
    
    //手机号码是否已经被注册
    [self isVerifyMobile:phone];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
