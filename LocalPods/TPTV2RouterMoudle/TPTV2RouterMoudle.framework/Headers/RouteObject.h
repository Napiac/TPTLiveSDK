//
//  RouteObject.h
//  RouterKit
//
//  Created by Napiac on 2022/12/17.
//

#import <Foundation/Foundation.h>
#import "RouteHandler.h"

typedef void(^CreateInstanceHandler)(RouteRequest * _Nullable request, CompletionHandler _Nullable completionHandler);

NS_ASSUME_NONNULL_BEGIN

@interface RouteObject : NSObject
@property(nonatomic, copy, readonly)NSArray<NSString *> *paths;

- (nullable instancetype)initWithPath:(NSString *)path
                              handler:(CreateInstanceHandler)handler;

- (nullable instancetype)initWithPaths:(NSArray<NSString *> *)paths
                               handler:(CreateInstanceHandler)handler;

@end


@interface RouteObject (Private)

- (void)instanceWithRequest:(RouteRequest *)request
          completionHandler:(nullable CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
