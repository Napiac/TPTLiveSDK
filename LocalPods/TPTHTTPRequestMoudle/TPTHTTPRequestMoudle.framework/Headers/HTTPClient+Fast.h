//
//  HTTPClient+Fast.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import "HTTPClient.h"
#import "ConfigureConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient (Fast)

/// Default-Host Post请求
- (HTTPCommonRequest *)postRequestWithParameters:(nullable NSDictionary *)parameters
                                   resultHandler:(nullable HTTPRequestHandler)resultHandler;

/// DataCenter-Host Post请求
- (HTTPCommonRequest *)dataCenterPostRequestWithRequestURLPath:(nullable NSString *)requestURLPath
                                               queryParameters:(nullable NSDictionary *)queryParams
                                                bodyParameters:(nullable NSDictionary *)bodyParams
                                                 resultHandler:(nullable HTTPRequestHandler)resultHandler;

/// New3Y-HOST Post请求
- (HTTPCommonRequest *)new3YPostRequestWithRequestURLPath:(nullable NSString *)requestURLPath
                                           bodyParameters:(nullable NSDictionary *)bodyParams
                                            resultHandler:(nullable HTTPRequestHandler)resultHandler;

/// Post上传文件
- (HTTPCommonRequest *)postRequestWithHostSource:(HostSource)source
                                  requestURLPath:(nullable NSString *)requestURLPath
                                 queryParameters:(nullable NSDictionary *)queryParams
                                  bodyParameters:(nullable NSDictionary *)bodyParams
                         constructingBodyHandler:(nullable AFConstructingBlock)constructingBodyHandler
                           uploadProgressHandler:(nullable AFURLSessionTaskProgressBlock)uploadProgressHandler
                                   resultHandler:(nullable HTTPRequestHandler)resultHandler;


/// 文件上传OSS
/// @param ossConifg oss配置
/// @param fileDatas 多文件 NDatas
/// @param pathDatas 文件上传路径
/// @param upProgress  上传进度
/// @param resultHandler 结果回调
- (void)uploadFileToOSSWithOSSConifg:(HTTPOSSConfigStruct)ossConifg
                           fileDatas:(NSArray<NSData *>*)fileDatas
                        ossPathDatas:(NSArray <NSString *>*)pathDatas
                          upProgress:(void(^)(CGFloat progress))upProgress
                       resultHandler:(void (^)(BOOL result, NSString *filePath))resultHandler;

@end

NS_ASSUME_NONNULL_END
