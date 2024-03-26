//
//  RouterKit.h
//  RouterKit
//
//  Created by Napiac on 2022/12/5.
//

/// URLPath 路由Kit
#import <Foundation/Foundation.h>
#import "RouteHandler.h"
@class RouteInterceptor;
NS_ASSUME_NONNULL_BEGIN

@interface RouterKit : NSObject



+ (instancetype)shared;


+ (void)registerRouter;


/// 获取某个实例
/// - Parameters:
///   - request: RouteRequest
///   - completionHandler: 回调
- (void)instanceWithRequest:(RouteRequest *)request
          completionHandler:(nullable CompletionHandler)completionHandler;



/// 同步获取某个实例
/// NOTE:同步获取实例必须遵守RouteInMultiPathHandler协议
/// - Parameter request: RouteRequest
- (NSObject *)syncInstanceWithRequest:(RouteRequest *)request;


/// 是否可以处理某个路径
/// - Parameter routePath: 路径
- (BOOL)canHandleRoutePath:(NSString *)routePath;


/// 手动添加路由
/// NOTE:为保证线程安全应该在`+addRoutesToRouter:`中调用该方法
/// - Parameter object: RouteObject
- (void)addRoute:(RouteObject *)object;
@end



@interface RouterKit (RouteInterceptorExtended)

/// 添加拦截器
/// - Parameter interceptor: RouteInterceptor
- (void)addInterceptor:(RouteInterceptor *)interceptor;
@end

NS_ASSUME_NONNULL_END
