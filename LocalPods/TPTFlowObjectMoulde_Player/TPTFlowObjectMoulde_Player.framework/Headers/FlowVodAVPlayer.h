//
//  FlowVodAVPlayer.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/9/21.
//

/// 系统AVPlayer点播播放器
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FlowPlayerMedia.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlowVodAVPlayer : NSObject<FlowPlayerMedia>

@property(nonatomic, strong, readonly, nullable)AVURLAsset * asset;
@property(nonatomic, strong, readonly, nullable)AVPlayerItem * playerItem;
@property(nonatomic, strong, readonly, nullable)AVPlayer * player;

@end

NS_ASSUME_NONNULL_END
