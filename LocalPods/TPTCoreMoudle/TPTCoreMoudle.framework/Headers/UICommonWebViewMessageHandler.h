//
//  UICommonWebViewMessageHandler.h
//  TPTAppIndependentMoudle
//
//  Created by 田建波 on 2022/9/21.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "UICommonWebGeneralProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * UICommonWebJavascriptAction;

FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_SHARE; /// 分享
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_GUIZU_INFO; /// 购买贵族
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_TO_PERSON; /// 进入用户个人中心
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_VERIFY; /// 验证用户身份
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_TO_LIVEROOM; /// 进入直播间
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REMOVE_HISTORY; /// 清除Web和Cookie缓存
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_OPEN_LIVE; /// 去开播(主播)
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_ASPHP; /// 使用约定好的参数来跳转
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_CLOSEWEB; /// 关闭当前WebView
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_FILLET_RADIUS; /// 给WebView切圆角
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_GET_BARHEIGHT; /// 将导航栏高度传给WebView
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_TOPBAR_COLOR; /// 当前界面需要的状态栏颜色
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_APP_LOGIN; /// H5调用半屏登录的Pop
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_BINDZFB; /// 绑定支付宝
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_OPEN_BANKLIST; /// 打开银行卡列表
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_GUARD_SUCCESS; /// 购买守护成功
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_OPEN_SIGN; /// 打开签到Pop
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_updata; /// 绑定商品代言成功通知
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_PAYSGO_PAGE; /// 绑定商品代言成功通知
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_ISLOGIN; /// 当前用户是否登录
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_CART_COUNT; /// H5购物车数量发生变化通知
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_BOTTOM_SAFEHEIGHT; /// 获取底部安全区域高度
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_REQUEST_SELECTTABBARITEM; ///切换tabbarItem 选中
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_Fetch_VIPProduct; ///获取VIP列表数据
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_Buy_VIPProduct; ///购买VIP
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_To_UserMessage; ///去用户私聊界面
FOUNDATION_EXTERN UICommonWebJavascriptAction UICOMMONWEB_JS_ACTION_Save_Image; ///保存图片

@protocol UICommonWebJavascriptHandler <NSObject>
@optional;

@property(nonatomic, weak)id<UICommonWebGeneralProtocol> process;

+ (instancetype)handlerWithGeneralProtocol:(id<UICommonWebGeneralProtocol>)genProtocol;

- (UICommonWebJavascriptAction)action;

- (void)onReceiveScriptMessage:(WKWebView *)webView forJavasriptParams:(id)params;

@end



@interface UICommonWebViewMessageHandler : NSObject<WKScriptMessageHandler>

@property(nonatomic, weak)WKWebView * webView;

@property(nonatomic, strong, readonly)NSMutableArray<id<UICommonWebJavascriptHandler>> * jsHandlerList;

- (void)registeJavascriptHandler:(id<UICommonWebJavascriptHandler>)javascriptHandler;

@end

NS_ASSUME_NONNULL_END
