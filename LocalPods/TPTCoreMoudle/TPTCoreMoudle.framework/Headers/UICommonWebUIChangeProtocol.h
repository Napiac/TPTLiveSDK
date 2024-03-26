//
//  UICommonWebUIChangeProtocol.h
//  TPTAppIndependentMoudle
//
//  Created by 田建波 on 2022/9/23.
//

#import <Foundation/Foundation.h>
#import "UICommonEaseOutModal.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UICommonWebUIChangeProtocol <NSObject>
@optional;

/// 设置title
- (void)resetTitle:(NSString * _Nullable)title;
/// 关闭webView
- (void)closeWebView;
/// 设置状态栏颜色 isWhite：YES：白色   NO：黑色
- (void)setWebStatusBarColor:(BOOL)isWhite;
/// web进入的方向
- (void)webShowFrom:(UICommonModalFrom)from;
/// 边距设置，为edge和height综合判断出的结果
- (void)setWebEdge:(UIEdgeInsets)edge;
/// 设置圆角，如果只有一个值，则直接设置；如果有4个值，则分别设置4个方向圆角
- (void)setWebCirculars:(NSArray *)circulars;
/// 设置弹框背景view的颜色和透明度
- (void)setEaseOutModalInWebShadeWithColor:(UIColor *)color andAlpha:(CGFloat)alpha;
/// 设置WebView背景色
- (void)setWebViewBackgroundColor:(UIColor *)color andAlpha:(CGFloat)alpha;
/// 添加返回按钮
- (void)addTopBackButton;
/// 添加分享按钮
- (void)addTopShareButton;
/// 隐藏导航栏
- (void)hideTopNavigaionBar;
/// 存在底部导航
- (void)haveBottomTabbar;
/// 透明的web
- (void)usealphaWebView;
/// 禁用刷新
- (void)banrefreshWebView;
/// 使用缓存
- (void)usewebcacheWebView;
/// 加载失败
- (void)webViewDidFail:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
