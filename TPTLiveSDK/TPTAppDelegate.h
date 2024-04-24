//
//  TPTAppDelegate.h
//  TPTLiveSDK
//
//  Created by Napiac on 03/26/2024.
//  Copyright (c) 2024 Napiac. All rights reserved.
//

@import UIKit;

@interface TPTAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

+ (TPTAppDelegate *)sharedAppDelegate;


- (void)postUpdateUserBalance;

/// 待用户消费ws的通知 <测试时使用>
- (void)connectConsumptionModeListener;
- (void)disconnectConsumptionModeListener;

@end
