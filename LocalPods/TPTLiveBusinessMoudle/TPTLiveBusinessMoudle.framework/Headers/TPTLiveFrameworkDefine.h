//
//  TPTLiveFrameworkDefine.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger TPTLiveFrameworkCode;

static TPTLiveFrameworkCode SDKOKCode = 0;

/// 参数错误
static TPTLiveFrameworkCode SDKParamsErrorCode = -1;

/// 初始化错误
static TPTLiveFrameworkCode SDKInitErrorCode = -2;

/// 登录错误
static TPTLiveFrameworkCode SDKUserLoginErrorCode = -3;

/// 网络错误
static TPTLiveFrameworkCode SDKNetworkReachabilityErrorCode = -4;

/// 进入房间错误
static TPTLiveFrameworkCode SDKEnterRoomErrorCode = -5;

NS_ASSUME_NONNULL_END
