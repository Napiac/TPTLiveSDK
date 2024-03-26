//
//  FlowMoulde.h
//  TPTFlowObjectMoulde
//
//  Created by wangyin on 2022/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlowMoulde : NSObject

/// 设置腾讯云鉴权
+ (void)initTXLiveSDKWithLicence:(NSString *)licence
                             key:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
