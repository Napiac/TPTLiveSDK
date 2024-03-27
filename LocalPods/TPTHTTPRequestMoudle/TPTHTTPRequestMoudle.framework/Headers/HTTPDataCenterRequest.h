//
//  HTTPDataCenterRequest.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/11/23.
//

#import "HTTPCommonRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPDataCenterRequest : HTTPCommonRequest

+ (instancetype)requestWithRequestURLPath:(nullable NSString *)requestURLPath
                          queryParameters:(nullable NSDictionary *)queryParams
                           bodyParameters:(nullable NSDictionary *)bodyParams;

@end

NS_ASSUME_NONNULL_END
