//
//  RouterHandler.h
//  RouterKit
//
//  Created by Napiac on 2022/12/5.
//

#import <Foundation/Foundation.h>

@class UIViewController, RouterKit, RouteRequest, RouteObject;
typedef void(^CompletionHandler)(id _Nullable result,
                                 RouteRequest * _Nullable xRequest,
                                 NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@protocol RouteInMultiPathHandler <NSObject>
@optional

/// 多路径
+ (NSArray <NSString *> *)multiRoutePath;


/// 获取某个实例
/// 当调用RouterKit的`-instanceWithRequest:completionHandler:`时, RouterKit将通过对应的`handler`调用到此方法
/// - Parameters:
///   - request: 请求
///   - completionHandler: 回调
+ (void)instanceWithRequest:(RouteRequest *)request
          completionHandler:(nullable CompletionHandler)completionHandler;



/// 同步获取某个实例
/// - Parameter request: RouteRequest
+ (NSObject *)syncInstanceWithRequest:(RouteRequest *)request;

@end


@protocol RouteHandler <NSObject, RouteInMultiPathHandler>
@optional
+ (void)addRouteToRouter:(RouterKit *)router;
@end

NS_ASSUME_NONNULL_END
