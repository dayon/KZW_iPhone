//
//  SuccessViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/10.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "SuccessViewController.h"
#import "DaiKuanInfoTableViewCell.h"
#import "SuccessTableViewCell.h"
@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    
    [self setTitle:@"申请成功"];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    
    [self createView];
    
}



#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.view addSubview:self.mainTable];
}


#pragma mark -
#pragma mark UITableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SuccessTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SuccessTableViewCell"];
        if (! cell) {
            cell = [[SuccessTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"SuccessTableViewCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setUserInteractionEnabled:YES];
        return cell;
    }
    
    NSArray * infoArr = [NSArray arrayWithObjects:self.lessonName, self.schoolName, self.schoolAddress, self.hour, [NSString stringWithFormat:@"￥%@", self.price], nil];
    NSArray * titleArr = [NSArray arrayWithObjects:@"课程名称", @"学校名称", @"学校地址", @"课时", @"课程价格", nil];
    DaiKuanInfoTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DaiKuanInfoTableViewCell"];
    if (! cell) {
        cell = [[DaiKuanInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"DaiKuanInfoTableViewCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.infoText setUserInteractionEnabled:NO];
    [cell setUserInteractionEnabled:YES];
    if (indexPath.section == 1) {
        [cell.titleLabel setText:[titleArr objectAtIndex:indexPath.row]];
        [cell.infoText setText:[infoArr objectAtIndex:indexPath.row]];
    } else if (indexPath.section == 2) {
        [cell.titleLabel setText:@"贷款方式"];
        [cell.infoText setText:self.daiKuanFenQi];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 70;
    }
    return 30;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 1;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 190;
    }
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 2) {
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        [backView setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(20 * SCREEN_WIDTH / 320, 15, SCREEN_WIDTH - 2 * (20 * SCREEN_WIDTH / 320), 40 * SCREEN_HEIGHT / 568)];
        [button addTarget:self action:@selector(OKActinon :) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
        [button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
        [backView addSubview:button];
        return backView;
    }
    
    UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 30)];
    [label setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
    if (section == 0) {
        [label setText:@"课程概况"];
    } else {
        [label setText:@"贷款金额范围"];
    }
    return label;
}


#pragma mark -
#pragma mark 确定并返回按钮点击事件
- (void) OKActinon : (UIButton * ) sender
{
    [self.navigationController popToViewController:self.lessonInfo animated:YES];
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
