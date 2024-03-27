//
//  HTTPCommonRequest.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/11/23.
//

#import "YTKRequest.h"
#import "ConfigureConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPCommonRequest : YTKRequest
/// Host来源
@property(nonatomic, assign, readonly)HostSource hostSource;
/// BaseURL
@property(nonatomic, copy, readonly, nullable)NSString * baseURL;
/// 请求路径
@property(nonatomic, copy, readonly, nullable)NSString * requestURLPath;
/// 请求方式 Default:YTKRequestMethodPOST
@property(nonatomic, assign, readonly)NSInteger method;

/// Query参数
@property(nonatomic, strong, readonly, nullable)NSMutableDictionary * queryParams;
/// Body参数
@property(nonatomic, strong, readonly, nullable)NSMutableDictionary * bodyParams;


/// 超时时间 Default : 30s
@property(nonatomic, assign, readonly)NSTimeInterval timeoutInterval;
/// 请求头参数
@property(nonatomic, copy, readonly, nullable)NSDictionary * (^requestHeadersParamHandler) (void);

/// 续点下载文件地址
@property(nonatomic, copy, readonly, nullable)NSString * fileResumableDownloadPath;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;


/// Init NOTE:不建议业务方直接调用
/// - Parameters:
///   - source: HOST来源
///   - requestURLPath: 请求路径
///   - queryParams: Query参数
///   - bodyParams: Body参数
///   - method: 请求方法
///   - timeout: 请求超时时间
///   - resumableDownloadPath: 文件下载地址
///   - headersHandler: 请求头
- (instancetype)initWithHostSource:(HostSource)source
                    requestURLPath:(nullable NSString *)requestURLPath
                    queryParamInfo:(nullable NSDictionary *)queryParams
                     bodyParamInfo:(nullable NSDictionary *)bodyParams
                            method:(NSInteger)method
                           timeout:(NSTimeInterval)timeout
             resumableDownloadPath:(nullable NSString *)resumableDownloadPath
                    headersHandler:(nullable NSDictionary* (^) (void))headersHandler;
@end

NS_ASSUME_NONNULL_END
