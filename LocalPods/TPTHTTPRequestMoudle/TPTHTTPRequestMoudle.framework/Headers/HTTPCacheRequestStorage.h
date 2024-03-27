//
//  HTTPCacheRequestStorage.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2023/2/2.
//

/// 缓存请求托管类
#import <Foundation/Foundation.h>
@class HTTPCommonRequest;

NS_ASSUME_NONNULL_BEGIN

@interface HTTPCacheRequestStorage : NSObject

+ (instancetype)storage;

/// 添加Request
/// - Parameters:
///   - request: Request
///   - iClass: 使用Request的Class
///   - extra: 额外字段
- (void)addCacheRequest:(HTTPCommonRequest *)request importClass:(Class)iClass;
- (void)addCacheRequest:(HTTPCommonRequest *)request importClass:(Class)iClass extra:(NSString * _Nullable)extra;



/// 获取Request实例
/// - Parameters:
///   - iClass: 使用Request的Class
///   - rClass: Request Class
- (HTTPCommonRequest *)fetchCacheRequestWithRequestClass:(Class)rClass importClass:(Class)iClass;
- (HTTPCommonRequest *)fetchCacheRequestWithRequestClass:(Class)rClass importClass:(Class)iClass extra:(NSString * _Nullable)extra;



/// 清除Reuqest缓存
/// - Parameters:
///   - rClass: Request Class
///   - iClass: 使用Request的Class
- (void)clearRequestCacheWithRequestClass:(Class)rClass importClass:(Class)iClass;
- (void)clearRequestCacheWithRequestClass:(Class)rClass importClass:(Class)iClass extra:(NSString * _Nullable)extra;




/// 清除所有的Request
- (void)clearAllReuqestCache;

@end

NS_ASSUME_NONNULL_END
