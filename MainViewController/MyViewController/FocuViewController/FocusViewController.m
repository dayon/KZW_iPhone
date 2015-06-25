//
//  FocusViewController.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/30.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "FocusViewController.h"
#import "LessonCustomTableViewCell.h"
#import "MainInfoViewController.h"
#import "Lesson.h"
#import "Tool.h"

@interface FocusViewController (){
    NSInteger allCount;
}


@end

@implementation FocusViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的关注";
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    self.lessonList = [NSMutableArray arrayWithCapacity:5];
    
    
    
    
}
#pragma mark -
#pragma mark - backButtonItem click
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark - load data
- (void)initData{
    

    NSString *url = [[NSString stringWithFormat:@"%@",API_LESSON_FOCUSLIST] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"load focus list**********************%@",dic);
        NSMutableArray *newLessons = [Tool readStrLessonDic:[[dic objectForKey:@"data"] objectForKey:@"result"] andOld:_lessonList];
        _lessonList = newLessons;
        NSLog(@"%@",_lessonList);
        
        if ([_lessonList count] == 0) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [bgView setBackgroundColor:R_G_B_A_COLOR(231, 231, 231, 1)];
            [self.view addSubview:bgView];
            UILabel * backGround = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
            [backGround setText:@"暂无关注"];
            [backGround setTextColor:[UIColor lightGrayColor]];
            [backGround setFont:[UIFont boldSystemFontOfSize:22]];
            [backGround setTextAlignment:NSTextAlignmentCenter];
            [bgView addSubview:backGround];
            
        } else {
            [self initUI];
        }
        
        
        [self.myTableView reloadData];
        
    } failuer:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
#pragma mark -
#pragma mark - init UI
- (void)initUI{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView setSeparatorColor:[UIColor clearColor]];

    
    [self.view addSubview:self.myTableView];
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lessonList.count>0?self.lessonList.count:0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
    NSInteger row = indexPath.row;
    
    LessonCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LessonCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }


    Lesson *myLesson = self.lessonList[row];

    if([myLesson.img rangeOfString:@"http://"].location != NSNotFound){
        [cell.lessonImage setImageWithURL:[NSURL URLWithString:myLesson.img]];
    }else{
        [cell.lessonImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEBURL,myLesson.img]]];
    }

    UILabel * lblTitle = (UILabel *)[cell.contentView viewWithTag:1];
    lblTitle.text = [NSString stringWithFormat:@"%@",myLesson.title];
    lblTitle.font = [UIFont systemFontOfSize:19.0];
    lblTitle.textColor = [UIColor colorWithRed:72/255.0 green:79/255.0 blue:85/255.0 alpha:1.0];

    cell.markStar.scorePercent = [myLesson.score floatValue]/5;
    UILabel * lblScore = (UILabel *)[cell.contentView viewWithTag:3];
    lblScore.text = [NSString stringWithFormat:@"%@分",myLesson.score];
    [lblScore setTextColor:[UIColor colorWithRed:255/255.0 green:191/255.0 blue:0/255.0 alpha:1]];

    UIImageView *focusImgView = (UIImageView *)[cell.contentView viewWithTag:4];
    NSLog(@"isFocus:%d",myLesson.isFocus);
//    if (myLesson.isFocus) {
        [focusImgView setImage:[UIImage imageNamed:@"fav_small_after"]];
//    }else{
//        [focusImgView setImage:[UIImage imageNamed:@"fav_small_before"]];
//    }


    UILabel * lblFocusCounts = (UILabel *)[cell.contentView viewWithTag:5];
    lblFocusCounts.text = myLesson.focusCounts;
    [lblFocusCounts setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];

    UILabel * lblSchool = (UILabel *)[cell.contentView viewWithTag:6];
    lblSchool.text = myLesson.school;
    [lblSchool setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];


    cell.tag = myLesson.lessonId;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    


    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    MainInfoViewController * mainInfoVC = [[MainInfoViewController alloc] init];
    mainInfoVC.lessonId = cell.tag;
    [self.navigationController pushViewController:mainInfoVC animated:YES];
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
