//
//  SettingViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "APService.h"
static BOOL isOpen = YES;
@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"取消";
    self.navigationItem.backBarButtonItem = backItem;
    [self setTitle:@"设置"];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    self.pushNotification = [[UISwitch alloc] init];
    [self.pushNotification setOnTintColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1]];
    [self.pushNotification addTarget:self action:@selector(push:) forControlEvents:UIControlEventValueChanged];
    [self.pushNotification setOn:isOpen];
    
    self.pictureSize = [[UISwitch alloc] init];
    [self.pictureSize setOnTintColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    [self.view addSubview:bgView];
    [self createView];
}


#pragma mark - 
#pragma mark 创建视图
- (void) createView
{

    
    self.settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.settingTable setDataSource:self];
    [self.settingTable setDelegate:self];
    [self.view addSubview:self.settingTable];
}


#pragma mark -
#pragma mark UITableView代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"消息推送"];
            [cell setAccessoryView:self.pushNotification];
        } else if (indexPath.row == 1) {
            [cell.textLabel setText:@"2G/3G浏览小图"];
            [cell setAccessoryView:self.pictureSize];
        } else {
            [cell.textLabel setText:@"清除缓存图片"];
            [cell.detailTextLabel setText:@"1234.56G"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.2f Kb", [[SDImageCache sharedImageCache] checkTmpSize] * 1024]];
        }
    } else {
        NSArray * titleArr = @[@"意见反馈", @"关于课栈"];
        [cell.textLabel setText:[titleArr objectAtIndex:indexPath.row]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    }
    self.settingTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FeedBackViewController * feedBackVC = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }else if (indexPath.row == 1){
            AboutUsViewController *abtVc = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:abtVc animated:YES];
        }
        
    }
    
    if (indexPath.row == 2) {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat : @"已经清除%.2fKb缓存", [[SDImageCache sharedImageCache] checkTmpSize] * 1024] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [[SDImageCache sharedImageCache] clearDisk];
        [self.settingTable reloadData];
    }
    NSLog(@"indexPath.row ==== %ld", (long)indexPath.row);
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 推送开关
- (void) push:(UISwitch * ) sender
{
    if (sender.on) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                           UIUserNotificationTypeSound |
                                                           UIUserNotificationTypeAlert)
                                               categories:nil];
        } else {
            //categories 必须为nil
            [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                           UIRemoteNotificationTypeSound |
                                                           UIRemoteNotificationTypeAlert)
                                               categories:nil];
        }
#else
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
        
#endif
        isOpen = YES;
    } else {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        isOpen = NO;
    }
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
