//
//  KouBeiDetailViewController.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/29.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "KouBeiDetailViewController.h"

@interface KouBeiDetailViewController ()

@end

@implementation KouBeiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [backGround setImage:[UIImage imageNamed:@"mine_bg"]];
    [self.view addSubview:backGround];

    [self setTitle:@"评测详情"];
    
    NSLog(@"%@sadfsdafadsfadsfasdfasdfadsfasdfsdafsadfdsaf", self.mainDic);
    [self createView];
}




#pragma mark -
#pragma mark 创建视图
- (void) createView
{
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.mainScroll setContentSize:CGSizeMake(0, SCREEN_HEIGHT * 2)];
    [self.mainScroll setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScroll];
    
    self.userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.size.height * 0.5, self.titleLabel.frame.size.height * 1.5, 110, 110)];
    self.userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    [self.userPhoto setImageWithURL:[NSURL URLWithString:[self.mainDic objectForKey:@"analyst_head_pic"]]];
    [self.userPhoto setBackgroundColor:[UIColor lightGrayColor]];
    [self.mainScroll addSubview:self.userPhoto];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userPhoto.frame.origin.x * 2 + self.userPhoto.frame.size.width, self.userPhoto.frame.origin.y, SCREEN_WIDTH / 2, self.userPhoto.frame.size.height / 2)];
    [self.userName setTextColor:[UIColor colorWithRed:0 green:103 / 255.0 blue:191 / 255.0 alpha:1]];
    [self.userName setFont:[UIFont boldSystemFontOfSize:21]];
    [self.userName setText:[NSString stringWithFormat:@"%@  ✅", [self.mainDic objectForKey:@"analyst_name"]]];
    [self.mainScroll addSubview:self.userName];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userName.frame.origin.x, self.userName.frame.origin.y + self.userName.frame.size.height, SCREEN_WIDTH / 2, self.userPhoto.frame.size.height / 2)];
    [self.timeLabel setText:[self.mainDic objectForKey:@"ctime_desc"]];
    [self.timeLabel setFont:[UIFont systemFontOfSize:15]];
    [self.timeLabel setTextColor:[UIColor lightGrayColor]];
    [self.mainScroll addSubview:self.timeLabel];
    
    UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userPhoto.frame.origin.x, self.userPhoto.frame.origin.y + self.userPhoto.frame.size.height + 10, SCREEN_WIDTH - self.userPhoto.frame.origin.x * 2, self.timeLabel.frame.size.height)];
    [scoreLabel setText:@"TA的评分"];
    [scoreLabel setFont:[UIFont systemFontOfSize:20]];
    [self.mainScroll addSubview:scoreLabel];
    
    self.starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(scoreLabel.frame.size.width / 2, 0, scoreLabel.frame.size.width / 3, scoreLabel.frame.size.height) numberOfStars:5];
    [self.starView setScorePercent:[[self.mainDic objectForKey:@"score"] floatValue] / 5];
    [scoreLabel addSubview:self.starView];
   
    self.totalMark = [[UILabel alloc] initWithFrame:CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width + 10, self.starView.frame.origin.y, scoreLabel.frame.size.width - self.starView.frame.size.width - self.starView.frame.origin.x, self.starView.frame.size.height)];
    [self.totalMark setFont:[UIFont boldSystemFontOfSize:20]];
    [self.totalMark setAdjustsFontSizeToFitWidth:YES];
    [self.totalMark setText:[NSString stringWithFormat:@"%@分", [self.mainDic objectForKey:@"score"]]];
    [self.totalMark setTextColor:[UIColor colorWithRed:253 / 255.0 green:186 / 255.0 blue:45 / 255.0 alpha:1]];
    [scoreLabel addSubview:self.totalMark];
    
    
    
    self.backGroundView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userName.frame.origin.y + self.userName.frame.size.height * 3.5 + 10, SCREEN_WIDTH, self.userPhoto.frame.size.height * 4)];
    [self.mainScroll addSubview:self.backGroundView];
    
    for (int i = 0; i < 5; i ++) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + (SCREEN_WIDTH - 10) / 5 * i, self.userPhoto.frame.size.height * 3.5 , (SCREEN_WIDTH - 10) / 5, self.userPhoto.frame.size.height * 0.5)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTag:i + 10];     //tag值为10~14
        [titleLabel setText:@"暂无"];
        [self.backGroundView addSubview:titleLabel];
    }
    self.chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 170)];
    [self.mainScroll addSubview:self.chart];
    
    self.littleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.userPhoto.frame.origin.x, self.backGroundView.frame.origin.y + self.userPhoto.frame.size.height * 4.5, SCREEN_WIDTH - 2 * self.userPhoto.frame.origin.x, self.userPhoto.frame.size.height * 2.5)];
    [self.littleScroll setContentSize:CGSizeMake([[self.mainDic objectForKey:@"pic"] count] *200, 0)];
    [self.littleScroll setBackgroundColor:[UIColor whiteColor]];
    [self.mainScroll addSubview:self.littleScroll];
    
    for (int i = 0; i < [[self.mainDic objectForKey:@"pic"] count]; i ++) {
        self.scrollPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(i * 200, 0, 180, self.littleScroll.frame.size.height)];
        [self.scrollPhoto setBackgroundColor:[UIColor grayColor]];
        [self.scrollPhoto setImageWithURL:[NSURL URLWithString:[[self.mainDic objectForKey:@"pic"] objectAtIndex:i]]];
        [self.littleScroll addSubview:self.scrollPhoto];
    }
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userPhoto.frame.origin.x, self.littleScroll.frame.origin.y + self.littleScroll.frame.size.height + 10, SCREEN_WIDTH - 2 * self.userPhoto.frame.origin.x, 10)];
    UIFont * font = [UIFont systemFontOfSize:16];
    [self.infoLabel setFont:font];
    [self.infoLabel setNumberOfLines:0];
    NSString * text = [self.mainDic objectForKey:@"content"];
//    NSString *text = @" 和风熏柳，花香醉人，正是南国春光漫烂季节。福建省福州府西门大街，青石板路笔直的伸展出去，直通西门。一座建构宏伟的宅第之前，左右两座石坛中各竖一根两丈来高的旗杆，杆顶飘扬青旗。右首旗上黄色丝线绣着一头张牙舞爪、神态威猛的雄狮，旗子随风招展，显得雄狮更奕奕若生。雄狮头顶有一对黑丝线绣的蝙蝠展翅飞翔。左首旗上绣着“福威镖局”四个黑字，银钩铁划，刚劲非凡。大宅朱漆大门，门上茶杯大小的铜钉闪闪发光，门顶匾额写着“福威镖局”四个金漆大字，下面横书“总号”两个小字。进门处两排长凳，分坐着八名劲装结束的汉子，个个腰板笔挺，显出一股英悍之气。突然间后院马蹄声响，那八名汉子一齐站起，抢出大门。只见镖局西侧门中冲出五骑马来，沿着马道冲到大门之前。当先一匹马全身雪白，马勒脚镫都是烂银打就，鞍上一个锦衣少年，约莫十八九岁年纪，左肩上停着一头猎鹰，腰悬宝剑，背负长弓，泼喇喇纵马疾驰。身后跟随四骑，骑者一色青布短衣。一行五人驰到镖局门口，八名汉子中有三个齐声叫了起来：“少镖头又打猎去啦！”那少年哈哈一笑，马鞭在空中拍的一响，虚击声下，胯下白马昂首长嘶，在青石板大路上冲了出去。一名汉子叫道：“史镖头，今儿再抬头野猪回来，大伙儿好饱餐一顿。”那少年身后一名四十来岁的汉子笑道：“一条野猪尾巴少不了你的，可先别灌饱了黄汤。”众人大笑声中，五骑马早去得远了。五骑马一出城门，少镖头林平之双腿轻轻一挟，白马四蹄翻腾，直抢出去，片刻之间，便将后面四骑远远抛离。他纵马上了山坡，放起猎鹰，从林中赶了一对黄兔出来。他取下背上长弓，从鞍旁箭袋中取出一支雕翎，弯弓搭箭，刷的一声响，一头黄兔应声而倒，待要再射时，另一头兔却钻入草丛中不见了。郑镖头纵马赶到，笑道：“少镖头，好箭！”只听得趟子手白二在左首林中叫道：“少镖头，快来，这里有野鸡！”林平之纵马过去，只见林中飞出一只雉鸡，林平之刷的一箭，那野鸡对正了从他头顶飞来，这一箭竟没射中。林平之急提马鞭向半空中抽去，劲力到处，波的一声响，将那野鸡打了下来，五色羽毛四散飞舞。五人齐声大笑。史镖头道：“少镖头这一鞭，别说野鸡，便大兀鹰也打下来了！”五人在林中追逐鸟兽，史、郑两名镖头和趟子手白二、陈七凑少镖头的兴，总是将猎物赶到他身前，自己纵有良机，也不下手。打了两个多时辰，林平之又射了两只兔子，两只雉鸡，只是没打到野猪和獐子之类的大兽，兴犹未足，说道：“咱们到前边山里再找找去。”史镖头心想：“这一进山，凭着少镖头的性儿，非到天色全黑决不肯罢手，咱们回去可又得听夫人的埋怨。";
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(SCREEN_WIDTH - 2 * self.userPhoto.frame.origin.x, 1000000) lineBreakMode:UILineBreakModeWordWrap];
    CGRect rect = self.infoLabel.frame;
    rect.size = size;
    [self.infoLabel setFrame:rect];
    [self.infoLabel setText:text];
    
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [self.infoLabel setAttributedText:attributedString1];
    [self.infoLabel sizeToFit];
    
    
    [self.mainScroll addSubview:self.infoLabel];
    
    [self.mainScroll setContentSize:CGSizeMake(0, self.infoLabel.frame.origin.y + self.infoLabel.frame.size.height + 30)];
}


#pragma mark -
#pragma mark 创建评分视图
- (void)sendMarkWithArr:(NSMutableArray *)arr
{
    NSMutableArray * chartArr = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i ++) {
        UILabel * title = (UILabel *)[self.view viewWithTag:i + 10];
        [title setText:[[arr objectAtIndex:i] objectForKey:@"name"]];
        
        [chartArr addObject:[[arr objectAtIndex:i] objectForKey:@"score"]];
    }
    [self.chart setWithArr:chartArr];
}

@end
