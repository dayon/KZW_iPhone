//
//  MainInfoViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MainInfoViewController.h"
#import "MainInfoTableViewCell.h"
#import "Tool.h"
#import "Lesson.h"
#import "KoubeiTableViewCell.h"
#import "KouBeiDetailViewController.h"
#import "BaoMingViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "DaikuanViewController.h"
#import "LogInViewController.h"
#import "CustomButton.h"
#import "ErrorViewController.h"

@interface MainInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    [self setTitle:@"课程详情"];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction : )];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self loadData];
}


#pragma mark - 
#pragma mark - loadData
- (void)loadData{
    [SVProgressHUD show];
    NSString *url = [[NSString stringWithFormat:@"%@%ld",API_LESSON_DETAIL,(long)self.lessonId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"课程详情页接口 ============= %@", url);
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"课程详情页的数据 》》》》》》》》=========== %@", dic);
        self.mainDic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]];
        [self createView];
        self.isFocus = [[self.mainDic objectForKey:@"isFocus"] integerValue];
        [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.3];
        
        self.kouBeiArr = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"eval"]];
        if (self.isFocus == 1) {
            self.bottomBtn = (CustomButton *)[self.view viewWithTag:103];
            [self.bottomBtn setImage:[UIImage imageNamed:@"details_fav_done"] withTitle:@"已关注" forState:UIControlStateNormal];
        }
        [self.mainTable reloadData];
        
    } failuer:^(NSError *error) {
        NSLog(@"课程详情网络请求发生错误======%@", error);

        
    }];
}



#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    NSArray * titleArr = @[@"我要报名", @"贷款申请", @"关注课程"];
    NSArray * imageArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"details_sign_press"], [UIImage imageNamed:@"details_apply_press"], [UIImage imageNamed:@"details_fav_press"],[UIImage imageNamed:@"details_fav_done"], nil];
    
    NSArray * titleArrNo = @[@"我要报名", @"关注课程"];
    NSArray * imageArrNo = [NSArray arrayWithObjects:[UIImage imageNamed:@"details_sign_press"], [UIImage imageNamed:@"details_fav_press"],[UIImage imageNamed:@"details_fav_done"], nil];
    
    if ([[self.mainDic objectForKey:@"can_loan"] integerValue] != 1) {
        for (int i = 0; i < 2; i ++) {
            _bottomBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
            [_bottomBtn setFrame:CGRectMake(i * SCREEN_WIDTH / 2, SCREEN_HEIGHT - 104, SCREEN_WIDTH / 2, 40)];
            [_bottomBtn setTitleColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1] forState:UIControlStateNormal];
            [_bottomBtn setBackgroundColor:[UIColor whiteColor]];
            [_bottomBtn addTarget:self action:@selector(buttonAction: ) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [_bottomBtn setTag:101];
            } else {                                        //button 的tag 值为101和103
                [_bottomBtn setTag:103];
            }
            [_bottomBtn setImage:[imageArrNo objectAtIndex:i] withTitle:[titleArrNo objectAtIndex:i] forState:UIControlStateNormal];
            [self.view addSubview:_bottomBtn];
        }
    } else {
        
        for (int i = 0; i < 3; i ++) {
            _bottomBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
            [_bottomBtn setFrame:CGRectMake(i * SCREEN_WIDTH / 3, SCREEN_HEIGHT - 104, SCREEN_WIDTH / 3, 40)];
            [_bottomBtn setTitleColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1] forState:UIControlStateNormal];
            [_bottomBtn setBackgroundColor:[UIColor whiteColor]];
            
            [_bottomBtn addTarget:self action:@selector(buttonAction: ) forControlEvents:UIControlEventTouchUpInside];
            [_bottomBtn setTag:i + 101];                             //button 的tag 值为1~3
            [_bottomBtn setImage:[imageArr objectAtIndex:i] withTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:_bottomBtn];
        }
    }
    
    
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.mainTable];
    
}

- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark UITableView协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MainInfoTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MainInfoTableViewCell"];
        if (! cell) {
            cell = [[MainInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"MainInfoTableViewCell"];
        }
        if ([self.mainDic objectForKey:@"name"] != nil) {
            
            [cell setLessonName:[self.mainDic objectForKey:@"name"] andSchool:[self.mainDic objectForKey:@"school_name"] andFocus:[self.mainDic objectForKey:@"num_focus"] andImg:[self.mainDic objectForKey:@"logo"] andScore:[self.mainDic objectForKey:@"score"] andBeginTime:[self.mainDic objectForKey:@"time_begin"] andHour:[self.mainDic objectForKey:@"hour"] andPrice:[self.mainDic objectForKey:@"tuition"] andActiveTitle:nil andIntroduce:[self.mainDic objectForKey:@"desp"] andIsFocus:[self.mainDic objectForKey:@"isFocus"] andChart:[self.mainDic objectForKey:@"quota"] oldPrice:[self.mainDic objectForKey:@"o_tuition"]];
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
    
    KoubeiTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KoubeiTableViewCell"];
    if (! cell) {
        cell = [[KoubeiTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"KoubeiTableViewCell"];
    }
    [cell.userPhoto setImageWithURL:[NSURL URLWithString:[[self.kouBeiArr objectAtIndex:indexPath.row - 1] objectForKey:@"analyst_head_pic"]]];
    [cell.userName setText:[NSString stringWithFormat:@"%@  ✅", [[self.kouBeiArr objectAtIndex:indexPath.row - 1] objectForKey:@"analyst_name"]]];
    [cell.infoLabel setText:[[self.kouBeiArr objectAtIndex:indexPath.row - 1] objectForKey:@"content"]];
    [cell.timeLabel setText:[[self.kouBeiArr objectAtIndex:indexPath.row - 1] objectForKey:@"ctime_desc"]];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (SCREEN_HEIGHT == 480 || SCREEN_HEIGHT == 568) {
            return 1030;
        }
        return 1080;
    }
    if (SCREEN_HEIGHT == 480) {
        return 120;
    }
    return 120 * SCREEN_HEIGHT / 568;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + [self.kouBeiArr count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 1) {
        KouBeiDetailViewController * kouBeiDetailVC = [[KouBeiDetailViewController alloc] init];
        kouBeiDetailVC.mainDic = [[NSMutableDictionary alloc] initWithDictionary:[self.kouBeiArr objectAtIndex:indexPath.row - 1]];
        [kouBeiDetailVC setLessonName:[self.mainDic objectForKey:@"name"]];
        [kouBeiDetailVC sendMarkWithArr:[[self.kouBeiArr objectAtIndex:indexPath.row - 1] objectForKey:@"quota"]];
        [self.navigationController pushViewController:kouBeiDetailVC animated:YES];
        
    }
}

#pragma mark -
#pragma mark 分享按钮点击事件
- (void) shareAction : (UIBarButtonItem * ) sender
{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"分享" ofType:@"jpg"];                 //如果想分享本地图片的话
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                                scopes:nil
                                                         powerByHidden:YES
                                                        followAccounts:nil
                                                         authViewStyle:SSAuthViewStylePopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];

    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"课栈网课程分享"
                                       defaultContent:@"课程分享"
                                                image:[ShareSDK imageWithUrl:[self.mainDic objectForKey:@"logo"]]
                                                title:[self.mainDic objectForKey:@"name"]
                                                  url:[NSString stringWithFormat:@"%@?id=%ld&from=iosapp", API_SHARE_URL,(long)(long)self.lessonId]
                                          description:@"这门课程很不错啊！"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    id<ISSShareActionSheetItem> item1 = [ShareSDK shareActionSheetItemWithTitle:@"微信朋友圈"
                                                                           icon:[UIImage imageNamed:@"share_wx"]
                                                                   clickHandler:^{
                                                                       [ShareSDK shareContent:publishContent
                                                                                         type:ShareTypeWeixiTimeline
                                                                                  authOptions:authOptions
                                                                                statusBarTips:YES
                                                                                       result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                           
                                                                                           if (state == SSPublishContentStateSuccess)
                                                                                           {
                                                                                               NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                           }
                                                                                           else if (state == SSPublishContentStateFail)
                                                                                           {
                                                                                               NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                           }
                                                                                       }];
                                                                                                                                          }];
    
    

    NSArray * typeList = [NSArray arrayWithArray:[ShareSDK customShareListWithType:
                                                  SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                                  SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                                  SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                                                  SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                                                  SHARE_TYPE_NUMBER(ShareTypeQQ),
                                                  SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                                                  item1,
                                                  nil]];
    
    

        //弹出分享菜单
        [ShareSDK showShareActionSheet:nil
                             shareList:typeList
                               content:publishContent
                         statusBarTips:NO
                           authOptions:authOptions
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSResponseStateSuccess)
                                    {
                                        [SVProgressHUD showSuccessWithStatus:@"分享成功" duration:1];
                                        NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                        NSLog(@"========%@", [error errorDescription]);
                                        NSLog(@"--------%ld", (long)[error errorCode]);
                                    }
                                }];
}


#pragma mark -
#pragma mark 贷款/报名/关注按钮点击事件
- (void) buttonAction : (UIButton * ) sender
{
    NSLog(@"++++++++++++++++++++++++++%ld",(long)self.lessonId);
    switch (sender.tag) {
        case 101:
        {
            BaoMingViewController * baoMingVC = [[BaoMingViewController alloc] init];
            [self.navigationController pushViewController:baoMingVC animated:YES];
        }
            break;
        case 102:
        {
            [SVProgressHUD showWithStatus:@"表单加载中" maskType:SVProgressHUDMaskTypeClear];
            [Connect connectPOSTWithURL:[NSString stringWithFormat:@"%@?cid=%ld", API_LOAN_APPLY,(long)self.lessonId] parames:nil connectBlock:^(NSMutableDictionary *dic) {
                NSLog(@"code ===================================== %@", dic);
                if ([[dic objectForKey:@"code"] integerValue] != 0 && [[dic objectForKey:@"code"] integerValue] != 5) {
                    [SVProgressHUD showErrorWithStatus:@"发生错误！" duration:1];
                }
                if ([[dic objectForKey:@"code"] integerValue] == 5) {
                    LogInViewController * loginVC = [[LogInViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:^{
                        [SVProgressHUD dismissWithError:@"请先登录"];
                    }];
                }
                if ([[dic objectForKey:@"code"] integerValue] == 0) {
                    [SVProgressHUD dismissWithSuccess:@"表单加载成功"];
                    DaikuanViewController * daiKuanVC = [[DaikuanViewController alloc] init];
                    
                    daiKuanVC.lessonID = self.lessonId;
                    daiKuanVC.name = [self.mainDic objectForKey:@"name"];
                    daiKuanVC.school = [self.mainDic objectForKey:@"school_name"];
                    daiKuanVC.address = [self.mainDic objectForKey:@"school_address"];
                    daiKuanVC.hour = [self.mainDic objectForKey:@"hour"];
                    daiKuanVC.price = [self.mainDic objectForKey:@"tuition"];
                    daiKuanVC.sendVC = self;
                    
                    daiKuanVC.receiveDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
                    [self.navigationController pushViewController:daiKuanVC animated:YES];
                }
            } failuer:^(NSError *error) {
                NSLog(@"贷款前请求错误 ===== %@", error);
            }];
            
        }
            break;
        case 103:
            NSLog(@"我关注了");

            NSString *focusResult;
            NSString *msgInfo;
            if (self.isFocus == 1) {
                focusResult = @"2";
                msgInfo = @"取消关注";
            }else{
                focusResult = @"1";
                msgInfo = @"关注";
            }
            
            NSLog(@"%ld",_lessonId);
            NSString *path = [API_FOCUS_EVENT stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",_lessonId],@"oid",@"2",@"otype",focusResult,@"op", nil];
            
            [Connect connectPOSTWithURL:path parames:para connectBlock:^(NSMutableDictionary *dic) {
                
                NSLog(@"focus couse event result:%@",dic);
                
                self.bottomBtn = (CustomButton *)[self.view viewWithTag:103];
                if (self.isFocus == 1) {
                    self.isFocus = 0;
                    [self.bottomBtn setImage:[UIImage imageNamed:@"details_fav_press"] withTitle:@" 关注课程" forState:UIControlStateNormal];
                }else{
                    self.isFocus = 1;
                    [self.bottomBtn setImage:[UIImage imageNamed:@"details_fav_done"] withTitle:@"已关注" forState:UIControlStateNormal];
                    
                }
                
                
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@成功",msgInfo] duration:1.0f];
                
            } failuer:^(NSError *error) {
                
                NSLog(@"focus course error:%@",error);
                
            }];
            
            break;
            

    }

}
@end
