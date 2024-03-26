//
//  GCDLocalWebSocket.h
//  GCDWebServer (Mac)
//
//  Created by Napiac on 2023/6/10.
//

#import <Foundation/Foundation.h>
@class GCDWebServer;

NS_ASSUME_NONNULL_BEGIN

@protocol GCDLocalWebSocketDelegate <NSObject>

- (void)webSocketDidClose;

@end



@interface GCDLocalWebSocket : NSObject

@property(nonatomic, weak)id<GCDLocalWebSocketDelegate> webSocketDelegate;
+ (BOOL)isWebSocketRequest:(NSDictionary *)requestHeaders;

- (instancetype)initWithServer:(GCDWebServer *)server
                requestMessage:(CFHTTPMessageRef)requestMessage
                        socket:(CFSocketNativeHandle)socket;
- (void)sendMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
