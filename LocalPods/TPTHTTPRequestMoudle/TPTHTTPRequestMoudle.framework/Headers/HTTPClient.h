//
//  HTTPClient.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestLogProtocol.h"
#import "HTTPCommonRequest.h"
#import "HTTPResponse.h"

@class HTTPBatchRequest;
@class OSSClient;

typedef void (^HTTPRequestHandler) (HTTPResponse * __nullable response);
typedef void (^BatchHTTPRequestHandler)(HTTPBatchRequest * __nullable batchRequest,
                                        NSArray * __nullable successs,
                                        HTTPCommonRequest * __nullable fails);


typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    ///未知
    NetworkReachabilityStatus_Unknown = 0,
    ///无网络
    NetworkReachabilityStatus_NotReachable = 1,
    ///蜂窝网络
    NetworkReachabilityStatus_WWAN = 2,
    ///WIFI
    NetworkReachabilityStatus_WiFi = 3,
};


/// OSS参数结构体
typedef struct HTTPOSSConfigStruct {
    NSString * _Nonnull accessKey;
    NSString * _Nonnull secretKey;
    NSString * _Nonnull bucketname;
    NSString * _Nonnull endpoint;
} HTTPOSSConfigStruct;

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient : NSObject
///网络状态
@property(nonatomic, assign)NetworkReachabilityStatus reachabilityStatus;
///所有请求的Log
@property(nonatomic, strong, nullable)id <RequestLogProtocol> logUtils;
///可以单独设置某个请求的Log
@property(nonatomic, weak)id <RequestLogProtocol> requestLogUtils;
///OSSClient
@property(nonatomic, strong)OSSClient * ossClient;

+ (instancetype)shared;

- (void)sendRequest:(HTTPCommonRequest *)request
            handler:(HTTPRequestHandler)handler;



/// 下载文件
/// @param fileURLString 文件下载地址
/// @param progressHandler 进度回调
/// @param resultHandler 结果回调
- (void)downloadFileWithURLString:(NSString *)fileURLString
                 downloadProgress:(void (^) (CGFloat progress))progressHandler
                           result:(void (^) (BOOL result, NSString * filePath))resultHandler;

@end

NS_ASSUME_NONNULL_END
