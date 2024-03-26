//
//  FlowLivePlayer.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/8/31.
//


/// 腾讯直播播放器
#import <Foundation/Foundation.h>
#import "FlowPlayerMedia.h"

@class V2TXLivePlayer;
NS_ASSUME_NONNULL_BEGIN

@interface FlowLivePlayer : NSObject <FlowPlayerMedia>
@property(nonatomic, strong, readonly, nullable)V2TXLivePlayer * v2LivePlayer;
@end

NS_ASSUME_NONNULL_END
