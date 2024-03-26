//
//  TPTLiveFrameworkBuilder.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/4.
//

#import <Foundation/Foundation.h>
@class TPTLiveFrameworkBuilderConfig;
NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkBuilder : NSObject

+ (nullable NSError *)appDidLaunch:(TPTLiveFrameworkBuilderConfig *)builderConfig;
+ (nullable NSError *)enterRandomRoomWithParent:(UIViewController *)parent
                                      eventView:(nullable UIView *)senderView;

+ (nullable TPTLiveFrameworkBuilderConfig *)previousConfig;

+ (BOOL)canEnterRoom;

+ (NSString *)sdkVersion;
@end

NS_ASSUME_NONNULL_END
