//
//  GeneralWebSocket.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/2/7.
//

/// 直播间WebSocket
#import <Foundation/Foundation.h>
#import "GeneralWebSocketResponse.h"


/// WebSocket消息Type关键字
FOUNDATION_EXPORT NSString * _Nullable const kGeneralWSMessageTypeKeywords;

/// WebSocket消息Data关键字
FOUNDATION_EXPORT NSString * _Nullable const kGeneralWSMessageResponseKeywords;

@class GeneralWebSocketClient;
NS_ASSUME_NONNULL_BEGIN

@protocol GeneralWebSocketClientDelegate <NSObject>

/// ws链接成功
- (void)socketDidOpen:(GeneralWebSocketClient *)socket;

/// ws链接失败
- (void)socket:(GeneralWebSocketClient *)socket didFailWithError:(NSError *)error;

/// ws收到消息
- (void)socket:(GeneralWebSocketClient *)socket receiveResponse:(GeneralWebSocketResponse *)response;

@end

@interface GeneralWebSocketClient : NSObject

@property(nonatomic, weak)id <GeneralWebSocketClientDelegate> delegate;

+ (instancetype)socketURLString:(NSString *)URLString;

- (void)closeSocket;
- (void)sendMessage:(NSDictionary *)message;

@end

NS_ASSUME_NONNULL_END
