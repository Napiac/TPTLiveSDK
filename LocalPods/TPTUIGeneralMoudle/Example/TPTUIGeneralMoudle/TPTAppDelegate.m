//
//  TPTAppDelegate.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 07/29/2022.
//  Copyright (c) 2022 Napiac. All rights reserved.
//

#import "TPTAppDelegate.h"
#import <TPTCoreMoudle/UICommonNavigationController.h>
#import "TPTViewController.h"
#import <TPTUIGeneralMoudle/UIGeneralDrawerMenuController.h>
#import <TPTUIGeneralMoudle/DrawerMenuVisualStateManager.h>
#import "TPTRightMenuViewController.h"
#import "TPTLeftMenuViewController.h"
@implementation TPTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    TPTViewController * viewController = [[TPTViewController alloc] init];
    UICommonNavigationController * navigationController = [[UICommonNavigationController alloc] initWithRootViewController:viewController];
    
    
    TPTRightMenuViewController * rightMenuController = [[TPTRightMenuViewController alloc] init];
    TPTLeftMenuViewController * leftMenuController = [[TPTLeftMenuViewController alloc] init];

    UIGeneralDrawerMenuController * menuController = [[UIGeneralDrawerMenuController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftMenuController rightDrawerViewController:rightMenuController];
    
    [menuController setDrawerVisualStateBlock:^(UIGeneralDrawerMenuController *drawerController, DrawerMenuSide drawerSide, CGFloat percentVisible) {
        DrawerControllerDrawerVisualStateBlock block = [[DrawerMenuVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
        
    }];
    [menuController setShowsShadow:NO];
    [menuController setMaximumRightDrawerWidth:200.0];
    [menuController setOpenDrawerGestureModeMask:OpenDrawerGestureModeAll];
    [menuController setCloseDrawerGestureModeMask:CloseDrawerGestureModeAll];
    
    self.window.rootViewController = menuController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
