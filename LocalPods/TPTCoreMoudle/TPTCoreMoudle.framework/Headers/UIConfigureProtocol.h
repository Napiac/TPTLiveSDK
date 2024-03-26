//
//  ControllerConfigureProtocol.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

/// 导航栏参数结构体
typedef struct NavgationBarSubviewsSetupStruct {
    /// Default: 白色
    UIColor * _Nullable barBackgroundColor;
    /// Default: 333333
    UIColor * _Nonnull barTextColor;
    /// Default: bold-18
    UIFont * _Nonnull barTextFont;
} NavgationBarSubviewsSetupStruct;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UIConfigureProtocol <NSObject>

@optional


/// 取消右滑返回手势 Default:NO
- (BOOL)cancelBackPanGesture;
/// 隐藏导航栏 Default:NO
- (BOOL)navigationBarHidden;
/// 隐藏导航栏上的返回按钮 Default:NO
- (BOOL)navigationBarBackButtonHidden;


///导航栏返回按钮的图片 Default: [UIImage imageWithName:@"core_icon_nav_back_gray"]
- (UIImage *)navigationBarBackButtonImage;
///导航栏返回按钮默认事件
- (void)navigationBarBackButtonDefaultEvent;
///导航栏返回按钮的事件 
- (SEL _Nullable)navigationBarBackButtonSEL;
/// 自定义设置导航栏 Default: NO
- (BOOL)customSetupNavgationBarSubviews;
/// 设置导航栏的参数
- (NavgationBarSubviewsSetupStruct)navigationBarSetupStruct;


///状态栏Style Default:UIStatusBarStyleDefault
- (UIStatusBarStyle)statusBarStyle;


/// 选中对应TabbarItem的时候Tabbar是否使用黑色模式
/// return 0/NO 半透明白色
/// return 1/YES 全黑色
/// return 2 半透明黑色
- (int)tabbarItemUseBlackMode;

/// 给NavigationBar添加分割线
/// @param color 分割线颜色 Default:#EEEEEE
- (UIView *)navigationBarAddDivideLineWithBackgroundColor:(UIColor * _Nullable)color;
/// 移除分割线
- (void)navigationBarRemoveDivideLine;


/// 更新view高度
/// @param height 高度
/// @param bottomHeight 底部安全区高度
- (void)updateViewHeight:(CGFloat)height
        safeBottomHeight:(CGFloat)bottomHeight;

/// 更新内容区域顶部内边距
/// @param topPading  顶部内边距
- (void)updateViewContentTopPading:(CGFloat)topPading;

@end

NS_ASSUME_NONNULL_END
