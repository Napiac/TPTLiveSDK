//
//  AddRouteManager.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2022/9/14.
//

/// 打开原生页面
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_Appjump;

/// 执行指定方法
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_DoFunction;

/// 打开网页
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_Webview;

/// 用safari打开网页
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_Browser;

/// 在当前界面直接弹一个透明的webview
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_Webtk;

/// 进入主播直播间
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_RoomJoin;

/// 打电话
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_CallMobile;

/// 分享
FOUNDATION_EXPORT NSString * _Nullable const kAdd_AppOpenType_Share;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 广告路由管理
@interface AddRouteManager : NSObject


/// 根据参数取得路由目标对象 或 执行对应方法
/// @param appOpen 打开方式
/// @param url 跳转地址
+ (nullable NSObject *)creatObjectWithAppOpen:(NSString *)appOpen
                                      jumpUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
