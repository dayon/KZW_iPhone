//
//  AboutUsViewController.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/6/15.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    [self setTitle:@"关于课栈"];
    
    
    [self createView];
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"html"];
    NSURLRequest * Request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:API_ABOUT_US]];
    
    UIWebView * myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [myWebView loadRequest:Request];
    [self.view addSubview:myWebView];
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
