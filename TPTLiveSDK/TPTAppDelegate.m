//
//  TPTAppDelegate.m
//  TPTLiveSDK
//
//  Created by Napiac on 03/26/2024.
//  Copyright (c) 2024 Napiac. All rights reserved.
//

#import "TPTAppDelegate.h"
#import <TPTLiveBusinessMoudle/TPTLiveFramework.h>
#import <TPTCoreMoudle/UICommonNavigationController.h>
#import <TPTCoreMoudle/NSObject+Toast.h>
#import <TPTGeneralWebsocketBusinessModule/GeneralWebSocketClient.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TPTLiveSDKExampleViewController.h"

@interface TPTAppDelegate ()<GeneralWebSocketClientDelegate>
@property(nonatomic, strong)GeneralWebSocketClient * wsClient;

@end

@implementation TPTAppDelegate

+ (TPTAppDelegate *)sharedAppDelegate {
    return ((TPTAppDelegate *)[UIApplication sharedApplication].delegate);
}

- (void)postUpdateUserBalance {}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// 初始化SDK <测试参数>
    TPTLiveFrameworkBuilderConfig * buildConfig = [TPTLiveFrameworkBuilderConfig new];
    buildConfig.partnerKey = @"P202404209031";
    buildConfig.partnerSecret = @"41ee5228183cb36cd2bc86bd96e74d79";
    buildConfig.partnerApiHost = @"http://106.55.103.148:8000";
    buildConfig.tencentLicenseURL = @"https://x";
    buildConfig.tencentLicenseKey = @"x";
    buildConfig.rechargeEventHandler = ^(UINavigationController * _Nullable navigationController, UIView * _Nullable sender) {
        [NSObject showToast:@"用户点击了去充值"];
    };
    NSError * error = [TPTLiveFrameworkBuilder appDidLaunch:buildConfig];
    if (error.code == SDKOKCode) {
        
    } else {
        if (error.code == SDKParamsErrorCode) {
            /// 参数错误 - 可以查看具体哪个参数有问题
        }
        if (error.code == SDKInitErrorCode) {
            /// 初始化错误
        }
    }

    [self connectConsumptionModeListener];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    TPTLiveSDKExampleViewController * exampleVc = [[TPTLiveSDKExampleViewController alloc] init];
    UICommonNavigationController * commonNavigationController = [[UICommonNavigationController alloc] initWithRootViewController:exampleVc];
    self.window.rootViewController = commonNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


/// 待用户消费ws的通知 <测试时使用>
- (void)connectConsumptionModeListener {
    [self disconnectConsumptionModeListener];
    NSString * channelUserId = [TPTLiveSDKExampleViewController channelUserId];
    if (channelUserId.length == 0) return;
    self.wsClient = [GeneralWebSocketClient socketURLString:[NSString stringWithFormat:@"ws://106.55.103.148:8006?user_id=%@",channelUserId]];
    self.wsClient.delegate = self;
}

- (void)disconnectConsumptionModeListener {
    if (!self.wsClient) return;
    [self.wsClient closeSocket];
}


#pragma mark -
#pragma mark - GeneralWebSocketClientDelegate

/// ws链接成功
- (void)socketDidOpen:(GeneralWebSocketClient *)socket {
    NSLog(@"待用户消费ws链接成功");
}

/// ws链接失败
- (void)socket:(GeneralWebSocketClient *)socket didFailWithError:(NSError *)error {
    NSLog(@"待用户消费ws链接失败");
    if (socket) {
        [socket closeSocket];
    }
}

/// ws收到消息
- (void)socket:(GeneralWebSocketClient *)socket receiveResponse:(GeneralWebSocketResponse *)response {
    if (!socket) return;
    NSLog(@"待用户消费ws收到消息：%@-%@",socket,response);
    if ([response.type isEqualToString:@"balance_update"]) {
        [self postUpdateUserBalance];
    }
}

@end
