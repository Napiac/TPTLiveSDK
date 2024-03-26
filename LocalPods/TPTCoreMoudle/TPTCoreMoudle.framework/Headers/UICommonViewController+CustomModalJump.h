//
//  UICommonViewController+CustomModalJump.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/8/2.
//

#import "UICommonViewController.h"
#import "UICommonNavigationController.h"

#import <ReactiveObjC/RACSubject.h>

typedef void(^ModalCompletionBlock)(void);
typedef BOOL(^ModalWillDismissBlock)(UICommonNavigationController * _Nullable navigationController);

NS_ASSUME_NONNULL_BEGIN

@interface CustomModalJumpConfig : NSObject

#pragma mark -
#pragma mark - Readonly

/// Root NavigationVC 最外面的导航栏控制器 和屏幕等宽登高
@property(nonatomic, weak, readonly, nullable)UICommonNavigationController * rootNavigationVC;
/// Contnet NavigationVC 显示内容的导航栏控制器
@property(nonatomic, weak, readonly, nullable)UICommonNavigationController * contentNavigationVC;
/// 当前显示的VC
@property(nonatomic, weak, readonly, nullable)UICommonViewController * currentShowVC;


#pragma mark -
#pragma mark - Setup

@property(nonatomic, weak, nullable)UICommonViewController * targetVC;
@property(nonatomic, assign)CGRect frame;
@property(nonatomic, copy)ModalCompletionBlock completionBlock;
@property(nonatomic, copy)ModalWillDismissBlock shouldDisMissBlock;

/// 隐藏NavigationBar Default：NO
@property(nonatomic, assign)BOOL hideNavigation;
/// 半屏弹出蒙板背景色 Default：[[UIColor blackColor]colorWithAlphaComponent:.4]
@property(nonatomic, strong)UIColor *backgroundColor;
/// 点击其他区域是否dismiss Default:YES
@property(nonatomic, assign)BOOL outsideToDismiss;
/// push多次时，返回上级页面 Default YES
@property(nonatomic, assign)BOOL isPopBack;


#pragma mark -
#pragma mark - Event

/// 传参的信号
@property(nonatomic, strong)RACSubject * paramsSubject;

- (void)modalDismiss:(id __nullable)value;

@end










@interface UICommonViewController (CustomModalJump)
@property(nonatomic, strong, nullable)CustomModalJumpConfig * modalConfig;

- (void)modalJump:(CustomModalJumpConfig *)config;
@end

NS_ASSUME_NONNULL_END

