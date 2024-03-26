//
//  FlowVodPlayer.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/8/31.
//


/// 腾讯点播播放器
#import <Foundation/Foundation.h>
#import "FlowPlayerMedia.h"

@class TXVodPlayer;
NS_ASSUME_NONNULL_BEGIN

@interface FlowVodPlayer : NSObject <FlowPlayerMedia>
@property(nonatomic, strong, readonly, nullable)TXVodPlayer * vodPlayer;
@end

NS_ASSUME_NONNULL_END

