//
//  RouteRequest.h
//  RouterKit
//
//  Created by Napiac on 2022/12/5.
//

#import <Foundation/Foundation.h>
@class RouteRequestParam;
NS_ASSUME_NONNULL_BEGIN

@interface RouteRequest : NSObject
@property(nonatomic, strong, readonly, nullable)NSString * requestPath;
@property(nonatomic, strong, readonly, nullable)RouteRequestParam * parameters;

- (nullable instancetype)initWithPath:(NSString *)requestPath
                           parameters:(nullable RouteRequestParam *)parameters;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;
@end

@interface RouteRequest (CreateByURL)
@property(nonatomic, strong, readonly, nullable)NSURL * originalURL;
- (nullable instancetype)initWithURL:(NSURL *)URL;
- (void)setValue:(nullable id)value forParameterKey:(NSString *)key;
- (void)addParameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
