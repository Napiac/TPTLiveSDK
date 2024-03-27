//
//  HTTPClient+Log.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/7/28.
//

#import <TPTHTTPRequestMoudle/HTTPClient.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient (Log)

- (void)requestLogStart:(HTTPCommonRequest *)request;
- (void)requestLogEnd:(HTTPCommonRequest *)request;


- (void)batchReuqestLogStart:(HTTPBatchRequest *)batchRequest;
- (void)batchReuqestLogEnd:(HTTPBatchRequest *)batchRequest;
@end

NS_ASSUME_NONNULL_END
