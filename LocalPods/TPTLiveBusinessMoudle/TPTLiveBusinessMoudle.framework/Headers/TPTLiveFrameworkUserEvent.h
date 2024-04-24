//
//  TPTLiveFrameworkUserEvent.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/20.
//  渠道侧用户事件

#import <Foundation/Foundation.h>
#import "TPTLiveFrameworkDefine.h"

@class TPTLiveFrameworkUserInParam;

NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkUserEvent : NSObject


/// 渠道用户登录 - 自行判断网络权限
/// - Parameters:
///   - inParam: TPTLiveFrameworkUserInParam
+ (void)channelUserLoginWithInParam:(TPTLiveFrameworkUserInParam *)inParam
                            handler:(void (^) (TPTLiveFrameworkCode code, NSString * _Nullable message))handler;


/// 渠道用户退出登录 - 在宿主APP中用户退出时调用
+ (void)channelUserLogout;

@end

NS_ASSUME_NONNULL_END
