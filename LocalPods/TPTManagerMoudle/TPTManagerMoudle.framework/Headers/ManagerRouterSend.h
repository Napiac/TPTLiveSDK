//
//  ManagerRouterSend.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2023/2/28.
//

#import <Foundation/Foundation.h>
@class RouteRequestParam;
typedef void(^HTTPRequestHandler)(id _Nullable response);

NS_ASSUME_NONNULL_BEGIN
/// 发送Default模式请求
/// - Parameter param: 请求参数
void ManagerRouterSend_DefaultHTTPReuqest(RouteRequestParam * param,HTTPRequestHandler handler);

/// 发送New3Y模式请求
/// - Parameters:
///   - param: 请求参数
///   - handler: 回调
void ManagerRouterSend_New3YHTTPRequest(RouteRequestParam * param, HTTPRequestHandler handler);

/// 显示Toast
/// - Parameter toast: 文字
void MessageRouterSend_ShowToast(NSString * toast);



/// 获取应用程序的Window
UIView * _Nullable MessageRouterSend_FetchApplicationWindow (void);


/// 显示Loading
/// - Parameters:
///   - status: YES：显示 NO:隐藏
///   - loadingText: 显示的文字
void MessageRouterSend_LoadingAction(BOOL status, NSString * _Nullable loadingText);


/// 开播
void ManagerRouterSend_StartLive(void);

/// 内购成功后通知Vue的通知名
NSString * _Nullable MessageRouterSend_IAPSuccessCallbackVueNotifierName(void);


/// 数据JSON操作
/// - Parameters:
///   - object: 数据
///   - type: 查看Core/Json
NSObject * _Nullable MessageRouterSend_Json(id object, NSInteger type);


/// 打开WebController
/// - Parameters:
///   - type: 0:打开WebController 1:打开WebModal
///   - webURLPath: URL
UIViewController * _Nullable MessageRouterSend_OpenWeb(NSInteger type, NSString * webURLPath);

/// 调用分享
/// @param shareTitle 分享标题
/// @param shareDesc 分享描述
/// @param sharePath 分享链接
/// @param shareImage 分享图片地址
/// @param shareType 分享类型
/// @param shareID 分享数据ID
NSObject * MessageRouterSend_Share(NSString * shareTitle,
                             NSString * shareDesc,
                             NSString * sharePath,
                             id shareImage,
                             NSString *shareType,
                                   NSString *shareID);


/// 获取观众端直播间
/// @param userId 主播的UserId
/// @param keyword 进房来源
/// @param userCoverURLPath 主播的封面
UIViewController * _Nullable MessageRouterSend_FetchViewerController(NSString * userId,
                                                                     NSString * _Nullable keyword,
                                                                     NSString * _Nullable userCoverURLPath);


/// 获取用户是否在通话中
BOOL MessageRouterSend_FetchUserVoiceStatus(void);




/// AES解密
/// @param encrypedText 加密后的字符串
/// @param key 密钥
NSString * MessageRouterSend_AESDecrypted(NSString *encrypedText, NSString * key);



/// 用户退出登录
void MessageRouterSend_UserLogout(void);
NS_ASSUME_NONNULL_END
