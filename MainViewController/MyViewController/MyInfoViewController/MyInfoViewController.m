//
//  MyInfoViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/30.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "NickNameViewController.h"
#import "EmailViewController.h"
@interface MyInfoViewController ()

@end

@implementation MyInfoViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initUserInfoData];


    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];

    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    [self setTitle:@"个人信息"];
    
    [self initUserInfoData];
    [self createView];
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initUserInfoData{
    
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (ap.isLoginStatus) {
        
        /*
        ** http://123.56.156.37:8888/app/appuser/uinfo?uid=2&tp=get
        ** 返回结果code=0为正常，code=1 数据为空，或者异常
         */
        NSString *path = [NSString stringWithFormat:@"%@?uid=%@&tp=get",API_VERIFYTEL_URL,ap.userId];
        NSLog(@"userinfo path:%@",path);
        [Connect connectGETWithURL:path parames:nil connectBlock:^(NSMutableDictionary *dic) {
            
            NSLog(@"=================userinfo dictionary:%@",dic);
            NSString *uPic = [[dic objectForKey:@"data"] objectForKey:@"head_pic"];
            NSString *uName = [[dic objectForKey:@"data"] objectForKey:@"username"];
            NSString *uSex = [[dic objectForKey:@"data"] objectForKey:@"gender"];
            NSString *uEmail = [[dic objectForKey:@"data"] objectForKey:@"email"];
            NSString *uPhone = [[dic objectForKey:@"data"] objectForKey:@"authmobile"];
            NSString *uDate = [[dic objectForKey:@"data"] objectForKey:@"rdate"];
            
            //updated userinfo
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:uPic forKey:@"usrImg"];
            [userDefaults synchronize];
            AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ap.userImg = uPic;
            
            
            
            NSArray *array = [NSArray arrayWithObjects:uPic,uName,uEmail,uPhone,uSex,uDate, nil];
            self.userInfo = [[NSArray alloc] initWithArray:array];
            [self.mainTable reloadData];

            
        } failuer:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else{
        
    }
}



#pragma mark - 
#pragma mark 创建视图
- (void) createView
{
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.mainTable setScrollEnabled:NO];
    [self.mainTable setBackgroundColor:[UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1]];

    [self.view addSubview:self.mainTable];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainTable.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.mainTable.frame.size.height)];
    bottomView.backgroundColor = R_G_B_A_COLOR(231, 231, 231, 1);
    [self.view addSubview:bottomView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setFrame:CGRectMake((SCREEN_WIDTH - 262)/2, 180+64, 262, 40)];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button.layer setBorderColor:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1].CGColor];
    button.backgroundColor = R_G_B_A_COLOR(0, 125, 200, 1);
    [button setCenter:bottomView.center];
    [button.layer setBorderWidth:0.5];
    [button.layer setCornerRadius:20];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logOutAction : ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


#pragma mark -
#pragma mark 带有选择器的视图的创建
- (void) createPickerView
{
    self.pickerViewBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    UIView * aeroView = [[UIView alloc] init];
    [aeroView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [aeroView setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 200)];
    [aeroView setClipsToBounds:YES];
    [aeroView.layer setCornerRadius:10];
    [aeroView setCenter:self.pickerViewBackGround.center];
    [self.pickerViewBackGround addSubview:aeroView];
    
    self.sexPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, aeroView.frame.size.width, aeroView.frame.size.height / 5)];
    [self.sexPicker setDelegate:self];
    [self.sexPicker setDataSource:self];
    [aeroView addSubview:self.sexPicker];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(0 , self.sexPicker.frame.origin.y + self.sexPicker.frame.size.height, self.sexPicker.frame.size.width, aeroView.frame.size.height - self.sexPicker.frame.size.height)];
    [sureButton setTitle:@"确定"forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction: ) forControlEvents:UIControlEventTouchUpInside];
    [aeroView addSubview:sureButton];
}


#pragma mark -
#pragma mark UITableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    

    if (indexPath.row == 0) {
        MyInfoTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyInfoTableViewCell"];
        if ( ! cell) {
            cell = [[MyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyInfoTableViewCell"];
        }
        [cell.textLabel setText:@"头像"];
        [cell.userPhoto setImageWithURL:[self.userInfo firstObject]];

         [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
       //    [cell.textLabel setText:self.userInfo[indexPath.row]];
    }

    NSArray * titleArr = @[@"昵称", @"邮箱", @"手机号", @"性别", @"注册时间"];

    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [cell.textLabel setText:[titleArr objectAtIndex:indexPath.row - 1]];
    if (indexPath.row == 4) {
        if ([[self.userInfo objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            cell.detailTextLabel.text = @"保密";
        }else if ([[self.userInfo objectAtIndex:indexPath.row] isEqualToString:@"1"]){
            cell.detailTextLabel.text = @"男";
        }else if ([[self.userInfo objectAtIndex:indexPath.row] isEqualToString:@"2"]){
            cell.detailTextLabel.text = @"女";
        }
            
        
    }else{
        cell.detailTextLabel.text = [self.userInfo objectAtIndex:indexPath.row];
    }
    
    
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==  0) {
//        return 70;
        return SCREEN_WIDTH/7 + 20;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册里选择", nil];
        [actionSheet showInView:self.view];
    } else if (indexPath.row == 1) {
        
        NickNameViewController * nickNameVC = [[NickNameViewController alloc] init];
        nickNameVC.nickNamel = ^ (NSString * nickName){
            [self.mainTable reloadData];
        };
        [self.navigationController pushViewController:nickNameVC animated:YES];
    } else if (indexPath.row == 2) {
        EmailViewController * emailVC = [[EmailViewController alloc] init];
        emailVC.email = ^ (NSString * email) {
             [self.mainTable reloadData];
        };
        [self.navigationController pushViewController:emailVC animated:YES];
    }
    else if (indexPath.row ==4) {
        [self createPickerView];
        [self.view addSubview:self.pickerViewBackGround];
    }
}



#pragma mark -
#pragma mark UIPickerView代理方法
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:25]];
    switch (row) {
        case 0:
            [label setText:@"保密"];
            break;
        case 1:
            [label setText:@"男"];
            break;
        case 2:
            [label setText:@"女"];
            break;
        default:
            break;
    }
    return label;
}

#pragma mark -
#pragma mare UIActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    if (buttonIndex == 0) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    } else if (buttonIndex == 1) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }
    
}


#pragma mark -
#pragma mark UIImagePickerController代理协议
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithObjects:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.1), nil];
    
    [Connect connectDATAWithURL:API_USER_UPLOADPIC parames:nil imageArr:arr succeed:^(NSMutableDictionary *dic) {
        NSLog(@"上传成功 ====== %@", dic);
        [self initUserInfoData];
        [self.mainTable reloadData];
    } failure:^(NSError *connectError) {
        NSLog(@"头像图片上传时候网络请求错误(文岭接口)========= %@", connectError);
    }];
    
    UIImage * image = [UIImage imageWithData:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.01)];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    NSLog(@"++++++++%@", info);
//    self.myInfoModel.imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.01);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    [self.mainTable reloadData];
        
}





#pragma mark - 
#pragma mark 退出登录事件
- (void) logOutAction : (UIButton * ) sender
{
    

    [self alertMessage:@"确定退出登录?"];
    
    //NSLog(@"我已经退出");
}



#pragma mark -
#pragma mark 性别选择按钮点击事件
- (void) sureButtonAction : (UIButton * ) sender
{
    if ([self.sexPicker selectedRowInComponent:0] == 0) {
        self.userSex = @"0";
    } else if ([self.sexPicker selectedRowInComponent:0] == 1) {
        self.userSex = @"1";
    } else if ([self.sexPicker selectedRowInComponent:0] == 2) {
       self.userSex = @"2";
    }
    [self saveSex:self.userSex];
    
    [self.pickerViewBackGround removeFromSuperview];
}

- (void)saveSex:(NSString *)sexValue{
    
    NSString *url = [[NSString stringWithFormat:@"%@?sex=%@",API_USERINFO_MODIFY,sexValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [Connect connectPOSTWithURL:url parames:nil connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"user infomation modify ====%@",dic);//返回code = 5 是未登录，结果code=0为正常，code=3 参数为空， code=0时，result=1表示更新成功，result=0未更新
        if (dic != nil) {
            //[self.mainTable reloadData];
            UITableViewCell *cell = [self.mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            
                if ([self.userSex isEqualToString:@"0"]) {
                    cell.detailTextLabel.text = @"保密";
                }else if ([self.userSex isEqualToString:@"1"]){
                    cell.detailTextLabel.text = @"男";
                }else if ([self.userSex isEqualToString:@"2"]){
                    cell.detailTextLabel.text = @"女";
                }
            
            
            
            
             NSLog(@"user infomation has modified.");
        }
        
    } failuer:^(NSError *error) {
        
        NSLog(@"user infomation has modified.%@",error);
        
    }];
    
    
    
}

- (void)alertMessage:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark -
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usrName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usrId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kzuser"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        ap.isLoginStatus = NO;
        //清空cookie
        NSHTTPCookieStorage *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *_tmpArray = [NSArray arrayWithArray:[cookies cookies]];
        for (id obj in _tmpArray) {
            [cookies deleteCookie:obj];
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
