//
//  UIGeneralRouterSend.h
//  AFNetworking
//
//  Created by Napiac on 2023/3/2.
//

#import <Foundation/Foundation.h>
@class RouteRequestParam;

typedef void(^HTTPRequestHandler)(id _Nullable response);

NS_ASSUME_NONNULL_BEGIN

/// wechat 分享
/// @param title 标题
/// @param description 描述
/// @param openUrl 分享链接
/// @param scene 场景 0 好友列表 1朋友圈
/// @param imgData 封面图
void UIGeneral_StartWechatShareWithParams(NSString * _Nullable title,
                                          NSString * _Nullable description,
                                          NSString * _Nullable openUrl,
                                          int scene,
                                          NSData *imgData);

/// 发送请求
/// - Parameter param: 请求参数
void UIGeneral_New3YHTTPReuqest(RouteRequestParam * param, HTTPRequestHandler handler);


NS_ASSUME_NONNULL_END
