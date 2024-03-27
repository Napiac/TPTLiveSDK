//
//  HTTPClient+CustomHost.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2023/12/18.
//

#import <TPTHTTPRequestMoudle/TPTHTTPRequestMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient (CustomHost)

@property(nonatomic, copy)NSString * phalApiHost;
@property(nonatomic, copy)NSString * webmanApiHost;

@end

NS_ASSUME_NONNULL_END
