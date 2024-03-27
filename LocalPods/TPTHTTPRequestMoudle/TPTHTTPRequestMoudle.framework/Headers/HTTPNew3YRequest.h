//
//  HTTPDataNewCenterRequest.h
//  TPTHTTPRequestMoudle
//
//  Created by nicecheo on 2022/11/25.
//

#import <TPTHTTPRequestMoudle/TPTHTTPRequestMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPNew3YRequest : HTTPCommonRequest
+ (instancetype)requestWithRequestURLPath:(nullable NSString *)requestURLPath
                           bodyParameters:(nullable NSDictionary *)bodyParams;
@end

NS_ASSUME_NONNULL_END
