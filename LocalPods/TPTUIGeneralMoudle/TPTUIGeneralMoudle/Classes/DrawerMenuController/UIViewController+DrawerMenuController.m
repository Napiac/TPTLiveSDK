//
//  UIViewController+DrawerMenuController.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

#import "UIViewController+DrawerMenuController.h"

@implementation UIViewController (DrawerMenuController)


-(UIGeneralDrawerMenuController*)drawerMenuController{
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if([parentViewController isKindOfClass:[UIGeneralDrawerMenuController class]]){
            return (UIGeneralDrawerMenuController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

-(CGRect)visibleDrawerFrame{
    if([self isEqual:self.drawerMenuController.leftDrawerViewController] ||
       [self.navigationController isEqual:self.drawerMenuController.leftDrawerViewController]){
        CGRect rect = self.drawerMenuController.view.bounds;
        rect.size.width = self.drawerMenuController.maximumLeftDrawerWidth;
        if (self.drawerMenuController.showsStatusBarBackgroundView) {
            rect.size.height -= 20.0f;
        }
        return rect;
        
    }
    else if([self isEqual:self.drawerMenuController.rightDrawerViewController] ||
             [self.navigationController isEqual:self.drawerMenuController.rightDrawerViewController]){
        CGRect rect = self.drawerMenuController.view.bounds;
        rect.size.width = self.drawerMenuController.maximumRightDrawerWidth;
        rect.origin.x = CGRectGetWidth(self.drawerMenuController.view.bounds)-rect.size.width;
        if (self.drawerMenuController.showsStatusBarBackgroundView) {
            rect.size.height -= 20.0f;
        }
        return rect;
    }
    else {
        return CGRectNull;
    }
}

@end
