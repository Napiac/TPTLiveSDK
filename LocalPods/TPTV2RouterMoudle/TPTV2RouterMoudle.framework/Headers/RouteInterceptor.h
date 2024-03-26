//
//  RouteInterceptor.h
//  RouterKit
//
//  Created by Napiac on 2023/2/14.
//

/// 路由拦截器
#import <Foundation/Foundation.h>
#import "RouteHandler.h"

typedef NS_ENUM(NSInteger, RouterInterceptionPolicy) {
    RouterInterceptionPolicy_Cancel,
    RouterInterceptionPolicy_Allow
};


typedef void(^RouterInterceptionPolicyDecisionHandler)(RouterInterceptionPolicy policy, RouteRequest * _Nullable previousRequest);
typedef void(^RouteInterceptHandler)(RouteRequest * _Nullable request, RouterInterceptionPolicyDecisionHandler _Nonnull decisionHandler);
NS_ASSUME_NONNULL_BEGIN

@interface RouteInterceptor : NSObject
@property(nonatomic, copy, readonly)NSArray <NSString *> * paths;
@property(nonatomic, copy, readonly)RouteInterceptHandler interceptorHandler;

+ (instancetype)interceptorWithPath:(NSString *)path handler:(RouteInterceptHandler)handler;
+ (instancetype)interceptorWithPaths:(NSArray<NSString *> *)paths handler:(RouteInterceptHandler)handler;
@end

NS_ASSUME_NONNULL_END
