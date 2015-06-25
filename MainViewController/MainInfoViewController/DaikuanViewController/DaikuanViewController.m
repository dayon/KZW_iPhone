//
//  DaikuanViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/6/4.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "DaikuanViewController.h"
#import "DaiKuanInfoTableViewCell.h"
#import "DaiKuanTypeTableViewCell.h"
#import "MyInfoTableViewCell.h"
#import "SuccessViewController.h"
#import "XieYiViewController.h"

@interface DaikuanViewController ()
{
    int seconds;
}

@end

@implementation DaikuanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    seconds = 60;
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];
    
    // Do any additional setup after loading the view.
    
    
//    [self.view setBackgroundColor:[UIColor orangeColor]];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    [self setTitle:@"贷款申请"];
    self.titleArr = [[NSArray alloc] initWithObjects:@"贷款金额", @"还款方式", @"姓名", @"身份证号",@"班级", @"手机号", @"验证码", @"微信", @"邮箱", @"银行", @"银行卡号", @"工作状态", @"单位/学校名称", @"单位/学校地址", @"单位/学校电话", @"姓名", @"关系", @"电话", @"姓名", @"关系", @"电话", nil];
    self.pictureCellTitlel = [[NSArray alloc] initWithObjects:@"身份证正面", @"身份证背面", @"银行卡正面", @"场景照", nil];
    self.placeHolderArr = [[NSArray alloc] initWithObjects:@"贷款金额", @"选择还款方式", @"输入姓名", @"输入身份证号", @"输入所期望的班级", @"输入手机号", @"输入验证码", @"输入微信", @"输入邮箱", @"输入银行", @"输入银行卡号", @"输入工作状态", @"输入单位/学校名称", @"输入单位/学校地址", @"输入单位/学校电话", @"输入姓名", @"输入关系", @"输入电话", @"输入姓名", @"输入关系", @"输入电话", nil];
    
    
    self.backStyle = [NSArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"loanTypes"]];
    self.bankArr = [NSArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"banks"]];
    self.workStyle = [NSArray arrayWithObjects:@"无业", @"在职", @"学生", nil];
    self.relation = [NSArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"relation"]];
    
    NSLog(@"我请求道的字典是 ===== %@", self.receiveDic);
    
    self.tempTextField = [[UITextField alloc] init];
    
    [self createView];
}
#pragma mark -
#pragma mark - backAction 返回上一页
- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 创建视图
- (void)createView
{
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.view addSubview:self.mainTable];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setDelegate:self];
    
    self.submit = [[Submitinfo alloc] init];
    self.submit.imageDic = [[NSMutableDictionary alloc] init];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从图库中选择", nil];
}


#pragma mark -
#pragma mark UITableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 19 || indexPath.row == 23) {
            
            UITableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            if (indexPath.row == 0) {
                [cell.textLabel setText:[NSString stringWithFormat:@"%@的贷款申请",[[[self.receiveDic objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"username"]]];
                [cell.textLabel setFont:[UIFont boldSystemFontOfSize:30]];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            }
            if (indexPath.row == 1) {
                [cell.textLabel setText:@"贷款申请书"];
                [cell setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
            }
            if (indexPath.row == 5) {
                [cell.textLabel setText:@"贷款人信息"];
                [cell setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
            }
            if (indexPath.row == 19) {
                [cell.textLabel setText:@"第一联系人"];
                [cell setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
            }
            if (indexPath.row == 23) {
                [cell.textLabel setText:@"第二联系人"];
                [cell setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
            }
            return cell;
        }
        
        if (indexPath.row == 4) {
            DaiKuanTypeTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DaiKuanTypeTableViewCell"];
            if (! cell) {
                cell = [[DaiKuanTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"DaiKuanTypeTableViewCell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            self.huanKuanDate = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 30)];
            [self.huanKuanDate setUserInteractionEnabled:NO];
            [self.huanKuanDate setTextColor:[UIColor redColor]];
            [self.huanKuanDate setTextAlignment:NSTextAlignmentCenter];
            [self.huanKuanDate setText:self.submit.huanKuanDate];
            [self.huanKuanDate setBackgroundColor:[UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1]];
            [self.huanKuanDate.layer setBorderColor:[UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1].CGColor];
            [self.huanKuanDate.layer setBorderWidth:1];
            [self.huanKuanDate setClipsToBounds:YES];
            [self.huanKuanDate.layer setCornerRadius:10];
            [cell.contentView addSubview:self.huanKuanDate];
            
            if (self.typeDic != nil) {
                if ([[self.typeDic objectForKey:@"ratetype"]  isEqual: @"1"]) {
                    [cell createTitleLabelWithRatetimex:[self.typeDic objectForKey:@"ratetimex"]
                                              ratetimey:[self.typeDic objectForKey:@"ratetimey"]
                                             moneyApply:[self.typeDic objectForKey:@"applyMoney"]
                                                  ratex:[self.typeDic objectForKey:@"ratex"]
                                                  ratey:[self.typeDic objectForKey:@"ratey"]];
                } else {
                    [cell createTitleLabelWithRatetimex:[self.typeDic objectForKey:@"ratetimex"]
                                             moneyApply:[self.typeDic objectForKey:@"applyMoney"]];
                }
            }
            return cell;
        }
        
        DaiKuanInfoTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DaiKuanInfoTableViewCell"];
        if (! cell) {
            cell = [[DaiKuanInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"DaiKuanInfoTableViewCell"];
        }
        [cell.infoText setTag:indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.infoText setDelegate:self];
        
        if (indexPath.row == 2 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 14 || indexPath.row == 21 || indexPath.row == 25) {
            [cell.infoText setKeyboardType:UIKeyboardTypeNumberPad];
        }
        
        if (indexPath.row == 3 || indexPath.row == 13 || indexPath.row == 15 || indexPath.row == 21 || indexPath.row == 25) {
            cell.infoText.inputView = [[UIView alloc] initWithFrame:CGRectZero];
            if (indexPath.row == 3) {
                [cell.infoText setText:self.submit.HuanKuanFangShi];
                UIButton * infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [infoButton setBackgroundImage:[UIImage imageNamed:@"apply_sm"] forState:UIControlStateNormal];
                [infoButton addTarget:self action:@selector(introduceAction : ) forControlEvents:UIControlEventTouchUpInside];
                [infoButton setFrame:CGRectMake(0, 0, 30, 30)];
                [cell setAccessoryView:infoButton];
            }
        }
        if (indexPath.row > 1 && indexPath.row < 4) {
            [cell.titleLabel setText:[self.titleArr objectAtIndex:indexPath.row - 2]];
            [cell.infoText setPlaceholder:[self.placeHolderArr objectAtIndex:indexPath.row - 2]];
            if (indexPath.row == 2) {
                [cell.infoText setPlaceholder:[NSString stringWithFormat:@"最多贷款金额为%@元", [[self.receiveDic objectForKey:@"data"] objectForKey:@"tuition"]]];
                [cell.infoText setText:self.submit.DaiKuanEDu];
            }
        }
        if (indexPath.row > 5 && indexPath.row < 19) {
            if (indexPath.row == 6) {
                [cell.infoText setText:self.submit.userName];
            } else if (indexPath.row == 7) {
                [cell.infoText setText:self.submit.userIDCard];
            } else if (indexPath.row == 8) {
                [cell.infoText setText:self.submit.classInfo];
            } else if (indexPath.row == 9) {
                [cell.infoText setText:self.submit.userPhone];
                UIButton * yanZheng = [UIButton buttonWithType:UIButtonTypeCustom];
                [yanZheng setFrame:CGRectMake(SCREEN_WIDTH / 4 * 3, cell.titleLabel.frame.origin.y, SCREEN_WIDTH / 4, cell.titleLabel.frame.size.height)];
                [yanZheng.titleLabel setTextAlignment:NSTextAlignmentLeft];
                [yanZheng addTarget:self action:@selector(yangZhengAction : ) forControlEvents:UIControlEventTouchUpInside];
//                [yanZheng setBackgroundImage:[UIImage imageNamed:@"apply_getword_press"] forState:UIControlStateNormal];
                [yanZheng setImage:[UIImage imageNamed:@"getword_nor"] forState:UIControlStateNormal];
                [yanZheng setTag:99];
                [cell.contentView addSubview:yanZheng];
                [cell.infoText setFrame:CGRectMake(cell.infoText.frame.origin.x, cell.infoText.frame.origin.y, cell.infoText.frame.size.width - yanZheng.frame.size.width, cell.infoText.frame.size.height)];
            } else if (indexPath.row == 10) {
                [cell.infoText setText:self.submit.yanZhengMa];
            } else if (indexPath.row == 11) {
                [cell.infoText setText:self.submit.userWeiXin];
            } else if (indexPath.row == 12) {
                [cell.infoText setText:self.submit.userYouXiang];
            } else if (indexPath.row == 13) {
                [cell.infoText setText:self.submit.userYinHang];
            } else if (indexPath.row == 14) {
                [cell.infoText setText:self.submit.userYinHangKaHao];
            } else if (indexPath.row == 15) {
                [cell.infoText setText:self.submit.userGongZuoZhuangTai];
            } else if (indexPath.row == 16) {
                [cell.infoText setText:self.submit.userGongZuoMingChengi];
            } else if (indexPath.row == 17) {
                [cell.infoText setText:self.submit.userGongZuoDiZhi];
            } else if (indexPath.row == 18) {
                [cell.infoText setText:self.submit.userGongZuoDianHua];
            }
            [cell.titleLabel setText:[self.titleArr objectAtIndex:indexPath.row - 4]];
            [cell.infoText setPlaceholder:[self.placeHolderArr objectAtIndex:indexPath.row - 4]];
        }
        if (indexPath.row > 19 && indexPath.row < 23) {
            if (indexPath.row == 20) {
                [cell.infoText setText:self.submit.firstConnectName];
            } else if (indexPath.row == 21) {
                [cell.infoText setText:self.submit.firstConnectRelationship];
            } else if (indexPath.row == 22) {
                [cell.infoText setText:self.submit.firstConnectPhone];
            }
            [cell.titleLabel setText:[self.titleArr objectAtIndex:indexPath.row - 5]];
            [cell.infoText setPlaceholder:[self.placeHolderArr objectAtIndex:indexPath.row - 5]];
        }
        if (indexPath.row > 23) {
            if (indexPath.row == 24) {
                [cell.infoText setText:self.submit.secondConnectName];
            } else if (indexPath.row == 25) {
                [cell.infoText setText:self.submit.secondConnectRelationship];
            } else if (indexPath.row == 26) {
                [cell.infoText setText:self.submit.secondConnectPhone];
            }
            [cell.titleLabel setText:[self.titleArr objectAtIndex:indexPath.row - 6]];
            [cell.infoText setPlaceholder:[self.placeHolderArr objectAtIndex:indexPath.row - 6]];
        }
        return cell;
    }
    MyInfoTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyInfoTableViewCell"];
    if (! cell) {
        cell = [[MyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"MyInfoTableViewCell"];
    }
    switch (indexPath.row) {
        case 0:
            if ([self.submit.imageDic objectForKey:@"IDCardZheng"] == nil) {
                [cell.userPhoto setImage:[UIImage imageNamed:@"addPicture"]];
            } else
                [cell.userPhoto setImage:[UIImage imageWithData:[self.submit.imageDic objectForKey:@"IDCardZheng"]]];
            break;
        case 1:
            if ([self.submit.imageDic objectForKey:@"IDCardFan"] == nil) {
                [cell.userPhoto setImage:[UIImage imageNamed:@"addPicture"]];
            } else
                [cell.userPhoto setImage:[UIImage imageWithData:[self.submit.imageDic objectForKey:@"IDCardFan"]]];
            break;
        case 2:
            if ([self.submit.imageDic objectForKey:@"yingHangKai"] == nil) {
                [cell.userPhoto setImage:[UIImage imageNamed:@"addPicture"]];
            } else
                [cell.userPhoto setImage:[UIImage imageWithData:[self.submit.imageDic objectForKey:@"yingHangKai"]]];
            break;
        case 3:
            if ([self.submit.imageDic objectForKey:@"ChangJingZhao"] == nil) {
                [cell.userPhoto setImage:[UIImage imageNamed:@"addPicture"]];
            } else
                [cell.userPhoto setImage:[UIImage imageWithData:[self.submit.imageDic objectForKey:@"ChangJingZhao"]]];
            break;
        default:
            break;
    }
    [cell.textLabel setText:[self.pictureCellTitlel objectAtIndex:indexPath.row]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
    [cell.userPhoto setTag:indexPath.row + 100];       ///照片的tag值为100~103
    [cell.userPhoto setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 19 || indexPath.row == 23) {
            return 30;
        }
        if (indexPath.row == 4) {
            return 190;
        }
        return 70;
    }
    return SCREEN_WIDTH / 7 + 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 27;
    } if (section == 1) {
        return 4;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    } if (section == 2) {
        return 130;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    [backView setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
    
    UIButton * xieYi = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30 * SCREEN_HEIGHT / 568)];
    [xieYi setTitle:@"我已经阅读《贷款协议》并自愿提交贷款申请" forState:UIControlStateNormal];
    [xieYi setTitleColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1] forState:UIControlStateNormal];
    [xieYi.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [xieYi.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [xieYi.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [xieYi addTarget:self action:@selector(xieYiAction : ) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:xieYi];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20 * SCREEN_WIDTH / 320, xieYi.frame.size.height *  1.5 + xieYi.frame.origin.y, SCREEN_WIDTH - 2 * (20 * SCREEN_WIDTH / 320), 40 * SCREEN_HEIGHT / 568)];
    [button addTarget:self action:@selector(submitAction :) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"sureButton"] forState:UIControlStateNormal];
    [backView addSubview:button];
    
    UIView * titleBack = [[UIView alloc] init];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 30)];
    [titleBack setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
    [titleView setText:@"上传资料"];
    [titleBack addSubview:titleView];
    
    if (section == 1) {
        return titleBack;
    }
    
    if (section == 2) {
        return backView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self.actionSheet showInView:self.view];
        self.tempImage = (UIImageView *)[[self.mainTable cellForRowAtIndexPath:indexPath].contentView viewWithTag:indexPath.row + 100];
    }
}


#pragma mark -
#pragma mark UITexeField代理方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.tempTextField = textField;
    [self createPickerView];
    
    if (textField.tag == 3) {
        if ([self.submit.DaiKuanEDu isEqual:@""]) {
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示"message:@"你要填写贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        } else if ([self.submit.DaiKuanEDu floatValue] > 0.0) {
            self.choiceArr = [NSMutableArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"loanTypes"]];
            [self.view addSubview:self.pickerViewBackGround];
        } else {
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示"message:@"贷款金额不合法" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
    if (textField.tag == 13) {
        self.choiceArr = [NSMutableArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"banks"]];
        [self.view addSubview:self.pickerViewBackGround];
    }
    if (textField.tag == 15) {
        self.choiceArr = [NSMutableArray arrayWithArray:self.workStyle];
        [self.view addSubview:self.pickerViewBackGround];
    }
    if (textField.tag == 21) {
        self.choiceArr = [NSMutableArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"relation"]];
        [self.view addSubview:self.pickerViewBackGround];
    }
    if (textField.tag == 25) {
        self.choiceArr = [NSMutableArray arrayWithArray:[[self.receiveDic objectForKey:@"data"] objectForKey:@"relation"]];
        [self.view addSubview:self.pickerViewBackGround];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tempTextField = textField;
    if (textField.tag == 2) {
        if ([textField.text integerValue] > [[[self.receiveDic objectForKey:@"data"] objectForKey:@"tuition"] integerValue]) {
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"贷款金额太多了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            [textField setText:[[self.receiveDic objectForKey:@"data"] objectForKey:@"tuition"]];
            self.submit.DaiKuanEDu = textField.text;
        } else {
            self.submit.DaiKuanEDu = textField.text;
            
        }
    }
    else if (textField.tag == 6) {
        self.submit.userName = textField.text;
    } else if (textField.tag == 7) {
        self.submit.userIDCard = textField.text;
    } else if (textField.tag == 8) {
        self.submit.classInfo = textField.text;
    } else if (textField.tag == 9) {
        self.submit.userPhone = textField.text;
    } else if (textField.tag == 10) {
        self.submit.yanZhengMa = textField.text;
        [self isValidateChkCode:textField.text andPhone:self.submit.userPhone];
    } else if (textField.tag == 11) {
        self.submit.userWeiXin = textField.text;
    } else if (textField.tag == 12) {
        self.submit.userYouXiang = textField.text;
    } else if (textField.tag == 14) {
        self.submit.userYinHangKaHao = textField.text;
    } else if (textField.tag == 16) {
        self.submit.userGongZuoMingChengi = textField.text;
    } else if (textField.tag == 17) {
        self.submit.userGongZuoDiZhi = textField.text;
    } else if (textField.tag == 18) {
        self.submit.userGongZuoDianHua = textField.text;
    } else if (textField.tag == 20) {
        self.submit.firstConnectName = textField.text;
    } else if (textField.tag == 22) {
        self.submit.firstConnectPhone = textField.text;
    } else if (textField.tag == 24) {
        self.submit.secondConnectName = textField.text;
    } else if (textField.tag == 26) {
        self.submit.secondConnectPhone = textField.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark UIPickerView协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.choiceArr count];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:25]];
    if (self.tempTextField.tag == 3) {
        [label setText:[[self.choiceArr objectAtIndex:row] objectForKey:@"name"]];
    } else if (self.tempTextField.tag == 13) {
        [label setText:[[self.choiceArr objectAtIndex:row] objectForKey:@"bankname"]];
    } else {
        [label setText:[self.choiceArr objectAtIndex:row]];
    }
    return label;
}


#pragma mark -
#pragma mark UIActionSheet协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self takePhoto];
            break;
            
        case 1:
            [self LocalPhoto];
            break;
    }
}


#pragma mark -
#pragma mark UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    switch (self.tempImage.tag) {
        case 100:
            [self.submit.imageDic setObject:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.00001) forKey:@"IDCardZheng"];
            break;
        case 101:
            [self.submit.imageDic setObject:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.00001) forKey:@"IDCardFan"];
            break;
        case 102:
            [self.submit.imageDic setObject:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.00001) forKey:@"yingHangKai"];
            break;
        case 103:
            [self.submit.imageDic setObject:UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 0.00001) forKey:@"ChangJingZhao"];
            break;
        default:
            break;
    }
    NSLog(@"****************************************************************************************************************************");
    NSLog(@"身份证正面++++++++++++++%ld", [[self.submit.imageDic objectForKey:@"IDCardZheng"] length] / 1024);
    NSLog(@"身份证反面++++++++++++++%ld", [[self.submit.imageDic objectForKey:@"IDCardFan"] length] / 1024);
    NSLog(@"银行卡正面++++++++++++++%ld", [[self.submit.imageDic objectForKey:@"yingHangKai"] length] / 1024);
    NSLog(@"场景照++++++++++++++%ld", [[self.submit.imageDic objectForKey:@"ChangJingZhao"] length] / 1024);
    NSLog(@"****************************************************************************************************************************");
    [self.mainTable reloadData];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark 带有选择器的视图的创建
- (void) createPickerView
{
    self.pickerViewBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.pickerViewBackGround setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    UIView * aeroView = [[UIView alloc] init];
    [aeroView setBackgroundColor:[UIColor whiteColor]];
    [aeroView setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 200)];
    [aeroView setClipsToBounds:YES];
    [aeroView.layer setCornerRadius:10];
    [aeroView setCenter:self.pickerViewBackGround.center];
    [self.pickerViewBackGround addSubview:aeroView];
    
    self.infoPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, aeroView.frame.size.width, aeroView.frame.size.height / 5)];
    [self.infoPicker setDelegate:self];
    [self.infoPicker setDataSource:self];
    [aeroView addSubview:self.infoPicker];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(0 , self.infoPicker.frame.origin.y + self.infoPicker.frame.size.height, self.infoPicker.frame.size.width, aeroView.frame.size.height - self.infoPicker.frame.size.height)];
    [sureButton setTitle:@"确定"forState:UIControlStateNormal];
    [sureButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [sureButton setTitleColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction : ) forControlEvents:UIControlEventTouchUpInside];
    [aeroView addSubview:sureButton];
}


#pragma mark -
#pragma mark开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker.sourceType = sourceType;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


#pragma mark -
#pragma mark打开本地相册
-(void)LocalPhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}


#pragma mark -
#pragma mark 发送验证码点击事件
- (void) yangZhengAction : (UIButton * ) sender
{
  
    UITextField * textfield = (UITextField * )[self.view viewWithTag:9];

        if (![textfield.text isEqual:@""]) {
            NSString *path = [API_SENDSMS_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"sent",@"tp",textfield.text,@"tel", nil];
            ((AppDelegate*)([UIApplication sharedApplication].delegate)).timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
                [SVProgressHUD showSuccessWithStatus:@"验证码发送成功." duration:1.0f];
                return;
            } failuer:^(NSError *error) {
                return;
            }];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先输入手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
}

- (void)countDown:(NSTimer *)theTimer{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:99];
    if (seconds == 0) {
        [theTimer invalidate];
        [btn setTitle:@"" forState:UIControlStateNormal];
        seconds = 60;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setEnabled:YES];
        [btn setImage:[UIImage imageNamed:@"apply_getword_press"] forState:UIControlStateNormal];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",seconds];
        [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [btn setTitleColor:R_G_B_A_COLOR(145, 185, 35, 1) forState:UIControlStateNormal];
        [btn setEnabled:NO];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark 确定按钮点击事件
- (void) sureButtonAction : (UIButton * ) sender
{
    if (self.tempTextField.tag == 3) {

        [self.tempTextField setText:[[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"name"]];
        self.submit.HuanKuanFangShi = [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"name"];
        self.submit.huanKuanDate = [NSString stringWithFormat:@"每月%@号为还款期", [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"repaymentday"]];
        self.submit.HuanKuanID = [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"rateid"];
        self.submit.introduce = [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"desp"];
        self.typeDic = [NSMutableDictionary dictionaryWithDictionary:[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]]];
        [self.typeDic setObject:self.submit.DaiKuanEDu forKey:@"applyMoney"];
        [self.mainTable reloadData];
    } else if (self.tempTextField.tag == 13) {
        [self.tempTextField setText:[[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"bankname"]];
        self.submit.userYinHang = [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"bankname"];
        self.submit.userYinHangID = [[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] objectForKey:@"bankcode"];
    } else if (self.tempTextField.tag == 15) {
        [self.tempTextField setText:[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]]];
        self.submit.userGongZuoZhuangTai = [self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]];
        if ([[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] isEqualToString:@"无业"]) {
            self.submit.userGongZuoZhuangTaiID = @"0";
        } else if ([[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] isEqualToString:@"在职"]) {
            self.submit.userGongZuoZhuangTaiID = @"1";
        } else if ([[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]] isEqualToString:@"学生"]) {
            self.submit.userGongZuoZhuangTaiID = @"2";
        }
    } else if (self.tempTextField.tag == 21) {
        [self.tempTextField setText:[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]]];
        self.submit.firstConnectRelationship = [self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]];
    } else if (self.tempTextField.tag == 25) {
        [self.tempTextField setText:[self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]]];
        self.submit.secondConnectRelationship = [self.choiceArr objectAtIndex:[self.infoPicker selectedRowInComponent:0]];
    }
    [self.tempTextField resignFirstResponder];
    [self.pickerViewBackGround removeFromSuperview];
}


#pragma mark -
#pragma mark 信息上传按钮点击事件
- (void) submitAction : (UIButton *) sender
{
    NSDictionary * sendDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                              self.submit.DaiKuanEDu, @"money_apply",
                              self.submit.HuanKuanID, @"loan_type",
                              self.submit.userName, @"idcard_name",
                              self.submit.userIDCard, @"idcard",
                              self.submit.userPhone, @"phone",
                              self.submit.userWeiXin, @"wechat",
                              self.submit.userYouXiang, @"email",
                              self.submit.userYinHangID, @"bank_id",
                              self.submit.userYinHangKaHao, @"bank_account",
                              self.submit.userGongZuoZhuangTaiID, @"work_type",
                              self.submit.userGongZuoMingChengi, @"work_name",
                              self.submit.userGongZuoDiZhi, @"work_address",
                              self.submit.userGongZuoDianHua, @"work_phone",
                              self.submit.firstConnectName, @"contact1",
                              self.submit.firstConnectRelationship, @"contact1_relation",
                              self.submit.firstConnectPhone, @"contact1_phone",
                              self.submit.secondConnectName, @"contact2",
                              self.submit.secondConnectRelationship, @"contact2_relation",
                              self.submit.secondConnectPhone, @"contact2_phone",
                              [NSString stringWithFormat:@"%ld", (long)self.lessonID], @"cid",
                              self.submit.classInfo, @"class", nil];    //表单信息！！！
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:[self.submit.imageDic objectForKey:@"IDCardZheng"], [self.submit.imageDic objectForKey:@"IDCardFan"], [self.submit.imageDic objectForKey:@"yingHangKai"], [self.submit.imageDic objectForKey:@"ChangJingZhao"], nil];     //图片数组！！！！
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    if ([[sendDic allValues] count] < 21 || [arr count] < 4 || self.submit.yanZhengMa == nil) {
        
        [SVProgressHUD dismissWithError:@"信息不完整" afterDelay:2];
    } else {
        [Connect connectDATAWithURL:API_LOAN_REQUEST parames:sendDic imageArr:arr succeed:^(NSMutableDictionary *dic) {
            if ([[dic objectForKey:@"code"] integerValue] == 0) {
                [SVProgressHUD dismissWithSuccess:@"提交成功" afterDelay:0.5];
                NSLog(@"翔哥返回的信息是   ====================   %@", dic);
                
                SuccessViewController * successVC = [[SuccessViewController alloc] init];
                
                successVC.lessonName = self.name;
                successVC.schoolName = self.school;
                successVC.schoolAddress = self.address;
                successVC.hour = self.hour;
                successVC.price = self.price;
                successVC.daiKuanFenQi = self.submit.HuanKuanFangShi;
                successVC.lessonInfo = self.sendVC;
                
                [self.navigationController pushViewController:successVC animated:YES];
                
            } else {
                [SVProgressHUD dismissWithError:@"提交失败" afterDelay:0.5];
                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
        } failure:^(NSError *connectError) {
            NSLog(@"提交失败--------%@", connectError);
        }];
    }
    
    NSLog(@"我上传了哇哈哈哈哈哈 ============================== %@", sendDic);
}

#pragma mark -
#pragma mark 贷款协议按钮点击事件
- (void) xieYiAction : (UIButton * )sender
{
    XieYiViewController * xiYiVC = [[XieYiViewController alloc] init];
    if (self.typeDic != nil) {
        if ([[self.typeDic objectForKey:@"ratetype"]  isEqual: @"1"]) {
            xiYiVC.url = API_TANXING_XIEYI;
        } else {
            xiYiVC.url = API_TIEXI_XIEYI;
        }
        [self.navigationController pushViewController:xiYiVC animated:YES];
        return;
    }
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没选择还款方式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    
}


#pragma mark - 
#pragma mark 说明按钮点击事件
- (void) introduceAction : (UIButton * ) sender
{
    if (self.submit.introduce == nil) {
        UIAlertView * introduce = [[UIAlertView alloc] initWithTitle:@"提示" message:@"还没有选择还款方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [introduce show];
    } else {
        UIAlertView * introduce = [[UIAlertView alloc] initWithTitle:@"说明" message:self.submit.introduce delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [introduce show];
    }
}

#pragma mark -
#pragma mark - 校验验证码
- (void)isValidateChkCode:(NSString *)code andPhone:(NSString *)phone{
    
    NSString *path = [API_SENDSMS_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"ckco",@"tp",phone,@"tel",code,@"co", nil];
    [Connect connectPOSTWithURL:path parames:dict connectBlock:^(NSMutableDictionary *dic) {
        NSLog(@"isValidateChkCode======%@",dic);
        NSString *result = [[dic objectForKey:@"data"] objectForKey:@"result"]; //result=0验证码可用
        NSLog(@"isOK........%@",result);
        
        if ([result integerValue] == 1 ) {
            [SVProgressHUD showErrorWithStatus:@"验证码不正确." duration:1.0];
            self.submit.yanZhengMa = nil;
            [self.mainTable reloadData];
            return ;
        }else{
            
        }
    } failuer:^(NSError *error) {
        NSLog(@"%@",error);
        return ;
    }];
}
@end
