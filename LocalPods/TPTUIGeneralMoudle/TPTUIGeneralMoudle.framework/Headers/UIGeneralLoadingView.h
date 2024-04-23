//
//  UIGeneralLoadingView.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/18.
//

#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import <TPTCoreMoudle/UICommonView.h>
NS_ASSUME_NONNULL_BEGIN


/// loadingview
@interface UIGeneralLoadingView : UICommonView


/// 初始化
/// @param loadingText 文本
- (instancetype)initWithLodingText:(NSString * _Nullable)loadingText;

/// 显示
/// @param view 父视图
- (void)showInView:(UIView *)view;

/// 移除
- (void)remove;

/// 几秒后移除
/// @param duration 时长
- (void)removeAfterDuration:(CGFloat)duration;

/// 初始化并显示一个loading
/// @param view 父视图
+ (UIGeneralLoadingView *)showLoadingInView:(UIView *)view;


/// 初始化并显示一个带文字的loading
/// @param view 父试图
/// @param loadingText 文字
+ (UIGeneralLoadingView *)showLoadingInView:(UIView *)view loadingText:(NSString * _Nullable)loadingText;

/// 移除view上的loading
/// @param view 父视图
+ (void)removeFromView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
