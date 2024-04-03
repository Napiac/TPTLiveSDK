//
//  GeneralWSUtil.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/2/7.
//

#import <Foundation/Foundation.h>
#import "GeneralWebSocketClient.h"

NS_ASSUME_NONNULL_BEGIN

@class GeneralWebSocketResponse;
@class RouteRequest;

@interface GeneralWSUtil : NSObject

/// 大厅Ws单例
+ (GeneralWSUtil *)sharedUtil;

/// 链接tcp
/// @param url 服务
- (void)connectServiceUrl:(NSString *)url;

/// 发送map消息
/// @param parmas message
- (void)sendDictionaryMessage:(NSDictionary *)parmas;

/// 添加ws消息订阅者
/// @param listener ws消息订阅对象
- (void)addWsListener:(id <GeneralWebSocketClientDelegate>)listener;

/// 移除
/// @param listener  listener
- (void)removeWsListener:(id <GeneralWebSocketClientDelegate>)listener;

@end

NS_ASSUME_NONNULL_END
