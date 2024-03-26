//
//  UICommonEaseOutModal.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

///弹出VIew基础类
#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kUICommonEaseOutModalAnimationDuration;

typedef void(^UICommonModalDismissHandler)(void);

typedef NS_ENUM(NSInteger, UICommonModalFrom) {
    UICommonModalFromCenter,
    UICommonModalFromTop,
    UICommonModalFromBottom,
    UICommonModalFromLeft,
    UICommonModalFromRight
};

NS_ASSUME_NONNULL_BEGIN

@interface UICommonEaseOutModal : UIView
@property(nonatomic, strong)UIView * contentView;
/** contentView的大小 Default: 100,100*/
@property(nonatomic, assign)CGSize contentSize;
/** 点击其他区域是否dismiss Default:YES*/
@property(nonatomic, assign)BOOL tapOutsideToDismiss;

+ (instancetype)easeOut;

- (void)onContentLayout;

/// showFrom中的dismissBlock与dismiss方法的dismissBlock作用域相同，同时只能使用一个
- (void)showFrom:(UICommonModalFrom)from;
- (void)showFrom:(UICommonModalFrom)from
       inAddView:(UIView * __nullable)addView;
- (void)showFrom:(UICommonModalFrom)from
       inAddView:(UIView * __nullable)addView
         dismiss:(UICommonModalDismissHandler __nullable)dismissHandler;

- (void)dismiss;
- (void)dismiss:(UICommonModalDismissHandler __nullable)dismissHandler;
@end


@interface NSObject (UICommonEaseOutModal)
- (UIView *)fetchKeyWindow;

/** 查找EaseOutModal*/
- (UICommonEaseOutModal *)fetchEaseOutModal;
- (UICommonEaseOutModal *)fetchEaseOutModalInAddView:(UIView *)view;
- (UICommonEaseOutModal *)fetchEaseOutModalInAddView:(UIView *)view andModalClass:(Class)cls;
/** 是否存在EaseOutModal*/
- (BOOL)existEaseOutModal;
- (BOOL)existEaseOutModalInAddView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END

