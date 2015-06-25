//
//  BaoMingViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/1.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "BaoMingViewController.h"

@interface BaoMingViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>
{
    int seconds;
}
@end

@implementation BaoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];

    [self setTitle:@"填写报名信息"];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    [self createView2];
    
    seconds = 60;
//    _isExist = NO;
}

#pragma mark - 
#pragma mark 创建视图
- (void)createView2{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    
    [self.view addSubview:bgView];
//    NSArray * lblArray = @[@"手机",@"姓名", @"验证码"];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:self.myTableView];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((SCREEN_WIDTH - 262)/2, SCREEN_HEIGHT - 120, 262, 40)];
    [button setTitle:@"报 名" forState:UIControlStateNormal];
    [button.layer setBorderColor:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1].CGColor];
    [button.layer setBorderWidth:0.5];
    [button.layer setCornerRadius:20];
    button.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
    [button addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [button setBackgroundImage:[UIImage imageNamed:@"signup_normal"] forState:UIControlStateNormal];
    [self.view addSubview:button];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arr = @[@"姓名",@"手机", @"验证码"];
    NSArray * userInfoPlaceholder = @[@"请填写姓名",@"请填写手机号", @"请填写验证码"];

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    _infoText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 150, 40)];
    [_infoText setDelegate:self];
    if (indexPath.row != 0) {
        [_infoText setKeyboardType:UIKeyboardTypePhonePad];
    }
    _infoText.tag = indexPath.row + 1;
    [_infoText  setPlaceholder:[userInfoPlaceholder objectAtIndex:indexPath.row]];
    _infoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cell.contentView addSubview:_infoText];
    
    if (indexPath.row == 1) {
        UIButton * verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [verifyButton setFrame:CGRectMake(SCREEN_WIDTH - 90 , 15, 90, 30 )];
        verifyButton.tag = 131;
        [verifyButton setBackgroundImage:[UIImage imageNamed:@"getword_nor"] forState:UIControlStateNormal];
        [verifyButton addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
        self.verifyBtn = verifyButton;
        [cell.contentView addSubview:self.verifyBtn];
    }

    cell.accessoryType = UITableViewCellAccessoryNone;
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    cell.textLabel.textColor = R_G_B_A_COLOR(51, 51, 51, 1);
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark -
#pragma mark 报名按钮点击事件
- (void) signUpAction: (UIButton * ) sender
{
    UITextField *txtName = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:2];
    UITextField *txtCode = (UITextField *)[self.view viewWithTag:3];
    NSString *uName = txtName.text;
    NSString *uPhone = txtPhone.text;
    NSString *chkCode = txtCode.text;
    
        if (uName.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"姓名不能为空." duration:1.0];
            return;
        }
        if (![self isValidateMobile:uPhone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:1.0];
        return;
        }
        if (chkCode.length<4) {
            [SVProgressHUD showErrorWithStatus:@"验证码输入不正确." duration:1.0];
            return;
        }
    //校验验证码
    [self isValidateChkCode:chkCode andPhone:uPhone];
//    [self postUserInfo];

    


    
}

#pragma mark -
#pragma mark - Submit user infomation
- (void)postUserInfo{
    UITextField *txtName = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:2];
  
    NSString *uName = txtName.text;
    NSString *uPhone = txtPhone.text;
 
    if (uName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空." duration:1.0];
        return;
    }
    
    if (![self isValidateMobile:uPhone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:2.0];
        return;
    }
    
    //http://dev.kezhanwang.cn/app/appuser/enroll?name=lwl_0321&sid=1&tel=15210096723&cid=2
    //    返回code = 5 是未登录，结果code=0为正常，code=3 参数错误， code=0时，result=0成功，result=1重复插入
    NSString *path = [API_SIGN_UP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //    NSDictionary *dict = @{@"":@"",@"":@"",@"":@""};
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:uName,@"name",uPhone,@"tel",[NSString stringWithFormat:@"%ld",(long)self.lessonId],@"cid", nil];
    NSLog(@"post para:%@",dict);
    [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
        
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result"] intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"报名成功,请等待工作人员与您联系" duration:1.0];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failuer:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
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


/*
 * http://123.56.156.37:8888/app/appuser/code?tp=ckco&tel=15210096742&co=3076
 * 返回结果code=1为正常，code=0 数据为空，或者异常，正常情况下result=0验证码可用
 */
#pragma mark -
#pragma mark - 校验验证码

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
        }
        else if ([result integerValue] == 1 ) {
            [SVProgressHUD showErrorWithStatus:@"验证码不正确." duration:1.0];
            UITextField *txtChkCode = (UITextField *)[self.view viewWithTag:3];
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
#pragma mark - 正则手机号码验证
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}



/**
 **http://123.56.156.37:8888/app/appuser/code?tp=sent&tel=15210096741
 **返回结果code=1为正常，code=0 数据为空，或者异常，正常情况下result=0已发送
 **/
#pragma mark -
#pragma mark 发送验证码点击事件
- (void) verifyAction : (UIButton * ) sender
{
    
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:2];
    NSString *phone = txtPhone.text;
    if (![self isValidateMobile:phone]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:2.0];
        return;
    }


        UIButton *btn = (UIButton *)[self.view viewWithTag:131];

            [btn setEnabled:YES];
            ((AppDelegate*)([UIApplication sharedApplication].delegate)).timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
            NSString *path = [API_SENDSMS_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"sent",@"tp",phone,@"tel", nil];
            [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
                
                [SVProgressHUD showSuccessWithStatus:@"验证码发送成功." duration:1.0f];
                NSLog(@"API_SENDSMS_URL===%@",dic);
                return;
                
            } failuer:^(NSError *error) {
                return;
                
            }];
    
    [txtPhone resignFirstResponder];
    
}




- (void)countDown:(NSTimer *)theTimer{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:131];
    if (seconds == 0) {
        [theTimer invalidate];
        [btn setTitle:@"" forState:UIControlStateNormal];
        seconds = 60;
        //        [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setEnabled:YES];
        [btn setBackgroundImage:[UIImage imageNamed:@"getword_nor"] forState:UIControlStateNormal];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",seconds];
        [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [btn setTitleColor:R_G_B_A_COLOR(145, 185, 35, 1) forState:UIControlStateNormal];
        [btn setEnabled:NO];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    
    
}


#pragma mark -
#pragma mark textField代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    UITextField *txtName = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtPhone = (UITextField *)[self.view viewWithTag:2];
    UITextField *txtCode = (UITextField *)[self.view viewWithTag:3];
    NSString *uName = txtName.text;
    NSString *uPhone = txtPhone.text;
    NSString *chkCode = txtCode.text;
    
    
    NSLog(@"验证码内容:%@",chkCode);
    if (textField == txtName) {
        if (uName.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"姓名不能为空." duration:1.0];
            return;
        }
    } else if (textField == txtPhone) {
        if (![self isValidateMobile:uPhone]) {
            [SVProgressHUD showErrorWithStatus:@"手机号码格式有误." duration:2.0];
            return;
        }
    } else if (textField == txtCode) {
        if (chkCode.length<4) {
            [SVProgressHUD showErrorWithStatus:@"验证码输入不正确." duration:1.0];
            return;
        } else {
            //校验验证码
//            [self isValidateChkCode:chkCode andPhone:uPhone];
        }
    }

    
    
    
}
#pragma mark -
#pragma mark - Back click
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
