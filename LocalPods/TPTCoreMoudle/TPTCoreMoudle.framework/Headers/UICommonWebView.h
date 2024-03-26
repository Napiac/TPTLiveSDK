//
//  UICommonWebView.h
//  TPTCoreMoudle
//
//  Created by 田建波 on 2022/9/22.
//

// 自定义Webview
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "UICommonWebGeneralProtocol.h"
#import "UICommonEaseOutModal.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICommonWebView : UIView

@property(nonatomic, copy)NSString * webURLString;

@property(nonatomic, weak)id<UICommonWebGeneralProtocol> webGeneralProtocol;

@property(nonatomic, strong, readonly)WKWebView * webView;

- (instancetype)initWebGeneralProtocol:(id<UICommonWebGeneralProtocol>)webGeneralProtocol;

/// 禁用刷新
- (void)banrefresh;
/// 使用缓存
- (void)usewebcacheWebView;
@end

NS_ASSUME_NONNULL_END
