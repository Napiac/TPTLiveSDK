//
//  NSError+RouterErrors.h
//  TPTV2RouterMoudle
//
//  Created by Napiac on 2023/2/23.
//

#import <Foundation/Foundation.h>

@class RouteRequest;
@class RouteInterceptor;
NS_ASSUME_NONNULL_BEGIN

@interface NSError (RouterErrors)

/// 无法找到实例Error
/// - Parameter request: 请求
+ (NSError *)notFoundInstanceWithRequest:(RouteRequest *)request;

/// 同步获取实例失败
+ (NSError *)syncInstanceError:(RouteInterceptor * _Nullable)interceptor;


@end

NS_ASSUME_NONNULL_END
