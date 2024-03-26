//
//  TPTWebSocketRequestHandler.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/10.
//  Copyright © 2023 Napiac. All rights reserved.
//  处理Request-返回Response

#import <Foundation/Foundation.h>
@class GCDWebServerRequest;
@class GCDWebServerResponse;
NS_ASSUME_NONNULL_BEGIN

@interface TPTWebSocketRequestHandler : NSObject

+ (GCDWebServerResponse *)handlerRequest:(GCDWebServerRequest *)request;
@end

NS_ASSUME_NONNULL_END
