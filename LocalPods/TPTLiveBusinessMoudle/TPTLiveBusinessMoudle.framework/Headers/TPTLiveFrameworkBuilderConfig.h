//
//  TPTLiveFrameworkBuilderConfig.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/20.
//  直播间SDK配置参数

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkBuilderConfig : NSObject

/// 渠道标识
@property(nonatomic, copy)NSString * partnerKey;
/// 渠道加密串
@property(nonatomic, copy)NSString * partnerSecret;
/// 渠道使用的Api
@property(nonatomic, copy)NSString * partnerApiHost;

/// 腾讯产品License
@property(nonatomic, copy)NSString * tencentLicenseURL;
@property(nonatomic, copy)NSString * tencentLicenseKey;

/// 用户在直播间中点击充值的事件
/// 当UINavigationController有值时，请使用UINavigationController来跳转
/// sender = 充值事件的响应View
@property(nonatomic, copy)void (^rechargeEventHandler)(UINavigationController * _Nullable navigationController, UIView * _Nullable sender);

@end

NS_ASSUME_NONNULL_END
