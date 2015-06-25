//
//  MainViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MainViewController.h"
#import "SiftViewController.h"
#import "MyViewController.h"
#import "LessonCustomTableViewCell.h"
#import "MainInfoViewController.h"
#import "Lesson.h"
#import "DataSingleton.h"
#import "ErrorViewController.h"


#define RRowCount 100
#define RCellHeight 100
static NSInteger pageSize = 5;
static NSInteger page = 2;


@interface MainViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate , FilterLessonDelegate >{
    NSMutableDictionary *_lessonDic;
    UIButton *_bottomRefresh;
    NSInteger allCount;
    NSInteger _rowCount;
}

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSArray *searchBarSubView = [(UIView *)[_mainSearchBar.subviews objectAtIndex:0] subviews];
    
    for (UIView *subView in searchBarSubView) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            
            [subView removeFromSuperview];
            
            
        }else if([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]){
            
            ((UITextField *)subView).background=[UIImage imageNamed:@"searchbar_bg"]; //这里设置你的背景图片
            ((UITextField *)subView).layer.cornerRadius = 13;
            
            ((UITextField *)subView).borderStyle=UITextBorderStyleNone;
            
            ((UITextField *)subView).text=@"请输入课程、学校、评测";
            ((UITextField *)subView).textColor = [UIColor whiteColor];
            
        }
    }
    
    [self reload:YES];
    [self createView];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 32, 32);
    [self.leftButton setClipsToBounds:YES];
    [self.leftButton.layer setCornerRadius:16];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"head_70"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    backItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = backItem;
    
    self.searchKeyWord = @"";
    
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction : )];
    [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
    
    
    self.mainSearchBar = [[UISearchBar alloc] init];

    [self.mainSearchBar setImage:[UIImage imageNamed:@"search_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.mainSearchBar setImage:[UIImage imageNamed:@"search_delate_nor"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.mainSearchBar setImage:[UIImage imageNamed:@"search_delate_press"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];

    [self.mainSearchBar setTintColor:[UIColor whiteColor]];
    
    [self.mainSearchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.mainSearchBar setDelegate:self];
    [self.navigationItem setTitleView:self.mainSearchBar];


    
    [SVProgressHUD showWithStatus:@"加载中请稍后"];
    self.orderBy = kOrderByFocus;

     [self reload:YES];
    [self createView];
}

///////////////////////////////new 2015.6.19///////////////////////////////////////
#pragma mark -
#pragma mark - 下拉刷新
- (void)pullToRefresh
{
    self.searchKeyWord = @"";
    NSString *url = [[NSString stringWithFormat:@"%@?sort=%@&p=%d&ps=%ld",API_LESSON_LIST,self.orderBy,1,(long)pageSize] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"#########请求地址：#############");
    NSLog(@"%@",url);
    NSLog(@"######################");
    
    
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"lesson list dictionary:%@",dic);
        NSMutableArray * arr =[NSMutableArray arrayWithArray:[[dic objectForKey:@"data"] objectForKey:@"result"]];
        self.lessonList = arr;
        
        [self.mainTable.header endRefreshing];
        [SVProgressHUD dismissWithSuccess:@"加载完成"];
        [self.mainTable reloadData];
    } failuer:^(NSError *error) {
        NSLog(@"首页网络请求出错===%@", error);
    }];
    
    
    
}

#pragma mark -
#pragma mark - 上拉加载
- (void)upToRefresh
{
    
    NSString *url = [[NSString stringWithFormat:@"%@?sort=%@&p=%ld&ps=5&wd=%@",API_LESSON_LIST,self.orderBy,(long)page,self.searchKeyWord] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"#########请求地址：#############");
    NSLog(@"%@",url);
    NSLog(@"######################");
    
    
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"lesson list dictionary:%@",dic);
        NSLog(@"第%ld页============有%lu个数据", (long)page, (unsigned long)[[[dic objectForKey:@"data"] objectForKey:@"result"]count]);
        
        
        if ([[[dic objectForKey:@"data"] objectForKey:@"result"]count] > 0 ) {//&& [[[dic objectForKey:@"data"] objectForKey:@"result"]count] <= pageSize
            [self.lessonList addObjectsFromArray:[[dic objectForKey:@"data"] objectForKey:@"result"]];
            pageSize += [[[dic objectForKey:@"data"] objectForKey:@"result"] count];
            [SVProgressHUD dismissWithSuccess:@"加载完成"];
            self.mainTable.footer.hidden = YES;
            self.mainTable.footer.hidden = NO;
            [self.mainTable reloadData];
            page ++;
        } else {
            [self.mainTable.footer noticeNoMoreData];
        }
    } failuer:^(NSError *error) {
        NSLog(@"首页网络请求出错===%@", error);
    }];
    
    
}
////////////////////////////////


- (void)clear
{
    allCount = 0;
    [self.lessonList removeAllObjects];
}
#pragma mark -
#pragma mark - reload 解析并加载Json数据  noRefresh
- (void)reload:(BOOL)noRefresh{

    NSInteger pageIndex;
    NSLog(@"isNotFilter = %d",self.isNotFilter);
    if (!self.isNotFilter) {//调用课程列表
        
        pageIndex = allCount/5+1;
        
        NSString *url = [[NSString stringWithFormat:@"%@?sort=%@&p=%ld&ps=%ld&wd=%@",API_LESSON_LIST,self.orderBy,(long)pageIndex,(long)pageSize,self.searchKeyWord] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"#########请求地址：#############");
        NSLog(@"%@",url);
        NSLog(@"######################");

        
        [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
    
            self.lessonList = [NSMutableArray array];
            
            //直接取NSArray方法
            NSMutableArray *newLessonList = [[dic objectForKey:@"data"] objectForKey:@"result"];
            for (NSMutableDictionary *lessonDic in newLessonList) {
                [self.lessonList addObject:lessonDic];
            }
            
            NSLog(@"课程列表顺寻及详情===========:%@",self.lessonList);

            [SVProgressHUD dismissWithSuccess:@"加载完成"];
            
            if ([[dic objectForKey:@"data"] objectForKey:@"user"] != nil) {
                [self.leftButton setImageWithURL:[NSURL URLWithString:[[[dic objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"head_pic"]] forState:UIControlStateNormal];
            }
            
            [self.mainTable reloadData];
        } failuer:^(NSError *error) {
            NSLog(@"首页网络请求出错===%@", error);
//            ErrorViewController *errorVc = [[ErrorViewController alloc] init];
//            [self.navigationController pushViewController:errorVc animated:YES];
        }];
    }else{                  //过滤筛选
        [self RequestFilterDataWithCookie];
        NSLog(@"filter.");
    }
    
    
    

    
}


- (void)setCookies{
//    NSString *expTime = [self getCurrentTime];
//    NSLog(@"/////////////////////////设置cookies:cate1ID:%ld,cate2ID%ld,areaID:%ld",self.cate1ID,self.cate2ID,self.areaID);
    NSDictionary *dictCookieCateID = [NSDictionary dictionaryWithObjectsAndKeys:@"cate1id",NSHTTPCookieName,
                                      [NSString stringWithFormat:@"%ld",(long)self.cate1ID],NSHTTPCookieValue,
                                      @"/",NSHTTPCookiePath,
                                      @".kezhanwang.cn",NSHTTPCookieDomain,
                                      [[NSDate date] dateByAddingTimeInterval:2629743],NSHTTPCookieExpires,
                                      nil];
    NSDictionary *dictCookieChildID = [NSDictionary dictionaryWithObjectsAndKeys:@"cate2id",NSHTTPCookieName,
                                       [NSString stringWithFormat:@"%ld",(long)self.cate2ID],NSHTTPCookieValue,
                                       @"/",NSHTTPCookiePath,
                                       @".kezhanwang.cn",NSHTTPCookieDomain,
                                       [[NSDate date] dateByAddingTimeInterval:2629743],NSHTTPCookieExpires,
                                       nil];
    NSDictionary *dictCookieAreaID = [NSDictionary dictionaryWithObjectsAndKeys:@"areaid",NSHTTPCookieName,
                                      [NSString stringWithFormat:@"%ld",(long)self.areaID],NSHTTPCookieValue,
                                      @"/",NSHTTPCookiePath,
                                      @".kezhanwang.cn",NSHTTPCookieDomain,
                                      [[NSDate date] dateByAddingTimeInterval:2629743],NSHTTPCookieExpires,
                                      nil];
    
    NSHTTPCookie *cookieCateID = [NSHTTPCookie cookieWithProperties:dictCookieCateID];
    NSHTTPCookie *cookieChildID = [NSHTTPCookie cookieWithProperties:dictCookieChildID];
    NSHTTPCookie *cookieAreaID = [NSHTTPCookie cookieWithProperties:dictCookieAreaID];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieCateID];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieChildID];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieAreaID];
    
}


- (void)RequestFilterDataWithCookie{
    [self setCookies];
    NSString *url = [API_LESSON_LIST stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Connect connectPOSTWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        
        if ([self.lessonList count] != 0){
//            NSLog(@"+++++++++++++++++++++%@", self.lessonList);
            [(NSMutableArray *)self.lessonList removeAllObjects];
        }
        
//        NSLog(@"筛选===========================%@",dic);
        if ([[dic objectForKey:@"data"] objectForKey:@"result"] != nil) {
            [self.lessonList addObjectsFromArray:[[dic objectForKey:@"data"] objectForKey:@"result"]];
            [self.mainTable reloadData];
        }
        [SVProgressHUD showSuccessWithStatus:@"筛选成功." duration:1.0];
        
    } failuer:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}






#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    [self setTitle:@"首页"];
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.mainTable setSeparatorColor:[UIColor clearColor]];
//    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.mainTable];
    
    
    [self.mainTable addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
    [self.mainTable.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
    [self.mainTable.header setTitle:@"松手开始刷新" forState:MJRefreshHeaderStatePulling];
    [self.mainTable.header setTitle:@"刷新中..." forState:MJRefreshHeaderStateRefreshing];
    
    
    [self.mainTable addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upToRefresh)];
    [self.mainTable.footer setTitle:@"刷新中..." forState:MJRefreshFooterStateRefreshing];
    [self.mainTable.footer setTitle:@"没有更多数据" forState:MJRefreshFooterStateNoMoreData];
    
    

}


#pragma mark -
#pragma mark UITableView协议方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cell";
    
    NSInteger row = indexPath.row;
    
    
    LessonCustomTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LessonCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([self.lessonList count] > 0) {
        //用NSArray方法进行转换
        self.myLesson = [[Lesson alloc] initWithParameters:[[[self.lessonList objectAtIndex:row] objectForKey:@"id"] integerValue] andImg:[[self.lessonList objectAtIndex:row] objectForKey:@"logo"] andTitle:[[self.lessonList objectAtIndex:row] objectForKey:@"name"] andScore:[[self.lessonList objectAtIndex:row] objectForKey:@"score"] andSchool:[[self.lessonList objectAtIndex:row] objectForKey:@"school"] andFocusCounts:[[self.lessonList objectAtIndex:row] objectForKey:@"num_focus"] andIsFocus:[[[self.lessonList objectAtIndex:row] objectForKey:@"isFocus"] integerValue] > 0?YES:NO];
        
        //直接解dictionary方法
//        self.myLesson = self.lessonList[row];
    }
        [cell.lessonImage setImageWithURL:[NSURL URLWithString:self.myLesson.img]];
    
    
    UILabel * lblTitle = (UILabel *)[cell.contentView viewWithTag:1];
    lblTitle.text = [NSString stringWithFormat:@"%@",self.myLesson.title];
    lblTitle.font = [UIFont systemFontOfSize:19.0];
    lblTitle.textColor = [UIColor colorWithRed:72/255.0 green:79/255.0 blue:85/255.0 alpha:1.0];
    
    cell.markStar.scorePercent = [self.myLesson.score floatValue]/5;
    UILabel * lblScore = (UILabel *)[cell.contentView viewWithTag:3];
    lblScore.text = [NSString stringWithFormat:@"%@分",self.myLesson.score];
    [lblScore setTextColor:[UIColor colorWithRed:255/255.0 green:191/255.0 blue:0/255.0 alpha:1]];
    
    UIImageView *focusImgView = (UIImageView *)[cell.contentView viewWithTag:4];
    if (self.myLesson.isFocus) {
        [focusImgView setImage:[UIImage imageNamed:@"fav_small_after"]];
    }else{
        [focusImgView setImage:[UIImage imageNamed:@"fav_small_before"]];
    }
    
    
    UILabel * lblFocusCounts = (UILabel *)[cell.contentView viewWithTag:5];
    lblFocusCounts.text = self.myLesson.focusCounts;
    [lblFocusCounts setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
    
    UILabel * lblSchool = (UILabel *)[cell.contentView viewWithTag:6];
    lblSchool.text = self.myLesson.school;
    [lblSchool setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
    
    
    cell.tag = self.myLesson.lessonId;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (SCREEN_HEIGHT == 480) {
            return 100;
        }
        return 90 * SCREEN_HEIGHT / 568;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",(unsigned long)self.lessonList.count);
    return self.lessonList.count == 0 ? 0 : self.lessonList.count;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 * SCREEN_HEIGHT / 568;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * mySectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];

    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 40 * SCREEN_HEIGHT / 568)];
    self.focusBtn.tag = 1;

    [self.focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_highlight"] forState:UIControlStateHighlighted];
    [self.focusBtn addTarget:self action:@selector(tapHeader:) forControlEvents:UIControlEventTouchUpInside];
    [mySectionView addSubview:self.focusBtn];
    
    self.scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scoreBtn setFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 40 * SCREEN_HEIGHT / 568)];
    self.scoreBtn.tag = 2;

    [self.scoreBtn setBackgroundImage:[UIImage imageNamed:@"score_highlight"] forState:UIControlStateHighlighted];
    [self.scoreBtn addTarget:self action:@selector(tapHeader:) forControlEvents:UIControlEventTouchUpInside];
    [mySectionView addSubview:self.scoreBtn];
    
    if ([_orderBy isEqualToString:kOrderByFocus] || _orderBy == nil) {
        [self.focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_highlight"] forState:UIControlStateNormal];
        [self.scoreBtn setBackgroundImage:[UIImage imageNamed:@"score_normal"] forState:UIControlStateNormal];
        
    }else if ([_orderBy isEqualToString:kOrderByScore]){
        [self.focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_normal"] forState:UIControlStateNormal];
        [self.scoreBtn setBackgroundImage:[UIImage imageNamed:@"score_highlight"] forState:UIControlStateNormal];
     }

    return mySectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        MainInfoViewController * mainInfoVC = [[MainInfoViewController alloc] init];
        mainInfoVC.lessonId = cell.tag;
        [self.navigationController pushViewController:mainInfoVC animated:YES];

}


#pragma mark - 
#pragma mark UIScrollView代理方法
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.mainSearchBar resignFirstResponder];
}


#pragma mark -
#pragma mark 左侧"我的"按钮点击事件
- (void) leftButtonAction : (UIBarButtonItem * ) sender
{
    self.isNotFilter = NO;
    [self.mainSearchBar resignFirstResponder];
    MyViewController * myVC = [[MyViewController alloc] init];
    [self.navigationController pushViewController:myVC animated:NO];
}


#pragma mark -
#pragma mark 右侧"筛选"按钮点击事件
- (void) rightButtonAction : (UIBarButtonItem * ) sender
{
    [self.mainSearchBar resignFirstResponder];
    self.siftVC = [[SiftViewController alloc] init];
    self.tempVC = self.siftVC;
    self.siftVC.delegate = self;
    [self.navigationController pushViewController:self.siftVC animated:NO];
}

#pragma mark -
#pragma mark titlrButton的点击事件
- (void) tapHeader : (UIButton * ) sender
{
    self.isNotFilter = NO;
    
    NSInteger tag = sender.tag;
        if (tag == 1) {
        self.orderBy = kOrderByFocus;
            NSLog(@"点击了关注");

    }else{
        self.orderBy = kOrderByScore;
        NSLog(@"点击了评分");

    }

    [self clear];
    [self reload:YES];
    
}




#pragma mark -
#pragma mark -UISearchBar代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text = nil;
};


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchKeyWord = searchBar.text;
    
    NSString *url = [[NSString stringWithFormat:@"%@?sort=&p=1&ps=%d&wd=%@",API_LESSON_LIST,10000,searchBar.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"搜索返回的数据  ================== %@", dic);
        NSLog(@"搜索结果一共%ld条记录",[[[dic objectForKey:@"data"] objectForKey:@"result"] count]);
        [self.lessonList removeAllObjects];
        [self.lessonList addObjectsFromArray:[[dic objectForKey:@"data"] objectForKey:@"result"]];
        NSLog(@"粽子店======= %@", self.lessonList);
        [self.mainTable reloadData];
    } failuer:^(NSError *error) {
    }];
 [searchBar setText:@"请输入课程、学校、评测"];
    [searchBar resignFirstResponder];
}


#pragma mark - 
#pragma mark FilterLessonDelegate
- (void) filterLessonWithCategory:(BOOL)isNotFilter andCategory:(NSInteger)cateId andChild:(NSInteger)childId andArea:(NSInteger)cityId{
    
    self.isNotFilter = isNotFilter;
    self.cate1ID = cateId;
    self.cate2ID = childId;
    self.areaID = cityId;
    
}
#pragma mark -
#pragma mark - NSUserDefaults
 - (id)readNSUserDefaultsWithKey:(NSString *)key{
     NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
     NSString *retStr = [userDefaultes stringForKey:key];
     return retStr;
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
