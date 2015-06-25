//
//  SiftViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "SiftViewController.h"
#import "LessonCategory.h"
#import "Tool.h"
#import "MainViewController.h"

static NSString *cityName=@"全国";

@interface SiftViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


@end

@implementation SiftViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self reload];
    [self createView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];

    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    [self setTitle:@"筛选"];
    
    [self saveNSUserDefaultsValue:100000 forKey:@"areaId"];
    
    //读取上次操作记录
    [self readNSUserDefaults];
    

    
//    if (self.areaId > 0) {
//        
//        self.rightButton = [[UIBarButtonItem alloc] initWithTitle:self.areaName style:UIBarButtonItemStylePlain target:self action:@selector(locationAction : )];
//        
//        
//    }else{
    
//        self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"选择城市" style:UIBarButtonItemStylePlain target:self action:@selector(locationAction : )];
        self.right = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.right setFrame:CGRectMake(0, 0, 80, 30)];
        [self.right setTitle:cityName forState:UIControlStateNormal];
        [self.right addTarget:self action:@selector(locationAction : ) forControlEvents:UIControlEventTouchUpInside];
        [self.right setImage:[UIImage imageNamed:@"locate_nor"] forState:UIControlStateNormal];
        [self.right.titleLabel setAdjustsFontSizeToFitWidth:YES];
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.right];
        self.rightButton = rightButton;
//    }
    [self.navigationItem setRightBarButtonItem:self.rightButton];
    

    

}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - reload 加载数据

- (void)reload{
    
    
    
    NSString *url = [API_FILTER_LIST stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Connect connectGETWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        
        self.areaList = [NSMutableArray array];
        self.categoryList = [NSMutableArray array];
        self.childList = [NSMutableArray array];
        self.childArray = [NSMutableArray array];
        
        self.idArr = [NSMutableArray array];
        self.childArr = [NSMutableArray array];
        self.temp = [NSMutableArray array];
        
//        NSLog(@"filter dictionary data:%@",dic);
        //一级列表数据
//        self.categoryList = [NSMutableArray arrayWithArray:[Tool readStrCategoryList:[[dic objectForKey:@"data"] objectForKey:@"cate"]]];
//        self.areaList     = [NSMutableArray arrayWithArray:[Tool readStrAreaList:[[dic objectForKey:@"data"] objectForKey:@"area"]]];
//        LessonCategory *myCate = [[LessonCategory alloc] initWithParameters:[[[self.categoryList objectAtIndex:row] objectForKey:@"id"] integerValue] andTitle:[[self.categoryList objectAtIndex:row] objectForKey:@"name"]];
        
//        NSLog(@"filter dictionary data:%@",dic);
        //区域列表
        NSMutableArray *areas = [[dic objectForKey:@"data"] objectForKey:@"area"];
        
        for (NSMutableDictionary *area in areas) {
            NSLog(@"%@",area);
            LessonCategory *lca = [[LessonCategory alloc] initWithParameters:[[area objectForKey:@"areaid"] integerValue] andTitle:[area objectForKey:@"name"]];
            [self.areaList addObject:lca];
        }

        
        //一级分类
        NSMutableArray *cate1 = [[dic objectForKey:@"data"] objectForKey:@"cate"];
        for (NSMutableDictionary *cate in cate1) {
            
            LessonCategory *lc = [[LessonCategory alloc] initWithParameters:[[cate objectForKey:@"id"] integerValue] andTitle:[cate objectForKey:@"name"]];
            [self.categoryList addObject:lc];
            /*
            NSMutableArray *cate2 = [cate objectForKey:@"child"];
            for (NSMutableDictionary *child in cate2) {
                
                LessonCategory *lc2 = [[LessonCategory alloc] initWithParameters:[[child objectForKey:@"id"] integerValue] andTitle:[child objectForKey:@"name"]];
                [self.childList addObject:lc2];

            }
             */
            
            //生成数据保存子类id与父类对应关系
            [self.idArr addObject:[cate objectForKey:@"id"]];
            [self.childArr addObject:[cate objectForKey:@"child"]];
            
            

        }
    
        [self.leftTable reloadData];
        
        //二级列表数据
        if (self.childId) {
            
//            NSLog(@"两个数组============%@  ，   %@.........%ld",self.idArr, self.childArr,self.categoryId);
//            NSString *searchId = [NSString stringWithFormat:@"%ld",(long)self.childId];
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF == '%@'",searchId]];//@"SELF == 'APPLE'"
//            NSArray *filteredArray = [self.childArray filteredArrayUsingPredicate:predicate];
            for (int i = 0; i < [self.idArr count]; i ++) {
//                if ([[self.idArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%ld",self.categoryId]] ){
                if ([[self.idArr objectAtIndex:i] integerValue] == self.categoryId) {
                     self.temp = [self.childArr objectAtIndex:i];
                }
            }
             NSLog(@"self.tempself.tempself.tempself.tempself.tempself.tempself.tempself.temp%@",[self.childArr objectAtIndex:1]);
            
            for (NSDictionary *child in self.temp) {
                
                LessonCategory *lcc = [[LessonCategory alloc] initWithParameters:[[child objectForKey:@"id"] integerValue] andTitle:[child objectForKey:@"name"]];
                [self.childList addObject: lcc];
            }
            
             [self.rightTable reloadData];
        }else{
            
            NSMutableArray *childArray = [[[[dic objectForKey:@"data"] objectForKey:@"cate"] objectAtIndex:0] objectForKey:@"child"];
//            NSLog(@"??????????????????%@",childArray);
            for (NSDictionary *child in childArray) {
                
                LessonCategory *lcc = [[LessonCategory alloc] initWithParameters:[[child objectForKey:@"id"] integerValue] andTitle:[child objectForKey:@"name"]];
                [self.childList addObject: lcc];
            }
            
            

            
            [self.rightTable reloadData];
        }
        self.JSON = dic;
    } failuer:^(NSError *error) {
        NSLog(@"SiftViewControll.m网络请求发生错误====%@", error);
    }];

}

- (void)loadCategoryData{

    self.categoryList = [NSMutableArray arrayWithArray:[Tool readStrCategoryList:[[self.JSON objectForKey:@"data"] objectForKey:@"cate"]]];
    self.areaList     = [NSMutableArray arrayWithArray:[Tool readStrAreaList:[[self.JSON objectForKey:@"data"] objectForKey:@"area"]]];
}





#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, SCREEN_HEIGHT - 64)];
    [self.leftTable setDataSource:self];
    [self.leftTable setDelegate:self];
    [self.leftTable setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
    [self.leftTable setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:self.leftTable];
    
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTable.frame.size.width + self.leftTable.frame.origin.x, 0, SCREEN_WIDTH - self.leftTable.frame.size.width, self.leftTable.frame.size.height)];
    [self.rightTable setDataSource:self];
    [self.rightTable setDelegate:self];
    [self.view addSubview:self.rightTable];
    


    
}



#pragma mark -
#pragma mark UITableView协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        NSInteger row = indexPath.row;
    if (self.categoryList.count) {
        if ([tableView isEqual:_leftTable]) {
            
            UIView *leftCellSelectBgView = [[UIView alloc] init];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 60)];
            [label setBackgroundColor:R_G_B_A_COLOR(102, 177, 222, 1)];
            [leftCellSelectBgView addSubview:label];
            [leftCellSelectBgView setBackgroundColor:R_G_B_A_COLOR(249, 249, 249, 1)];
            [cell.textLabel setTextColor:R_G_B_A_COLOR(0, 125, 200, 1)];
            // 返回当前所选cell
            [cell setSelectedBackgroundView:leftCellSelectBgView];

            
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"清除筛选";
            }else{

                LessonCategory *myCate = self.categoryList[row-1];
                cell.textLabel.text = [NSString stringWithFormat:@"%@",myCate.title];
                cell.tag = myCate.cateId + 100;
                [cell setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                if (self.categoryId == myCate.cateId) {
                    UIView *leftCellSelectBgView = [[UIView alloc] init];
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 60)];
                    [label setBackgroundColor:R_G_B_A_COLOR(102, 177, 222, 1)];
                    [leftCellSelectBgView addSubview:label];
                    [leftCellSelectBgView setBackgroundColor:R_G_B_A_COLOR(249, 249, 249, 1)];
                    [cell.textLabel setTextColor:R_G_B_A_COLOR(0, 125, 200, 1)];
                    // 返回当前所选cell
                    [cell setSelectedBackgroundView:leftCellSelectBgView];
                    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    
                    
                }
                
                self.leftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            }
            
        }
    }

    NSLog(@"%ld",self.childList.count);
    if (self.childList.count) {
        if ([tableView isEqual:_rightTable]) {
            
            
            UIView *rightCellSelectBgView = [[UIView alloc] init];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 40)];
            [label setBackgroundColor:R_G_B_A_COLOR(221, 221, 221, 1)];
            [rightCellSelectBgView addSubview:label];
            [rightCellSelectBgView setBackgroundColor:R_G_B_A_COLOR(240, 240, 240, 1)];
            [cell setSelectedBackgroundView:rightCellSelectBgView];
            [cell.textLabel setTextColor:R_G_B_A_COLOR(0, 125, 200, 1)];
            

            LessonCategory *myChild = self.childList[row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",myChild.title];
            cell.tag = myChild.cateId;
            //                    [cell.textLabel setText:myChild.title];
            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];

            if (self.childId == myChild.cateId) {
                
                UIView *rightCellSelectBgView = [[UIView alloc] init];
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 40)];
                [label setBackgroundColor:R_G_B_A_COLOR(221, 221, 221, 1)];
                [rightCellSelectBgView addSubview:label];
                [rightCellSelectBgView setBackgroundColor:R_G_B_A_COLOR(240, 240, 240, 1)];
                [cell setSelectedBackgroundView:rightCellSelectBgView];
                [cell.textLabel setTextColor:R_G_B_A_COLOR(0, 125, 200, 1)];
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

            }
            
        }

    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTable) {
        return 60;
    }
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    if (tableView == self.leftTable) {
        return self.categoryList.count>0?self.categoryList.count+1:1;
//        return self.categoryList.count>0?self.categoryList.count:0;
    }else if (tableView == self.rightTable){
        return self.childList.count>0?self.childList.count:0;
    }
    return 0;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTable) {               //点击一级分类
        
        if (indexPath.row == 0) {
            NSLog(@"current row is %ld",indexPath.row);
            //清除 cookies
            [self clearCookies];
            [self.delegate filterLessonWithCategory:NO andCategory:0 andChild:0 andArea:0];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }else{
        
            //重新加载child数据
            [self.childList removeAllObjects];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            

            self.categoryId = cell.tag-100;
            

            [self saveNSUserDefaultsValue:self.categoryId forKey:@"cateId"];
            
    //        NSMutableDictionary *myDic = [[[[self.JSON objectForKey:@"data"] objectForKey:@"cate"] objectForKey:[NSString stringWithFormat:@"%ld",cell.tag-100 ]] objectForKey:@"child"];
    //        self.childList = [Tool readStrCategoryList:myDic];
//            NSLog(@"self.json=====================%@",self.JSON);

            NSMutableArray *childArray = [[[[self.JSON objectForKey:@"data"] objectForKey:@"cate"] objectAtIndex:indexPath.row - 1] objectForKey:@"child"];
            NSLog(@"??????????????????%@",childArray);
            for (NSDictionary *child in childArray) {
                
                LessonCategory *lcc = [[LessonCategory alloc] initWithParameters:[[child objectForKey:@"id"] integerValue] andTitle:[child objectForKey:@"name"]];
                [self.childList addObject: lcc];
            }

            
            [self.rightTable reloadData];
        }
        
        
    } else if ([tableView isEqual:self.rightTable]) {//点击二级分类后进行筛选工作
        
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.childId = cell.tag;
        
        
        [self saveNSUserDefaultsValue:self.childId forKey:@"childId"];
        
        if (self.areaId) {
            
            [self.delegate filterLessonWithCategory:YES andCategory:self.categoryId andChild:self.childId andArea:self.areaId];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self displayMessage:@"请正确选择筛选城市"];
        }

    }
    
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = R_G_B_A_COLOR(0, 125, 200, 1);
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rightTable) {
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.childList removeObjectAtIndex:indexPath.row];
    [self.rightTable reloadData];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rightTable) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return @"删除";
}

#pragma mark -
#pragma mark 地理位置按钮点击事件
- (void) locationAction : (UIBarButtonItem *) sender
{
    self.pickerViewBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    UIView * aeroView = [[UIView alloc] init];
    [aeroView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [aeroView setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 200)];
    [aeroView setClipsToBounds:YES];
    [aeroView.layer setCornerRadius:10];
    [aeroView setCenter:self.pickerViewBackGround.center];
    [self.pickerViewBackGround addSubview:aeroView];
    
    self.locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, aeroView.frame.size.width, aeroView.frame.size.height / 5)];
    [self.locatePicker setDelegate:self];
    [self.locatePicker setDataSource:self];
    [aeroView addSubview:self.locatePicker];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(0 , self.locatePicker.frame.origin.y + self.locatePicker.frame.size.height, self.locatePicker.frame.size.width, aeroView.frame.size.height - self.locatePicker.frame.size.height)];
    [sureButton setTitle:@"确定"forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction : ) forControlEvents:UIControlEventTouchUpInside];
    [aeroView addSubview:sureButton];
    
    [self.view addSubview:self.pickerViewBackGround];
}


#pragma mark -
#pragma mark UIPickerView协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.areaList count];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:25]];
    LessonCategory *area = self.areaList[row];
    
    label.text = [NSString stringWithFormat:@"%@",area.title];//area.title;

    return label;
}


#pragma mark -
#pragma mark 地点选择后确定按钮点击事件
- (void) sureButtonAction : (UIButton * ) sender
{
//    [self.rightButton setTitle:[self.areaList objectAtIndex:[self.locatePicker selectedRowInComponent:0]]];

    LessonCategory *city = [self.areaList objectAtIndex:[self.locatePicker selectedRowInComponent:0]];
    self.areaId = city.cateId;
    
    [self saveNSUserDefaultsValue:self.areaId forKey:@"areaId"];
    [self saveNSUserDefaultsString:city.title forKey:@"areaName"];
    cityName = city.title;
    
//    [self.rightButton setTitle:[NSString stringWithFormat:@"%@",city.title]];
    [self.right setTitle:[NSString stringWithFormat:@"%@",cityName] forState:UIControlStateNormal];
    [self.pickerViewBackGround removeFromSuperview];
}


#pragma mark -
#pragma mark - NSUserDefaults
- (void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    self.categoryId = [userDefaultes integerForKey:@"cateId"];
    self.childId = [userDefaultes integerForKey:@"childId"];
    self.areaId = [userDefaultes integerForKey:@"areaId"];
    self.areaName = [userDefaultes stringForKey:@"areaName"];
    
    NSLog(@"######################################################");
    
    NSLog(@"NSUserDefaults Reading Data....cateId=%ld,childId=%ld,areaId=%ld,areaName=%@",self.categoryId,self.childId,self.areaId,self.areaName);
    
    NSLog(@"######################################################");
    
}


- (void)saveNSUserDefaultsValue:(NSInteger)paraID forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:paraID forKey:key];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}
- (void)saveNSUserDefaultsString:(NSString *)paraID forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:paraID forKey:key];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}

- (void) displayMessage:(NSString *)paramMessage{
    [[[UIAlertView alloc] initWithTitle:nil
                                message:paramMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
#pragma mark -
#pragma mark - Clear Cookies
- (void)clearCookies{
    //清除本地记录
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cateId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"childId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"areaId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"areaName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    cityName = @"全国";
    
    //清空cookie
    NSArray * cookArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookArray) {
//        if ([cookie.name isEqualToString:@"cate1id"] || [cookie.name isEqualToString:@"cate2id"] || [cookie.name isEqualToString:@"areaid"]) {
        if ([cookie.name isEqualToString:@"cate1id"]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }else if ([cookie.name isEqualToString:@"cate2id"]){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }else if ([cookie.name isEqualToString:@"areaid"]){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        
    }
    
    //read cookies
//    NSHTTPCookieStorage *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *_tmpArray = [NSArray arrayWithArray:[cookies cookies]];
//    for (id obj in _tmpArray) {
//        //        [cookies deleteCookie:obj];
//        NSLog(@"cookies object name:%@",obj);
//    }

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
