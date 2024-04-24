//
//  TPTSettingConsumptionModeViewController.h
//  TPTLiveSDK_Example
//
//  Created by Napiac on 2024/4/23.
//  Copyright © 2024 Napiac. All rights reserved.
//

#import <TPTCoreMoudle/TPTCoreMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTSettingConsumptionModeViewController : UICommonViewController
@property(nonatomic, assign)NSString * channelUserId;
@property(nonatomic, copy)void (^complate)();

@end

NS_ASSUME_NONNULL_END
