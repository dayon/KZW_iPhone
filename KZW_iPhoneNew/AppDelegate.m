//
//  AppDelegate.m
//  KZW_iPhoneNew
//
//  Created by 张宁浩 on 15/5/14.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import <QZoneConnection/ISSQZoneApp.h>
#import <FacebookConnection/ISSFacebookApp.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>

#import <Pinterest/Pinterest.h>
#import "YXApi.h"
#import "APService.h"

#import "MyViewController.h"
#import "Tool.h"
#import "CheckNetwork.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



#pragma mark -
#pragma mark 获取了token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviceTokenStr is ============ %@",deviceToken);
}

#pragma mark -
#pragma mark 点击通知事件
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"我收到的推送信息是====================%@", userInfo);
    if ([[userInfo objectForKey:@"isPush"] isEqualToString:@"yes"]) {
        MyViewController * my = [[MyViewController alloc] init];
        [self.rootNAV pushViewController:my animated:YES];
    }
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    
    
    [ShareSDK registerApp:@"783baf83c903"];
    
    [self initializePlat];
    
    
    MainViewController * mainVC  = [[MainViewController alloc] init];
    

    self.rootNAV = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    
    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
    if ([self.rootNAV.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.rootNAV.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden = YES;
            }
        }
    }
    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
    
    //    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:14 / 255.0 green:103 / 255.0 blue:188 / 255.0 alpha:1]];
    [self.rootNAV.navigationBar setTintColor:[UIColor whiteColor]];
    [self.rootNAV.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset, [UIFont boldSystemFontOfSize:18], UITextAttributeFont, nil]];
    
    
    [self initLoginStatus];
    
    [self.window setRootViewController:self.rootNAV];
            NSDictionary *userInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo != nil) {
        [self.rootNAV pushViewController:[[MyViewController alloc] init] animated:YES];
    }
    
    
    [NSThread sleepForTimeInterval:2];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark 初始化社交平台
- (void) initializePlat
{

  
//    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104608241"
                           appSecret:@"uVIcPeeA6ademKRC"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
//
//    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1104608241"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectSinaWeiboWithAppKey:@"2709421231"
//                               appSecret:@"68b090dd36f491ec9630b61693ccbee3"
//                             redirectUri:@"http://www.sharesdk.cn"];
    
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"2709421231"
                                appSecret:@"68b090dd36f491ec9630b61693ccbee3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801565995"
                                  appSecret:@"4eec6bb838de65e06acc8839996e5b02"
                                redirectUri:@"http://kezhanwang.cn"
                                   wbApiCls:[WeiboApi class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx944d1e39c6971a78"
                           appSecret:@"7f675a0d3a6cb4d0f4cbc8cd1e856f9e"
                           wechatCls:[WXApi class]];

 }


#pragma mark -
#pragma mark 授权回调
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


#pragma mark - 
#pragma mark 登录态判断
- (void)initLoginStatus{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    _userName = [userDefaultes stringForKey:@"usrName"];
    _userId = [userDefaultes stringForKey:@"usrId"];
    _kzuser = [userDefaultes stringForKey:@"kzuser"];
    
    if (_userName != nil && _userId != nil && _kzuser != nil) {
        
        self.isLoginStatus = YES;
    }else{
        self.isLoginStatus = NO;
    }
 
}
@end
