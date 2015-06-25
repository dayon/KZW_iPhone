//
//  XieYiViewController.m
//  KZW_iPhoneNew
//
//  Created by Oliver on 15/6/11.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "XieYiViewController.h"

@interface XieYiViewController ()

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];

    [self setTitle:@"贷款协议"];

    
    [self createView];
}


#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    NSURLRequest * Request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    
    UIWebView * xieYi = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [xieYi loadRequest:Request];
    [self.view addSubview:xieYi];
}
@end
