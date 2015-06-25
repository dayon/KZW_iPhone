//
//  FeedBackViewController.m
//  HiGame
//
//  Created by 张宁浩 on 15/3/9.
//  Copyright (c) 2015年 OliverQueen. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SVProgressHUD.h"

@interface FeedBackViewController ()
@property (nonatomic, strong) UILabel * backLabel;

@end

@implementation FeedBackViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_bg"]];
    [self.navigationItem setTitle:@"意见反馈"];

    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard : )];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
//    [self createView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}


#pragma mark -
#pragma mark 获取键盘高度通知方法
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, -height + 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    } completion:nil];
}


#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
    [self.view addSubview:bgView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    _feedBack = [[UITextView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 50 -64, SCREEN_WIDTH - 120, 30)];
    [_feedBack setDelegate:self];
    [_feedBack setClipsToBounds:YES];
    [_feedBack setUserInteractionEnabled:YES];
    [_feedBack.layer setCornerRadius:10];
//    [_feedBack.layer setBorderWidth:1];
//    [_feedBack.layer setBorderColor:[UIColor colorWithRed:44 / 255.5 green:198 / 255.0 blue:201 / 255.0 alpha:1].CGColor];
    [bgView addSubview:_feedBack];
    
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setFrame:CGRectMake(_feedBack.frame.origin.x + _feedBack.frame.size.width+5, _feedBack.frame.origin.y, SCREEN_WIDTH - _feedBack.frame.size.width - 20, 30)];
    [_sendButton setTitle:@"提交反馈" forState:UIControlStateNormal];
//    [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    _sendButton.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
//    [_sendButton.layer setBorderWidth:0.5];
    [_sendButton.layer setCornerRadius:10];
//    [_sendButton setTitleColor:[UIColor colorWithRed:44 / 255.5 green:198 / 255.0 blue:201 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendAction : ) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_sendButton];
    
    self.backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    [self.backLabel setFont:[UIFont boldSystemFontOfSize:20]];
    self.backLabel.center = self.view.center;
    [self.backLabel setTextAlignment:NSTextAlignmentCenter];
    [self.backLabel setText:@""];//Give feedback or ask for help
    [bgView addSubview:self.backLabel];
    
}


#pragma mark -
#pragma mark 发送按钮点击事件
- (void)sendAction : (UIButton * ) sender
{
    [_feedBack resignFirstResponder];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    } completion:nil];
    [self.backLabel setText:_feedBack.text];
    
    NSString *content = self.feedBack.text;
    NSLog(@"feedBack.text=======%@",content);
    if (content.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"意见反馈内容不能为空." duration:1.0f];
        return;
    }else{
    
        if (content.length > 200) {
            [SVProgressHUD showErrorWithStatus:@"意见反馈内容不可以超过200个字符." duration:1.0f];
            return;
        }
    }


    NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:content,@"msg", nil];
    
    [Connect connectPOSTWithURL:API_FEEDBACK_URL parames:dict connectBlock:^(NSMutableDictionary *dic) {
        
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"data"] objectForKey:@"result"]) {
            [SVProgressHUD showSuccessWithStatus:@"意见反馈提交成功." duration:1.0];
            self.feedBack.text = nil;
        }
        
        
        
    } failuer:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    NSLog(@"submit success.");
}

- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 隐藏键盘方法
- (void) hideKeyboard : (id) sender
{
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    } completion:nil];
    [_feedBack resignFirstResponder];
}

@end
