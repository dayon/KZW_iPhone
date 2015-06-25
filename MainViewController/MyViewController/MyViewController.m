//
//  MyViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MyViewController.h"
#import "MyCustomTableViewCell.h"
#import "LoginAndRegisteViewController/LogInViewController.h"
#import "SettingViewController.h"
#import "FocusViewController.h"
#import "AppDelegate.h"
#import "MyInfoViewController.h"
#import "Loan.h"

@interface MyViewController () <UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,LoginDelegate>

@end

@implementation MyViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.isLoginStatus) {
        
        
        self.userName = [self readNSUserDefaultsWithKey:@"usrName"];
        self.userId = [self readNSUserDefaultsWithKey:@"usrId"];
        self.userImg = [self readNSUserDefaultsWithKey:@"usrImg"];

        NSLog(@"///////////////////登录成功////////////////////");
        self.lblMsg.text = app.userName;
//        self.lblFocusCount.text = self.userFocus; //关注数
        
        [self.loginButton removeTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginButton addTarget:self action:@selector(modifyUserInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.userImagel setImageWithURL:[NSURL URLWithString:self.userImg]];
    }else{
        NSLog(@"///////////////////未登录////////////////////");
        [self.lblMsg setText:@"点击登录"];
        [self.loginButton removeTarget:self action:@selector(modifyUserInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.userImagel setImage:[UIImage imageNamed:@"head_130.png"]];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页进入左侧我的会员中心
    
    // Do any additional setup after loading the view.
//    self.userName = [self readNSUserDefaultsWithKey:@"usrName"];
//    self.userId = [self readNSUserDefaultsWithKey:@"usrId"];
//    self.userImg = [self readNSUserDefaultsWithKey:@"usrImg"];
    
    
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    NSLog(@"userId===%@",self.userId);
    
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_set_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction : )];
    [self.navigationItem setRightBarButtonItem:rightButton];
    

    [self createView];
    [self loadLoanData];
   
}


#pragma mark -
#pragma mark - NSUserDefaults
- (id)readNSUserDefaultsWithKey:(NSString *)key{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *retStr = [userDefaultes stringForKey:key];
    return retStr;
}



#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    
    //登录背景按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    
    //会员图片
    self.userImagel = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 65/2, 5, 65, 65)];
    self.userImagel.layer.masksToBounds = YES;
    self.userImagel.layer.cornerRadius = self.userImagel.bounds.size.width *0.5;
    self.userImagel.layer.borderWidth = 5.0;
    self.userImagel.layer.borderColor = [UIColor colorWithRed:49/255.0 green:157/255.0 blue:222/255.0 alpha:1].CGColor;
    [self.loginButton addSubview:self.userImagel];
    
    //会员昵称显示
    self.lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userImagel.frame.origin.y + self.userImagel.frame.size.height, SCREEN_WIDTH, 40)];
    self.lblMsg.textAlignment = NSTextAlignmentCenter;
    [self.lblMsg setTextColor:[UIColor whiteColor]];
    [self.loginButton addSubview:self.lblMsg];
    
    //loginButton添加到self.view
    [self.view addSubview:self.loginButton];
    
    
    

    //关注
    self.focusView = [[UIView alloc] initWithFrame:CGRectMake(0, self.loginButton.frame.origin.y + self.loginButton.frame.size.height +10, SCREEN_WIDTH, 68)];
    [self.focusView setBackgroundColor:[UIColor colorWithRed:10/255.0 green:123/255.0 blue:190/255.0 alpha:1]];
    [self.view addSubview:self.focusView];
    
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 10, 26, 16, 16)];
    [imgV setImage:[UIImage imageNamed:@"mine_fav_small"]];
    [self.focusView addSubview:imgV];
    
    UIButton *lblFocus = [[UIButton alloc] initWithFrame:CGRectMake(36+ 10, 14, 80, 40)];
    [lblFocus setTitle:@"我的关注" forState:UIControlStateNormal];
    [lblFocus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lblFocus addTarget:self action:@selector(myFocusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.focusView addSubview:lblFocus];
    
    self.lblFocusCount = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,14 , 60, 40)];
    [self.lblFocusCount setText:@""];
    [self.lblFocusCount setTextColor:[UIColor whiteColor]];
    [self.focusView addSubview:self.lblFocusCount];
    
    
    
}

- (void)createTableView{
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.focusView.frame.origin.y + self.focusView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - 242)] ;
    
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.mainTable setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:self.mainTable];
}

- (void)createBottomView{
    //底部
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.focusView.frame.origin.y + self.focusView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - 168)];
    self.bottomView.backgroundColor = R_G_B_A_COLOR(231, 231, 231, 1);
    [self.view addSubview:self.bottomView];
    
    
    //背景图
    UIImageView *bottomImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 30, (SCREEN_HEIGHT - 168)/2 - 30 - 64, 60, 60)];
    [bottomImgV setImage:[UIImage imageNamed:@"mine_none"]];
    [self.bottomView addSubview:bottomImgV];
    //没有贷款信息
    UILabel *lblBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, bottomImgV.frame.origin.y + bottomImgV.frame.size.height, SCREEN_WIDTH, 40)];
    lblBottom.text = @"没有贷款信息";
    lblBottom.textAlignment = NSTextAlignmentCenter;
    lblBottom.textColor = R_G_B_A_COLOR(192, 192, 192, 1);
    lblBottom.font = [UIFont systemFontOfSize:20.0f];
    [self.bottomView addSubview:lblBottom];
}


- (void)loadLoanData{
    NSString *path = [API_USER_LOANLIST stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",path);
    [Connect connectGETWithURL:path parames:nil connectBlock:^(NSMutableDictionary *dic) {
        if (dic != nil) {
            NSLog(@"loadLoanData dic ==%@",dic);
            if ([[dic objectForKey:@"code"] integerValue] == 0) {//登录状态
                
                self.userFocus = [[[dic objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"course_focus"];
                self.lblFocusCount.text = self.userFocus; //关注数
                
                if ([[dic objectForKey:@"data"] objectForKey:@"user"] != nil) {
                    [self.userImagel setImageWithURL:[NSURL URLWithString:[[[dic objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"head_pic"]]];
                }

                //Loan数组
                NSMutableArray *array = [[dic objectForKey:@"data"] objectForKey:@"loan"];
                self.loanList = [NSMutableArray arrayWithArray:[Tool readStrLoanList:array]];
                NSLog(@">>>>>>>>>>>>>>>>>>>>user focus count:%@",[self.loanList firstObject]);
                if ([self.loanList count] != 0) {
                    //有数据显示"关注列表"

                    [self createTableView];
                }else{
                    //显示"没有贷款信息"
                    [self createBottomView];
                }
            }

        }
    } failuer:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark -
#pragma mark modifyUserInfo
- (void)modifyUserInfo:(UIButton *)sender{
    
    MyInfoViewController *usrInfoVc = [[MyInfoViewController alloc] init];
    [self.navigationController pushViewController:usrInfoVc animated:YES];
    
}



#pragma mark -
#pragma mark UITableView代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCustomTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyCustomTableViewCell"];
    if (! cell) {
        cell = [[MyCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"MyCustomTableViewCell"];
    }
    
    
        
    
    Loan *myLoan = self.loanList[indexPath.section];
    
        
    
    NSArray *arrInfo = [NSArray arrayWithObjects:myLoan.lessonName,myLoan.loanStatus,myLoan.loanAmount,myLoan.repaymentDate,myLoan.principal,myLoan.interest,myLoan.repaymentAmount,nil];

    for (int i = 0; i < 7; i ++){
        UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:i+1];
        lblTitle.text = [NSString stringWithFormat:@"%@",arrInfo[i]];
        lblTitle.font = [UIFont systemFontOfSize:17.0];
        lblTitle.textColor = [UIColor colorWithRed:72/255.0 green:79/255.0 blue:85/255.0 alpha:1.0];
    }

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.loanList.count > 0 ? self.loanList.count:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Loan *myLoan = self.loanList[section];
    return [NSString stringWithFormat:@"贷款信息%ld：%@", (long)(long)section + 1, myLoan.lessonName];
}


#pragma mark -
#pragma mark 关注按钮点击事件
- (void)myFocusAction:(UIButton *)sender
{
    
    NSLog(@"adfasdfasfasffasfa");
    if ([[sender currentTitle] isEqualToString:@"我的关注"]) {
        
        NSLog(@"我的关注");
        FocusViewController *fVc = [[FocusViewController alloc] init];
        [self.navigationController pushViewController:fVc animated:YES];
    }
}


#pragma mark -
#pragma mark 登录按钮点击事件
- (void) loginButtonAction : (UIButton * ) sender
{
    LogInViewController *loginVc = [[LogInViewController alloc] init];
    loginVc.delegate = self;

    [self presentViewController:loginVc animated:YES completion:nil];
}


#pragma mark -
#pragma mark 设置按钮点击事件
- (void) settingAction : (UIBarButtonItem * )sender
{
    SettingViewController * settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    if (viewController == self) {
        // 背景设置为黑色
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
        // 透明度设置为0.3
        self.navigationController.navigationBar.alpha = 0.300;
        // 设置为半透明
        self.navigationController.navigationBar.translucent = YES;
    } else {
        // 进入其他视图控制器
        self.navigationController.navigationBar.alpha = 1;
        // 背景颜色设置为系统默认颜色
        self.navigationController.navigationBar.tintColor = nil;
        self.navigationController.navigationBar.translucent = NO;
    }
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - LoginDelegate
- (void)LoginUserName:(NSString *)usrName andUserId:(NSString *)usrId andUserImg:(NSString *)usrImg andUserFocus:(NSString *)usrFocus{
    self.userName = usrName;
    self.userId = usrId;
    self.userImg = usrImg;
    self.userFocus = usrFocus;
    
    [self.loginButton addTarget:self action:@selector(modifyUserInfo:) forControlEvents:UIControlEventTouchUpInside];
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
