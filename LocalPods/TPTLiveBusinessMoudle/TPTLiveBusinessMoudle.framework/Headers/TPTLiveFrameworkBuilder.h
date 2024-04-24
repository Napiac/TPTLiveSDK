//
//  TPTLiveFrameworkBuilder.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/4.
//  直播间SDK启动、配置Class

#import <Foundation/Foundation.h>
#import "TPTLiveFrameworkUserActivityListener.h"

@class TPTLiveFrameworkBuilderConfig;
@class TPTLiveFrameworkBuilderStyleConfig;
NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkBuilder : NSObject

+ (nullable NSError *)appDidLaunch:(TPTLiveFrameworkBuilderConfig *)builderConfig;
+ (void)setupBuilderStyleConfig:(TPTLiveFrameworkBuilderStyleConfig *)builderStyleConfig;
+ (void)setupUserActivityListener:(id<TPTLiveFrameworkUserActivityListener>)userActivityListener __unused; 


+ (BOOL)canEnterRoom;
+ (void)enterRandomRoomWithParent:(UIViewController *)parent
                        eventView:(nullable UIView *)senderView
                           result:(void (^) (NSError * _Nullable error))handler;



+ (nullable TPTLiveFrameworkBuilderConfig *)previousConfig;
+ (nullable TPTLiveFrameworkBuilderStyleConfig *)previousStyleConfig;



+ (NSString *)sdkVersion;
@end

NS_ASSUME_NONNULL_END
