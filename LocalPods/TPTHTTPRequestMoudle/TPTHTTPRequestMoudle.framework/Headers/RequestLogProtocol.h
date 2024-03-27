//
//  RequestLogProtocol.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//

#import <Foundation/Foundation.h>

@class YTKBaseRequest;
NS_ASSUME_NONNULL_BEGIN

@protocol RequestLogProtocol <NSObject>

- (void)logStartRequest:(YTKBaseRequest *)request;
- (void)logEndRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
