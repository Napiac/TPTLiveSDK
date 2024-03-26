//
//  UICommonWebGeneralProtocol.h
//  TPTAppIndependentMoudle
//
//  Created by 田建波 on 2022/9/23.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "UICommonWebUIChangeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UICommonWebGeneralProtocol <NSObject>
@required;

/// 能改变WebViewUI的对象
- (id<UICommonWebUIChangeProtocol>)webViewUIChangeProtocol;

/// 当前正在渲染的WebView
- (WKWebView *)fetchCurrentDisplayWebView;

@end

NS_ASSUME_NONNULL_END
