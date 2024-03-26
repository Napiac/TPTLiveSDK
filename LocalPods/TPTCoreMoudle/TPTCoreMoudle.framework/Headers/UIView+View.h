//
//  UIView+View.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (View)

/// 找到当前view所在的viewcontroler
@property(readonly)UIViewController * currentVC;


/// 找到当前view所在的navigationController
@property(readonly)UINavigationController * currentNavigationVC;


/// 找到当前view所在的tabBarController
@property(readonly)UITabBarController * currentTabbarVC;



///layer做圆角
- (void)cornerRadius:(CGFloat)radius;

/// layer做圆角、边框
/// @param radius 圆角
/// @param size 边框线条大小
/// @param color 边框颜色
- (void)cornerRadius:(CGFloat)radius
          strokeSize:(CGFloat)size
               color:(UIColor *)color;


/// layer做阴影
/// @param color 阴影颜色
/// @param offset 阴影偏移
/// @param opacity 阴影透明度
/// @param radius 阴影投影大小
- (void)shadowWithColor:(UIColor *)color
                 offset:(CGSize)offset
                opacity:(CGFloat)opacity
                 radius:(CGFloat)radius;


/// UIBezierPath做圆角
/// @param corners 圆角范围
/// @param radius 圆角大小
- (void)setRoundedCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius;

/// 当前View是否屏幕可见
- (BOOL)isDisplayedInScreen;



/// 改变NSLayoutConstraint的mutiplier参数
/// @param constraint NSLayoutConstraint
/// @param multiplier multiplier
- (NSLayoutConstraint *)changeMultiplierOfConstraint:(NSLayoutConstraint *)constraint
                                          multiplier:(CGFloat)multiplier;
@end

NS_ASSUME_NONNULL_END
