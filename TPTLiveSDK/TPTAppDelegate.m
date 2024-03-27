//
//  TPTAppDelegate.m
//  TPTLiveSDK
//
//  Created by Napiac on 03/26/2024.
//  Copyright (c) 2024 Napiac. All rights reserved.
//

#import "TPTAppDelegate.h"
#import <TPTLiveBusinessMoudle/TPTLiveFrameworkBuilder.h>
#import <TPTLiveBusinessMoudle/TPTLiveFrameworkBuilderConfig.h>
#import "TPTViewController.h"

@implementation TPTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    TPTLiveFrameworkBuilderConfig * liveSDKConfig = [TPTLiveFrameworkBuilderConfig new];
    liveSDKConfig.partnerKey = @"x";
    liveSDKConfig.apiHost = @"x";
    NSError * error = [TPTLiveFrameworkBuilder appDidLaunch:liveSDKConfig];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    TPTViewController * videoHomePageVc = [[TPTViewController alloc] init];
    UINavigationController * commonNavigationController = [[UINavigationController alloc] initWithRootViewController:videoHomePageVc];
    self.window.rootViewController = commonNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
