//
//  HTTPDefaultRequest.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import "HTTPCommonRequest.h"
#import "ConfigureConst.h"

@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;

NS_ASSUME_NONNULL_BEGIN

@interface HTTPDefaultRequest : HTTPCommonRequest


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;


+ (instancetype)requestWithParamInfo:(NSDictionary * __nullable)param;

+ (instancetype)requestWithParamInfo:(NSDictionary * __nullable)param
                             timeout:(NSTimeInterval)timeout;

@end

NS_ASSUME_NONNULL_END
