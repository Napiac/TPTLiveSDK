//
//  GeneralWebSocketResponse.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralWebSocketResponse : NSObject
@property(nonatomic, copy)NSString * _Nonnull message;
@property(nonatomic, copy)NSString * _Nonnull type;
@property(nonatomic, copy)NSString * _Nonnull scene;
@property(nonatomic, copy, nullable)NSString *  room_number;

@property(nonatomic, strong)id _Nonnull response;

+ (instancetype)response:(NSDictionary *)params;

- (NSDictionary *)realData;
@end

NS_ASSUME_NONNULL_END
