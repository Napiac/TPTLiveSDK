//
//  UIViewController+DrawerMenuController.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

#import <UIKit/UIKit.h>

#import "UIGeneralDrawerMenuController.h"

@interface UIViewController (DrawerMenuController)

///---------------------------------------
/// @name Accessing Drawer View Controller Properties
///---------------------------------------

/**
 The `UIGeneralDrawerMenuController` that the view controller is contained within. If the view controller is not contained within a `UIGeneralDrawerMenuController`, this property is nil. Note that if the view controller is contained within a `UINavigationController`, that navigation controller is contained within a `UIGeneralDrawerMenuController`, this property will return a refernce to the `UIGeneralDrawerMenuController`, despite the fact that it is not the direct parent of the view controller.
 */
@property(nonatomic, strong, readonly) UIGeneralDrawerMenuController *drawerMenuController;

/**
 The visible rect of the side drawer view controller in the drawer controller coordinate space. If the view controller is not a drawer in a `UIGeneralDrawerMenuController`, then this property returns `CGRectNull`
 */
@property(nonatomic, assign, readonly) CGRect visibleDrawerFrame;

@end
