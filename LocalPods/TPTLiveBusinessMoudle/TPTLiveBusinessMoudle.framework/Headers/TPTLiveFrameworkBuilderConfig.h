//
//  TPTLiveFrameworkBuilderConfig.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkBuilderConfig : NSObject

/// 渠道标识
@property(nonatomic, copy)NSString * partnerKey;

@property(nonatomic, copy)NSString * apiHost;

@property(nonatomic, copy)void (^rechargeEventHandler)(UIView * sender);
@end

NS_ASSUME_NONNULL_END
